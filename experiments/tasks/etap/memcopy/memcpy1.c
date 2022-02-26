int func1(){
  int arr1[9] = {
      0x0000, 0x07ff, 0x0c00, 0x0800, 0x0200, 0xf800, 0xf300, 0x0400,  0x0400
  };

  return 0;
}

/*
 * time:
 * CALLA   #memcpy  --> 4.02
 * TST.W   R14 --> 000" = distr::Norm(1.02, 0.01)
 * JEQ     (0x005e) --> 2 cycle
 * MOVA    R12,R15 --> 000" = distr::Norm(1.02, 0.01)
 *
 * ADDA    #0x00001,R15 --> "110" = distr::Norm(2.02, 0.01)
 * MOV.B   @R13+,0xffff(R15) --> "111" = distr::Norm(4.02, 0.01)
 * DEC.W   R14  --> 000" = distr::Norm(1.02, 0.01)
 * JNE     (0x0052) --> 2 cycle
 *
 * RETA --> 5 cycle
 *
 * energy:
 * CALLA   #memcpy  --> distr::Norm(10.1, 0.62))
 * TST.W   R14 --> "000" = distr::Norm(4.52, 0.62)
 * JEQ     (0x005e) --> distr::Norm(5.8, 0.62))
 * MOVA    R12,R15 --> "000" = distr::Norm(4.52, 0.62)
 *
 * ADDA    #0x00001,R15 --> "110" = distr::Norm(5.55, 0.62)
 * MOV.B   @R13+,0xffff(R15) --> "111" = distr::Norm(8.34, 0.62)
 * DEC.W   R14  --> "000" = distr::Norm(4.52, 0.62)
 * JNE     (0x0052) --> distr::Norm(5.8, 0.62))
 *
 * RETA --> distr::Norm(10.1, 0.62))
 */

/*
timing$memcpy <- function(x) Norm(mean = 13.06, sd = .01) + x * Norm(mean = 9.06, sd = .01)
energy$memcpy <- function(x) Norm(mean = 35.04, sd = 1.38) + x * Norm(mean = 24.21, sd = 1.24)
*/