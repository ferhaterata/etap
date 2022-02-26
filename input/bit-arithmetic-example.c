// ASCII characters A == a ? 1 : 0
// x -> upper case letters A:Z
// y -> lower case letters a:z
int isSameChar(int x,int y){
#pragma distribution parameter "x <- DiscreteDistribution(supp = 65:90)"
#pragma distribution parameter "y <- DiscreteDistribution(supp = 97:122)"

  int mask=0b00100000;

  if((x^mask) == y){ // prob = 0.04
    return 1;
  }else{            // prob = 0.96
    return 0;
  }
}