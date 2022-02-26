/*

+-------------------+----------------+----+------------------------+
|        div        |      mul       | id |       Probability      |
+-------------------+----------------+----+------------------------+
| reminder is 0     | result is even | 10 |  27/55 * 40/55 = 0.357 |
| reminder is not 0 | result is odd  | 15 |  28/55 * 15/55 = 0.138 |
| reminder is 0     | result is odd  | 14 |  27/55 * 15/55 = 0.133 |
| reminder is not 0 | result is even | 21 |  28/55 * 40/55 = 0.370 |
+-------------------+----------------+----+------------------------+

*/
int foo(int a, int b) {
#pragma distribution parameter "a <- DiscreteDistribution(supp = 0:10)"
#pragma distribution parameter "b <- DiscreteDistribution(supp = 1:5)"
  int multi = a * b;
  float div = a / b;

  if (multi % 2 == 0) { // prob = 0.73
    multi = 2;
  } else {             // prob = 0.27
    multi = 3;
  }
  if (a % b == 0) {   // prob = 0.49
    div = 5;
  } else {            // prob = 0.51
    div = 7;
  }
  int id = div * multi;

  switch(id){
    case 10: return id;
    case 14: return id;
    case 15: return id;
    case 21: return id;
    default: return 0;
  }
}