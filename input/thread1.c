#include "ink.h"

/* -------------------------------------------------------------*/
/* Functions that imitate I/O Operations                        */
/* -------------------------------------------------------------*/

/* imitate sensor read (return a random value) */
unsigned double read_sensor() {
  unsigned int result;
#pragma distribution variable "result <- Norm(mean=10, sd=2)"
  return result;
}

/* imitate time read (return a random elapsed value) */
unsigned double get_time() {
  unsigned int result;
#pragma distribution variable "result <- (mean=10000, sd=2)"
  return result;
}

/* imitate wifi send */
void send_wifi(unsigned int data) {}
/* -------------------------------------------------------------*/

/* Task declarations */
ENTRY_TASK(task_init);
TASK(task_sense);
TASK(task_compute);
TASK(task_send);

#define NUM_SAMPLES 10
#define EXPIRES 10

typedef struct {
  unsigned int value;
  unsigned int timestamp;
} sample_t;

/* task shared variables */
__shared(unsigned int numSamples; sample_t samples[NUM_SAMPLES];
         unsigned int average;);

/* -------------------------------------------------------------*/
/* called at the very first boot (needed by INK)                */
/* -------------------------------------------------------------*/
void thread1_init() {
  // create a thread with priority 15 and entry task t_init
  __CREATE(15, task_init);
  __SIGNAL(15);
}
/* -------------------------------------------------------------*/

/* init the system by setting number of samples to 0 */
ENTRY_TASK(task_init) {
  __SET(numSamples, 0);
  return task_sense;
}

TASK(task_sense) {
  sample_t sample;
  unsigned int numSamples;

  /* sense temperature and assign a timestamp */
  sample.value = read_sensor();
  sample.timestamp = get_time();

  /* read number of samples */
  numSamples = __GET(numSamples);
  /* write the sampled value to the array item */
  __SET(samples[numSamples], sample);
  /* increment the number of samples */
  __SET(numSamples, numSamples + 1);

  return task_compute;
}

TASK(task_compute) {
  sample_t sample;
  unsigned int avg = 0;
  unsigned int i;

  /* if num samples constraint is not satisfied yet, sense more */
  if (__GET(numSamples) < NUM_SAMPLES) return task_sense;

  /* check if the data is expired or not */
  sample = __GET(samples[i]);
  if (get_time() - sample.timestamp > EXPIRES) {
    return task_init;
  }

  /* if everything is fine, calculate the average value of the temperature */
  for (i = 0; i < NUM_SAMPLES; i++) {
    sample = __GET(samples[i]);
    avg += sample.value;
  }

  avg /= NUM_SAMPLES;

  __SET(average, avg);

  return task_send;
}

TASK(task_send) {
  unsigned int avg = __GET(average);
  // send over Wifi...
  send_wifi(avg);

  return task_init;
}
