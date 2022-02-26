pkgname <- "distr"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('distr')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("0distr-package")
### * 0distr-package

flush(stderr()); flush(stdout())

### Name: distr-package
### Title: distr - Object Oriented Implementation of Distributions
### Aliases: distr-package distr
### Keywords: package distribution

### ** Examples

X <- Unif(2,3)
Y <- Pois(lambda = 3)
Z <- X+Y  # generates Law of corresponding independent variables
p(Z)(0.2)
r(Z)(1000)
plot(Z+sin(Norm()))


cleanEx()
nameEx("AbscontDistribution-class")
### * AbscontDistribution-class

flush(stderr()); flush(stdout())

### Name: AbscontDistribution-class
### Title: Class "AbscontDistribution"
### Aliases: AbscontDistribution-class AffLinDistribution-class
###   AffLinAbscontDistribution-class sqrt,AbscontDistribution-method
###   initialize,AbscontDistribution-method
###   initialize,AffLinAbscontDistribution-method
###   sqrt,AbscontDistribution-method
### Keywords: distribution

### ** Examples

N <-  Norm() # N is a normal distribution with mean=0 and sd=1.
E <-  Exp() # E is an exponential distribution with rate=1.
A1 <-  E+1 # a new absolutely continuous distributions with exact slots d, p, q
A2 <-  A1*3 # a new absolutely continuous distributions with exact slots d, p, q
A3 <- N*0.9 + E*0.1 # a new absolutely continuous distribution with approximated slots d, p, q
r(A3)(1) # one random number generated from this distribution, e.g. -0.7150937
d(A3)(0) # The (approximated) density for x=0 is 0.43799.
p(A3)(0) # The (approximated) probability that x <= 0 is 0.45620.
q(A3)(.1) # The (approximated) 10 percent quantile is -1.06015.
## in RStudio or Jupytier IRKernel, use q.l(.)(.) instead of q(.)(.)



cleanEx()
nameEx("AbscontDistribution")
### * AbscontDistribution

flush(stderr()); flush(stdout())

### Name: AbscontDistribution
### Title: Generating function "AbscontDistribution"
### Aliases: AbscontDistribution
### Keywords: distribution

### ** Examples

plot(Norm())
plot(AbscontDistribution(r = rnorm))
plot(AbscontDistribution(d = dnorm))
plot(AbscontDistribution(p = pnorm))
plot(AbscontDistribution(q = qnorm))
plot(Ac <- AbscontDistribution(d = function(x, log = FALSE){
                                   d <- exp(-abs(x^3))
                                   ## unstandardized!!
                                   if(log) d <- log(d)
                                   return(d)}, 
                         withStand = TRUE))



cleanEx()
nameEx("Arcsine-class")
### * Arcsine-class

flush(stderr()); flush(stdout())

### Name: Arcsine-class
### Title: Class "Arcsine"
### Aliases: Arcsine-class Arcsine initialize,Arcsine-method
### Keywords: distribution

### ** Examples

A <- Arcsine()
# A is a Arcsine distribution with shape1 = 1 and shape2 = 1.
r(A)(3) # three random number generated from this distribution, e.g. 0.6979795
d(A)(c(-2,-1,-0.2,0,0.2,1,2)) # Density at x=c(-1,-0.2,0,0.2,1).
p(A)(c(-2,-1,-0.2,0,0.2,1,2)) # cdf at q=c(-1,-0.2,0,0.2,1).
q(A)(c(0,0.2,1,2)) # quantile function at at x=c(0,0.2,1).
## in RStudio or Jupyter IRKernel, use q.l(A)(c(0,0.2,1,2)) instead



cleanEx()
nameEx("Beta-class")
### * Beta-class

flush(stderr()); flush(stdout())

### Name: Beta-class
### Title: Class "Beta"
### Aliases: Beta-class Beta initialize,Beta-method
### Keywords: distribution

### ** Examples

B <- Beta(shape1 = 1, shape2 = 1)
# B is a beta distribution with shape1 = 1 and shape2 = 1.
r(B)(1) # one random number generated from this distribution, e.g. 0.6979795
d(B)(1) # Density of this distribution is 1 for x=1.
p(B)(1) # Probability that x < 1 is 1.
q(B)(.1) # Probability that x < 0.1 is 0.1.
shape1(B) # shape1 of this distribution is 1.
shape1(B) <- 2 # shape1 of this distribution is now 2.
Bn <- Beta(shape1 = 1, shape2 = 3, ncp = 5) 
# Bn is a beta distribution with shape1 = 1 and shape2 = 3 and ncp = 5.
B0 <- Bn; ncp(B0) <- 0; 
# B0 is just the same beta distribution as Bn but with ncp = 0
q(B0)(0.1) ## 
q(Bn)(0.1) ## => from R 2.3.0 on ncp no longer ignored...
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)



cleanEx()
nameEx("BetaParameter-class")
### * BetaParameter-class

flush(stderr()); flush(stdout())

### Name: BetaParameter-class
### Title: Class "BetaParameter"
### Aliases: BetaParameter-class initialize,BetaParameter-method
### Keywords: distribution

### ** Examples

W <- new("BetaParameter", shape1 = 1, shape2 = 1, ncp = 0)
shape2(W) # shape2 of this distribution is 1.
shape2(W) <- 2 # shape2 of this distribution is now 2.



cleanEx()
nameEx("Binom-class")
### * Binom-class

flush(stderr()); flush(stdout())

### Name: Binom-class
### Title: Class "Binom"
### Aliases: Binom-class Binom initialize,Binom-method
### Keywords: distribution

### ** Examples

B <- Binom(prob=0.5,size=1) # B is a binomial distribution with prob=0.5 and size=1.
r(B)(1) # # one random number generated from this distribution, e.g. 1
d(B)(1) # Density of this distribution is  0.5 for x=1.
p(B)(0.4) # Probability that x<0.4 is 0.5.
q(B)(.1) # x=0 is the smallest value x such that p(B)(x)>=0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
size(B) # size of this distribution is 1.
size(B) <- 2 # size of this distribution is now 2.
C <- Binom(prob = 0.5, size = 1) # C is a binomial distribution with prob=0.5 and size=1.
D <- Binom(prob = 0.6, size = 1) # D is a binomial distribution with prob=0.6 and size=1.
E <- B + C # E is a binomial distribution with prob=0.5 and size=3.
F <- B + D # F is an object of class LatticeDistribution.
G <- B + as(D,"DiscreteDistribution") ## DiscreteDistribution



cleanEx()
nameEx("BinomParameter-class")
### * BinomParameter-class

flush(stderr()); flush(stdout())

### Name: BinomParameter-class
### Title: Class "BinomParameter"
### Aliases: BinomParameter-class initialize,BinomParameter-method
### Keywords: distribution

### ** Examples

W <- new("BinomParameter",prob=0.5,size=1)
size(W) # size of this distribution is 1.
size(W) <- 2 # size of this distribution is now 2.



cleanEx()
nameEx("Cauchy-class")
### * Cauchy-class

flush(stderr()); flush(stdout())

### Name: Cauchy-class
### Title: Class "Cauchy"
### Aliases: Cauchy-class Cauchy initialize,Cauchy-method
### Keywords: distribution

### ** Examples

C <- Cauchy(location = 1, scale = 1) # C is a Cauchy distribution with location=1 and scale=1.
r(C)(1) # one random number generated from this distribution, e.g. 4.104603
d(C)(1) # Density of this distribution is 0.3183099 for x=1.
p(C)(1) # Probability that x<1 is 0.5.
q(C)(.1) # Probability that x<-2.077684 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
location(C) # location of this distribution is 1.
location(C) <- 2 # location of this distribution is now 2.
is(C,"Td") # no
C0 <- Cauchy() # standard, i.e. location = 0, scale = 1
is(C0,"Td") # yes
as(C0,"Td") 



cleanEx()
nameEx("CauchyParameter-class")
### * CauchyParameter-class

flush(stderr()); flush(stdout())

### Name: CauchyParameter-class
### Title: Class "CauchyParameter"
### Aliases: CauchyParameter-class initialize,CauchyParameter-method
### Keywords: distribution

### ** Examples

W <- new("CauchyParameter",location=1,scale=1)
location(W) # location of this distribution is 1.
location(W) <- 2 # location of this distribution is now 2.



cleanEx()
nameEx("Chisq-class")
### * Chisq-class

flush(stderr()); flush(stdout())

### Name: Chisq-class
### Title: Class "Chisq"
### Aliases: Chisq-class Chisq initialize,Chisq-method
### Keywords: distribution

### ** Examples

C <- Chisq(df = 1, ncp = 1) # C is a chi-squared distribution with df=1 and ncp=1.
r(C)(1) # one random number generated from this distribution, e.g. 0.2557184
d(C)(1) # Density of this distribution is 0.2264666 for x = 1.
p(C)(1) # Probability that x < 1 is 0.4772499.
q(C)(.1) # Probability that x < 0.04270125 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
df(C) # df of this distribution is 1.
df(C) <- 2 # df of this distribution is now 2.
is(C, "Gammad") # no
C0 <- Chisq() # default: Chisq(df=1,ncp=0)
is(C0, "Gammad") # yes
as(C0,"Gammad")



cleanEx()
nameEx("ChisqParameter-class")
### * ChisqParameter-class

flush(stderr()); flush(stdout())

### Name: ChisqParameter-class
### Title: Class "ChisqParameter"
### Aliases: ChisqParameter-class initialize,ChisqParameter-method
### Keywords: distribution

### ** Examples

W <- new("ChisqParameter",df=1,ncp=1)
ncp(W) # ncp of this distribution is 1.
ncp(W) <- 2 # ncp of this distribution is now 2.



cleanEx()
nameEx("CompoundDistribution-class")
### * CompoundDistribution-class

flush(stderr()); flush(stdout())

### Name: CompoundDistribution-class
### Title: Class "CompoundDistribution"
### Aliases: CompoundDistribution-class NumbOfSummandsDistr SummandsDistr
###   NumbOfSummandsDistr-methods SummandsDistr-methods
###   NumbOfSummandsDistr,CompoundDistribution-method
###   SummandsDistr,CompoundDistribution-method
###   coerce,CompoundDistribution,UnivarLebDecDistribution-method
###   UnivDistrListOrDistribution-class
### Keywords: distribution

### ** Examples

CP <- CompoundDistribution(Pois(),Norm())
CP
p(CP)(0.3)          
plot(CP)



cleanEx()
nameEx("CompoundDistribution")
### * CompoundDistribution

flush(stderr()); flush(stdout())

### Name: CompoundDistribution
### Title: Generating function for Class "CompoundDistribution"
### Aliases: CompoundDistribution
### Keywords: distribution list

### ** Examples

CP0 <- CompoundDistribution(Pois(), Norm())
CP0
CP1 <- CompoundDistribution(DiscreteDistribution(supp = c(1,5,9,11),
                            prob = dbinom(0:3, size = 3,prob = 0.3)),Norm())
CP1
UL <- UnivarDistrList(Norm(), Binom(10,0.3), Chisq(df=4), Norm(),
                      Binom(10,0.3), Chisq(df=4), Norm(), Binom(10,0.3),
                      Chisq(df=4), Td(5), Td(10))
CP2 <- CompoundDistribution(DiscreteDistribution(supp = c(1,5,9,11),
                      prob = dbinom(0:3, size = 3, prob = 0.3)),UL)
plot(CP2)



cleanEx()
nameEx("ConvPow")
### * ConvPow

flush(stderr()); flush(stdout())

### Name: convpow-methods
### Title: Distribution of the sum of univariate i.i.d r.v's
### Aliases: convpow convpow-methods convpow,AcDcLcDistribution-method
###   convpow,AbscontDistribution-method convpow,LatticeDistribution-method
###   convpow,DiscreteDistribution-method convpow,AcDcLcDistribution-method
###   convpow,Norm-method convpow,Binom-method convpow,Nbinom-method
###   convpow,ExpOrGammaOrChisq-method convpow,Cauchy-method
###   convpow,Pois-method convpow,Dirac-method
### Keywords: distribution

### ** Examples

convpow(Exp()+Pois(),4)



cleanEx()
nameEx("DExp-class")
### * DExp-class

flush(stderr()); flush(stdout())

### Name: DExp-class
### Title: Class "DExp"
### Aliases: DExp-class DExp Laplace DoubleExponential
###   initialize,DExp-method
### Keywords: distribution

### ** Examples

D <- DExp(rate = 1) # D is a Laplace distribution with rate = 1.
r(D)(1) # one random number generated from this distribution, e.g. 0.4190765
d(D)(1) # Density of this distribution is 0.1839397 for x = 1.
p(D)(1) # Probability that x < 1 is 0.8160603.
q(D)(.1) # Probability that x < -1.609438 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
rate(D) # rate of this distribution is 1.
rate(D) <- 2 # rate of this distribution is now 2.
3*D ###  still a DExp -distribution



cleanEx()
nameEx("Dirac-class")
### * Dirac-class

flush(stderr()); flush(stdout())

### Name: Dirac-class
### Title: Class "Dirac"
### Aliases: Dirac-class Dirac initialize,Dirac-method log,Dirac-method
###   Math,Dirac-method
### Keywords: distribution

### ** Examples

D <- Dirac(location = 0) # D is a Dirac distribution with location=0.
r(D)(1)
# r(D)(1) generates a pseudo-random-number according to a Dirac
# distribution with location = 0,
# which of course will take 0 as value almost surely.
d(D)(0) # Density of this distribution is 1 for x = 0.
p(D)(1) # Probability that x < 1 is 1.
q(D)(.1) # q(D)(x) is always 0 (= location).
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
location(D) # location of this distribution is 0.
location(D) <- 2 # location of this distribution is now 2.



cleanEx()
nameEx("DiracParameter-class")
### * DiracParameter-class

flush(stderr()); flush(stdout())

### Name: DiracParameter-class
### Title: Class "DiracParameter"
### Aliases: DiracParameter-class initialize,DiracParameter-method
### Keywords: distribution

### ** Examples

W <- new("DiracParameter",location=1)
location(W) # location of this distribution is 1.
location(W) <- 2 # location of this distribution is now 2.



cleanEx()
nameEx("DiscreteDistribution-class")
### * DiscreteDistribution-class

flush(stderr()); flush(stdout())

### Name: DiscreteDistribution-class
### Title: Class "DiscreteDistribution"
### Aliases: DiscreteDistribution-class AffLinDiscreteDistribution-class
###   initialize,DiscreteDistribution-method
###   initialize,AffLinDiscreteDistribution-method
###   sqrt,DiscreteDistribution-method
###   coerce,DiscreteDistribution,LatticeDistribution-method
###   coerce,AffLinDiscreteDistribution,LatticeDistribution-method
### Keywords: distribution

### ** Examples

# Dirac-measure at 0
D1 <- DiscreteDistribution(supp = 0)
support(D1)

# simple discrete distribution
D2 <- DiscreteDistribution(supp = c(1:5), prob = c(0.1, 0.2, 0.3, 0.2, 0.2))
plot(D2)
(pp <- p(D2)(support(D2)))
p(D2)(support(D2)-1e-5)
p(D2)(support(D2)+1e-5)
p.l(D2)(support(D2))
p.l(D2)(support(D2)-1e-5)
p.l(D2)(support(D2)+1e-5)
q(D2)(pp)
q(D2)(pp-1e-5)
q(D2)(pp+1e-5)
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
q.r(D2)(pp)
q.r(D2)(pp-1e-5)
q.r(D2)(pp+1e-5)



cleanEx()
nameEx("DiscreteDistribution")
### * DiscreteDistribution

flush(stderr()); flush(stdout())

### Name: DiscreteDistribution
### Title: Generating function "DiscreteDistribution"
### Aliases: DiscreteDistribution
### Keywords: distribution

### ** Examples

# Dirac-measure at 0
D1 <- DiscreteDistribution(supp = 0)
D1
# simple discrete distribution
D2 <- DiscreteDistribution(supp = c(1:5), prob = c(0.1, 0.2, 0.3, 0.2, 0.2))
D2

plot(D2)



cleanEx()
nameEx("DistrList-class")
### * DistrList-class

flush(stderr()); flush(stdout())

### Name: DistrList-class
### Title: List of distributions
### Aliases: DistrList-class coerce,Distribution,DistrList-method
###   show,DistrList-method
### Keywords: distribution list

### ** Examples

(DL <- new("DistrList", list(Norm(), Exp())))
plot(DL)
as(Norm(), "DistrList")



cleanEx()
nameEx("DistrList")
### * DistrList

flush(stderr()); flush(stdout())

### Name: DistrList
### Title: Generating function for DistrList-class
### Aliases: DistrList
### Keywords: distribution list

### ** Examples

(DL <- DistrList(Norm(), Exp(), Pois()))
plot(DL)
as(Norm(), "DistrList")

## The function is currently defined as
function(...){ 
    new("DistrList", list(...)) 
}



cleanEx()
nameEx("DistrSymmList-class")
### * DistrSymmList-class

flush(stderr()); flush(stdout())

### Name: DistrSymmList-class
### Title: List of Symmetries for a List of Distributions
### Aliases: DistrSymmList-class
### Keywords: classes distribution

### ** Examples

new("DistrSymmList", list(NoSymmetry(), SphericalSymmetry(SymmCenter = 1), 
                          EllipticalSymmetry(SymmCenter = 2)))



cleanEx()
nameEx("DistrSymmList")
### * DistrSymmList

flush(stderr()); flush(stdout())

### Name: DistrSymmList
### Title: Generating function for DistrSymmList-class
### Aliases: DistrSymmList
### Keywords: distribution

### ** Examples

DistrSymmList(NoSymmetry(), SphericalSymmetry(SymmCenter = 1), 
              EllipticalSymmetry(SymmCenter = 2))

## The function is currently defined as
function (...){
    new("DistrSymmList", list(...))
}



cleanEx()
nameEx("EllipticalSymmetry-class")
### * EllipticalSymmetry-class

flush(stderr()); flush(stdout())

### Name: EllipticalSymmetry-class
### Title: Class for Elliptically Symmetric Distributions
### Aliases: EllipticalSymmetry-class
### Keywords: classes distribution

### ** Examples

new("EllipticalSymmetry")



cleanEx()
nameEx("EllipticalSymmetry")
### * EllipticalSymmetry

flush(stderr()); flush(stdout())

### Name: EllipticalSymmetry
### Title: Generating function for EllipticalSymmetry-class
### Aliases: EllipticalSymmetry
### Keywords: distribution

### ** Examples

EllipticalSymmetry()

## The function is currently defined as
function(SymmCenter = 0){ 
    new("EllipticalSymmetry", SymmCenter = SymmCenter) 
}



cleanEx()
nameEx("EmpiricalDistribution")
### * EmpiricalDistribution

flush(stderr()); flush(stdout())

### Name: EmpiricalDistribution
### Title: Generating function "EmpiricalDistribution"
### Aliases: EmpiricalDistribution
### Keywords: distribution

### ** Examples

x <- rnorm(20)
D1 <- EmpiricalDistribution(data = x)
D1

plot(D1)



cleanEx()
nameEx("EuclideanSpace-class")
### * EuclideanSpace-class

flush(stderr()); flush(stdout())

### Name: EuclideanSpace-class
### Title: Class "EuclideanSpace"
### Aliases: EuclideanSpace EuclideanSpace-class
###   initialize,EuclideanSpace-method
### Keywords: distribution

### ** Examples

E <- EuclideanSpace(dimension = 2) 
dimension(E) # The dimension of this space is 2.
dimension(E) <- 3 # The dimension of this space is now 3.
liesIn(E,c(0,0,0)) # TRUE
liesIn(E,c(0,0)) # FALSE



cleanEx()
nameEx("Exp-class")
### * Exp-class

flush(stderr()); flush(stdout())

### Name: Exp-class
### Title: Class "Exp"
### Aliases: Exp-class Exp initialize,Exp-method
### Keywords: distribution

### ** Examples

E <- Exp(rate = 1) # E is a exp distribution with rate = 1.
r(E)(1) # one random number generated from this distribution, e.g. 0.4190765
d(E)(1) # Density of this distribution is 0.3678794 for x = 1.
p(E)(1) # Probability that x < 1 is 0.6321206.
q(E)(.1) # Probability that x < 0.1053605 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
rate(E) # rate of this distribution is 1.
rate(E) <- 2 # rate of this distribution is now 2.
is(E, "Gammad") # yes
as(E,"Gammad")
is(E, "Weibull") 
E+E+E ###  a Gammad -distribution
2*E+Gammad(scale=1)



cleanEx()
nameEx("ExpOrGammaOrChisq-class")
### * ExpOrGammaOrChisq-class

flush(stderr()); flush(stdout())

### Name: ExpOrGammaOrChisq-class
### Title: Class "ExpOrGammaOrChisq"
### Aliases: ExpOrGammaOrChisq-class
### Keywords: internal distribution

### ** Examples

## class only used internally



cleanEx()
nameEx("ExpParameter-class")
### * ExpParameter-class

flush(stderr()); flush(stdout())

### Name: ExpParameter-class
### Title: Class "ExpParameter"
### Aliases: ExpParameter-class initialize,ExpParameter-method
### Keywords: distribution

### ** Examples

W <- new("ExpParameter", rate = 1)
rate(W) # rate of this distribution is 1.
rate(W) <- 2 # rate of this distribution is now 2.



cleanEx()
nameEx("FParameter-class")
### * FParameter-class

flush(stderr()); flush(stdout())

### Name: FParameter-class
### Title: Class "FParameter"
### Aliases: FParameter-class initialize,FParameter-method
### Keywords: distribution

### ** Examples

W <- new("FParameter", df1 = 1, df2 = 1, ncp = 0)
df2(W) # df2 of this distribution is 1.
df2(W) <- 2 # df2 of this distribution is now 2.



cleanEx()
nameEx("Fd-class")
### * Fd-class

flush(stderr()); flush(stdout())

### Name: Fd-class
### Title: Class "Fd"
### Aliases: Fd-class Fd initialize,Fd-method
### Keywords: distribution

### ** Examples

F <- Fd(df1 = 1, df2 = 1) # F is a F distribution with df=1 and df2=1.
r(F)(1) # one random number generated from this distribution, e.g. 29.37863
d(F)(1) # Density of this distribution is 0.1591549 for x=1 .
p(F)(1) # Probability that x<1 is 0.5.
q(F)(.1) # Probability that x<0.02508563 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
df1(F) # df1 of this distribution is 1.
df1(F) <- 2 # df1 of this distribution is now 2.
Fn <- Fd(df1 = 1, df2 = 1, ncp = 0.5) 
  # Fn is a F distribution with df=1, df2=1 and ncp =0.5.
d(Fn)(1) ## from R 2.3.0 on ncp no longer ignored...



cleanEx()
nameEx("GammaParameter-class")
### * GammaParameter-class

flush(stderr()); flush(stdout())

### Name: GammaParameter-class
### Title: Class "GammaParameter"
### Aliases: GammaParameter-class initialize,GammaParameter-method
### Keywords: distribution

### ** Examples

W <- new("GammaParameter",scale=1,shape=1)
shape(W) # shape of this distribution is 1.
shape(W) <- 2 # shape of this distribution is now 2.



cleanEx()
nameEx("Gammad-class")
### * Gammad-class

flush(stderr()); flush(stdout())

### Name: Gammad-class
### Title: Class "Gammad"
### Aliases: Gammad-class Gammad initialize,Gammad-method
### Keywords: distribution

### ** Examples

G <- Gammad(scale=1,shape=1) # G is a gamma distribution with scale=1 and shape=1.
r(G)(1) # one random number generated from this distribution, e.g. 0.1304441
d(G)(1) # Density of this distribution is 0.3678794 for x=1.
p(G)(1) # Probability that x<1 is 0.6321206.
q(G)(.1) # Probability that x<0.1053605 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
scale(G) # scale of this distribution is 1.
scale(G) <- 2 # scale of this distribution is now 2.



cleanEx()
nameEx("Geom-class")
### * Geom-class

flush(stderr()); flush(stdout())

### Name: Geom-class
### Title: Class "Geom"
### Aliases: Geom-class Geom initialize,Geom-method
### Keywords: distribution

### ** Examples

G <- Geom(prob = 0.5) # G is a geometric distribution with prob = 0.5.
r(G)(1) # one random number generated from this distribution, e.g. 0
d(G)(1) # Density of this distribution is 0.25 for x = 1.
p(G)(1) # Probability that x<1 is 0.75.
q(G)(.1) # x = 0 is the smallest value x such that p(G)(x) >= 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
prob(G) # prob of this distribution is 0.5.
prob(G) <- 0.6 # prob of this distribution is now 0.6.
as(G,"Nbinom")
G+G+G



cleanEx()
nameEx("Huberize-methods")
### * Huberize-methods

flush(stderr()); flush(stdout())

### Name: Huberize-methods
### Title: Methods for function Huberize in Package 'distr'
### Aliases: Huberize-methods Huberize Huberize,AcDcLcDistribution-method
### Keywords: distribution methods

### ** Examples

Hub <- Huberize(Norm(),lower=-1,upper=2)
Hub 
plot(Hub)



cleanEx()
nameEx("Hyper-class")
### * Hyper-class

flush(stderr()); flush(stdout())

### Name: Hyper-class
### Title: Class "Hyper"
### Aliases: Hyper-class Hyper initialize,Hyper-method
### Keywords: distribution

### ** Examples

H <- Hyper(m=3,n=3,k=3) # H is a hypergeometric distribution with m=3,n=3,k=3.
r(H)(1) # one random number generated from this distribution, e.g. 2
d(H)(1) # Density of this distribution is  0.45 for x=1.
p(H)(1) # Probability that x<1 is 0.5.
q(H)(.1) # x=1 is the smallest value x such that p(H)(x)>=0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
m(H) # m of this distribution is 3.
m(H) <- 2 # m of this distribution is now 2.



cleanEx()
nameEx("HyperParameter-class")
### * HyperParameter-class

flush(stderr()); flush(stdout())

### Name: HyperParameter-class
### Title: Class "HyperParameter"
### Aliases: HyperParameter-class initialize,HyperParameter-method
### Keywords: distribution

### ** Examples

W <- new("HyperParameter",k=3, m=3, n=3)
m(W) # m of this distribution is 3.
m(W) <- 2 # m of this distribution is now 2.



cleanEx()
nameEx("Lattice-class")
### * Lattice-class

flush(stderr()); flush(stdout())

### Name: Lattice-class
### Title: Class "Lattice"
### Aliases: Lattice-class Lattice
### Keywords: distribution

### ** Examples

L <- Lattice(pivot = 0, width = 1, Length = Inf, name = "the Naturals")
name(L)
pivot(L) <- 1 ### now starting from 1



cleanEx()
nameEx("LatticeDistribution-class")
### * LatticeDistribution-class

flush(stderr()); flush(stdout())

### Name: LatticeDistribution-class
### Title: Class "LatticeDistribution"
### Aliases: AffLinLatticeDistribution-class LatticeDistribution-class
###   lattice lattice-method lattice,LatticeDistribution-method
###   initialize,LatticeDistribution-method
###   initialize,AffLinLatticeDistribution-method
###   sqrt,LatticeDistribution-method
###   coerce,LatticeDistribution,DiscreteDistribution-method
###   coerce,AffLinLatticeDistribution,AffLinDiscreteDistribution-method
### Keywords: distribution

### ** Examples

B <- Binom(prob = 0.1,size = 10) # B is a Binomial distribution w/ prob=0.1 and size=10.
P <- Pois(lambda = 1) # P is a Poisson distribution with lambda = 1.
D1 <- B+1 # a new Lattice distributions with exact slots d, p, q
D2 <- D1*3 # a new Lattice distributions with exact slots d, p, q
D3 <- B+P # a new Lattice distributions with approximated slots d, p, q
D4 <- D1+P # a new Lattice distributions with approximated slots d, p, q
support(D4) # the (approximated) support of this distribution is 1, 2, ..., 21
r(D4)(1) # one random number generated from this distribution, e.g. 4
d(D4)(1) # The (approximated) density for x=1 is 0.1282716.
p(D4)(1) # The (approximated) probability that x<=1 is 0.1282716.
q(D4)(.5) # The (approximated) 50 percent quantile is 3.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)



cleanEx()
nameEx("LatticeDistribution")
### * LatticeDistribution

flush(stderr()); flush(stdout())

### Name: LatticeDistribution
### Title: Class "LatticeDistribution"
### Aliases: LatticeDistribution
### Keywords: distribution

### ** Examples

  LatticeDistribution(DiscreteDistribution = DiscreteDistribution(supp =
                       c(4,3,2), prob=c(0.3,0.1,0.6)))
  LatticeDistribution(supp = c(4,3,2))



cleanEx()
nameEx("Lnorm-class")
### * Lnorm-class

flush(stderr()); flush(stdout())

### Name: Lnorm-class
### Title: Class "Lnorm"
### Aliases: Lnorm-class Lnorm initialize,Lnorm-method
### Keywords: distribution

### ** Examples

L <- Lnorm(meanlog=1,sdlog=1) # L is a lnorm distribution with mean=1 and sd=1.
r(L)(1) # one random number generated from this distribution, e.g. 3.608011
d(L)(1) # Density of this distribution is 0.2419707 for x=1.
p(L)(1) # Probability that x<1 is 0.1586553.
q(L)(.1) # Probability that x<0.754612 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
meanlog(L) # meanlog of this distribution is 1.
meanlog(L) <- 2 # meanlog of this distribution is now 2.



cleanEx()
nameEx("LnormParameter-class")
### * LnormParameter-class

flush(stderr()); flush(stdout())

### Name: LnormParameter-class
### Title: Class "LnormParameter"
### Aliases: LnormParameter-class initialize,LnormParameter-method
### Keywords: distribution

### ** Examples

W <- new("LnormParameter",sdlog=1,meanlog=0)
meanlog(W) # meanlog of this distribution is 0.
meanlog(W) <- 2 # meanlog of this distribution is now 2.



cleanEx()
nameEx("Logis-class")
### * Logis-class

flush(stderr()); flush(stdout())

### Name: Logis-class
### Title: Class "Logis"
### Aliases: Logis-class Logis initialize,Logis-method
### Keywords: distribution

### ** Examples

L <- Logis(location = 1,scale = 1)
# L is a logistic distribution with  location = 1 and scale = 1.
r(L)(1) # one random number generated from this distribution, e.g. 5.87557
d(L)(1) # Density of this distribution is 0.25 for x = 1.
p(L)(1) # Probability that x < 1 is 0.5.
q(L)(.1) # Probability that x < -1.197225 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
location(L) # location of this distribution is 1.
location(L) <- 2 # location of this distribution is now 2.



cleanEx()
nameEx("LogisParameter-class")
### * LogisParameter-class

flush(stderr()); flush(stdout())

### Name: LogisParameter-class
### Title: Class "LogisParameter"
### Aliases: LogisParameter-class initialize,LogisParameter-method
### Keywords: distribution

### ** Examples

W <- new("LogisParameter",location=0,scale=1)
scale(W) # scale of this distribution is 1.
scale(W) <- 2 # scale of this distribution is now 2.



cleanEx()
nameEx("MakeAbscontDistribution")
### * MakeAbscontDistribution

flush(stderr()); flush(stdout())

### Name: makeAbscontDistribution
### Title: "makeAbscontDistribution"
### Aliases: makeAbscontDistribution
### Keywords: distribution

### ** Examples

  Hu <- Huberize(Norm(), -2,1)
  Hu
  plot(Hu)
  Hu0 <- makeAbscontDistribution(Hu)
  Hu0
  plot(Hu0)



cleanEx()
nameEx("MinMaximum-methods")
### * MinMaximum-methods

flush(stderr()); flush(stdout())

### Name: Minimum-methods
### Title: Methods for functions Minimum and Maximum in Package 'distr'
### Aliases: Minimum-methods Minimum Maximum-methods Maximum
###   Minimum,AbscontDistribution,AbscontDistribution-method
###   Minimum,DiscreteDistribution,DiscreteDistribution-method
###   Minimum,AbscontDistribution,Dirac-method
###   Minimum,AcDcLcDistribution,AcDcLcDistribution-method
###   Minimum,AbscontDistribution,numeric-method
###   Minimum,DiscreteDistribution,numeric-method
###   Minimum,AcDcLcDistribution,numeric-method
###   Maximum,AcDcLcDistribution,AcDcLcDistribution-method
###   Maximum,AcDcLcDistribution,numeric-method
### Keywords: distribution methods

### ** Examples

plot(Maximum(Unif(0,1), Minimum(Unif(0,1), Unif(0,1))))
plot(Minimum(Exp(4),4))
## a sometimes lengthy example...



cleanEx()
nameEx("Naturals-class")
### * Naturals-class

flush(stderr()); flush(stdout())

### Name: Naturals-class
### Title: Class "Naturals"
### Aliases: Naturals Naturals-class initialize,Naturals-method
### Keywords: distribution

### ** Examples

N <- Naturals()
liesIn(N,1) # TRUE
liesIn(N,c(0,1)) # FALSE
liesIn(N,0.1) # FALSE



cleanEx()
nameEx("Nbinom-class")
### * Nbinom-class

flush(stderr()); flush(stdout())

### Name: Nbinom-class
### Title: Class "Nbinom"
### Aliases: Nbinom-class Nbinom initialize,Nbinom-method
### Keywords: distribution

### ** Examples

N <- Nbinom(prob = 0.5, size = 1) # N is a binomial distribution with prob=0.5 and size=1.
r(N)(1) # one random number generated from this distribution, e.g. 3
d(N)(1) # Density of this distribution is  0.25 for x=1.
p(N)(0.4) # Probability that x<0.4 is 0.5.
q(N)(.1) # x=0 is the smallest value x such that p(B)(x)>=0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
size(N) # size of this distribution is 1.
size(N) <- 2 # size of this distribution is now 2.



cleanEx()
nameEx("NbinomParameter-class")
### * NbinomParameter-class

flush(stderr()); flush(stdout())

### Name: NbinomParameter-class
### Title: Class "NbinomParameter"
### Aliases: NbinomParameter-class initialize,NbinomParameter-method
### Keywords: distribution

### ** Examples

W <- new("NbinomParameter",prob=0.5,size=1)
size(W) # size of this distribution is 1.
size(W) <- 2 # size of this distribution is now 2.



cleanEx()
nameEx("NoSymmetry-class")
### * NoSymmetry-class

flush(stderr()); flush(stdout())

### Name: NoSymmetry-class
### Title: Class for Non-symmetric Distributions
### Aliases: NoSymmetry-class
### Keywords: classes distribution

### ** Examples

new("NoSymmetry")



cleanEx()
nameEx("NoSymmetry")
### * NoSymmetry

flush(stderr()); flush(stdout())

### Name: NoSymmetry
### Title: Generating function for NoSymmetry-class
### Aliases: NoSymmetry
### Keywords: distribution

### ** Examples

NoSymmetry()

## The function is currently defined as
function(){ new("NoSymmetry") }



cleanEx()
nameEx("Norm-class")
### * Norm-class

flush(stderr()); flush(stdout())

### Name: Norm-class
### Title: Class "Norm"
### Aliases: Norm-class Norm initialize,Norm-method
### Keywords: distribution

### ** Examples

N <- Norm(mean=1,sd=1) # N is a normal distribution with mean=1 and sd=1.
r(N)(1) # one random number generated from this distribution, e.g. 2.257783
d(N)(1) # Density of this distribution is  0.3989423 for x=1.
p(N)(1) # Probability that x<1 is 0.5.
q(N)(.1) # Probability that x<-0.2815516 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
mean(N) # mean of this distribution is 1.
sd(N) <- 2 # sd of this distribution is now 2.
M <- Norm() # M is a normal distribution with mean=0 and sd=1.
O <- M+N # O is a normal distribution with mean=1 (=1+0) and sd=sqrt(5) (=sqrt(2^2+1^2)).



cleanEx()
nameEx("NormParameter-class")
### * NormParameter-class

flush(stderr()); flush(stdout())

### Name: NormParameter-class
### Title: Class "NormParameter"
### Aliases: NormParameter-class initialize,NormParameter-method
### Keywords: distribution

### ** Examples

W <- new("NormParameter", mean = 0, sd = 1)
sd(W) # sd of this distribution is 1.
sd(W) <- 2 # sd of this distribution is now 2.



cleanEx()
nameEx("Pois-class")
### * Pois-class

flush(stderr()); flush(stdout())

### Name: Pois-class
### Title: Class "Pois"
### Aliases: Pois-class Pois initialize,Pois-method
### Keywords: distribution

### ** Examples

P <- Pois(lambda = 1) # P is a Poisson distribution with lambda = 1.
r(P)(1) # one random number generated from this distribution, e.g. 1
d(P)(1) # Density of this distribution is 0.3678794 for x = 1.
p(P)(0.4) # Probability that x < 0.4 is 0.3678794.
q(P)(.1) # x = 0 is the smallest value x such that p(B)(x) >= 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
lambda(P) # lambda of this distribution is 1.
lambda(P) <- 2 # lambda of this distribution is now 2.
R <- Pois(lambda = 3) # R is a Poisson distribution with lambda = 2.
S <- P + R # R is a Poisson distribution with lambda = 5(=2+3).



cleanEx()
nameEx("PoisParameter-class")
### * PoisParameter-class

flush(stderr()); flush(stdout())

### Name: PoisParameter-class
### Title: Class "PoisParameter"
### Aliases: PoisParameter-class initialize,PoisParameter-method
### Keywords: distribution

### ** Examples

W <- new("PoisParameter",lambda = 1)
lambda(W) # lambda of this distribution is 1.
lambda(W) <- 2 # lambda of this distribution is now 2.



cleanEx()
nameEx("PosDefSymmMatrix-class")
### * PosDefSymmMatrix-class

flush(stderr()); flush(stdout())

### Name: PosDefSymmMatrix-class
### Title: Positive-[Semi-]definite, symmetric matrices
### Aliases: PosDefSymmMatrix-class PosSemDefSymmMatrix-class
### Keywords: classes array

### ** Examples

new("PosDefSymmMatrix", diag(2))



cleanEx()
nameEx("PosDefSymmMatrix")
### * PosDefSymmMatrix

flush(stderr()); flush(stdout())

### Name: PosDefSymmMatrix
### Title: Generating functions for PosSemDefSymmMatrix-class resp.
###   PosDefSymmMatrix-class
### Aliases: PosDefSymmMatrix PosSemDefSymmMatrix
### Keywords: array

### ** Examples

PosSemDefSymmMatrix(1)
PosSemDefSymmMatrix(diag(2))
PosDefSymmMatrix(1)
PosDefSymmMatrix(diag(2))



cleanEx()
nameEx("Reals-class")
### * Reals-class

flush(stderr()); flush(stdout())

### Name: Reals-class
### Title: Class "Reals"
### Aliases: Reals Reals-class initialize,Reals-method
### Keywords: distribution

### ** Examples

R <- Reals()
liesIn(R,c(0,0)) # FALSE



cleanEx()
nameEx("RtoDPQ.LC")
### * RtoDPQ.LC

flush(stderr()); flush(stdout())

### Name: RtoDPQ.LC
### Title: Default procedure to fill slots d,p,q given r for Lebesgue
###   decomposed distributions
### Aliases: RtoDPQ.LC
### Keywords: math distribution arith

### ** Examples

rn2 <- function(n)ifelse(rbinom(n,1,0.3),rnorm(n)^2,rbinom(n,4,.3))
x <- RtoDPQ.LC(r = rn2, e = 4, n = 512)
plot(x)
# returns density, cumulative distribution and quantile function of
# squared standard normal distribution
d.discrete(x)(4)
x2 <- RtoDPQ.LC(r = rn2, e = 5, n = 1024) # for a better result
plot(x2)



cleanEx()
nameEx("RtoDPQ")
### * RtoDPQ

flush(stderr()); flush(stdout())

### Name: RtoDPQ
### Title: Default procedure to fill slots d,p,q given r for a.c.
###   distributions
### Aliases: RtoDPQ
### Keywords: math distribution arith

### ** Examples

rn2 <- function(n){rnorm(n)^2}
x <- RtoDPQ(r = rn2, e = 4, n = 512)
# returns density, cumulative distribution and quantile function of
# squared standard normal distribution
x$dfun(4)
RtoDPQ(r = rn2, e = 5, n = 1024) # for a better result

rp2 <- function(n){rpois(n, lambda = 1)^2}
x <- RtoDPQ.d(r = rp2, e = 5)
# returns density, cumulative distribution and quantile function of
# squared Poisson distribution with parameter lambda=1



cleanEx()
nameEx("RtoDPQ.d")
### * RtoDPQ.d

flush(stderr()); flush(stdout())

### Name: RtoDPQ.d
### Title: Default procedure to fill slots d,p,q given r for discrete
###   distributions
### Aliases: RtoDPQ.d
### Keywords: math distribution arith

### ** Examples

rn2 <- function(n){rnorm(n)^2}
x <- RtoDPQ(r = rn2, e = 4, n = 512)
# returns density, cumulative distribution and quantile function of
# squared standard  normal distribution

x$dfun(4)
RtoDPQ(r = rn2, e = 5, n = 1024) # for a better result

rp2 <- function(n){rpois(n, lambda = 1)^2}
x <- RtoDPQ.d(r = rp2, e = 5)
# returns density, cumulative distribution and quantile function of
# squared Poisson distribution with parameter lambda=1



cleanEx()
nameEx("SphericalSymmetry-class")
### * SphericalSymmetry-class

flush(stderr()); flush(stdout())

### Name: SphericalSymmetry-class
### Title: Class for Spherical Symmetric Distributions
### Aliases: SphericalSymmetry-class
### Keywords: classes distribution

### ** Examples

new("SphericalSymmetry")



cleanEx()
nameEx("SphericalSymmetry")
### * SphericalSymmetry

flush(stderr()); flush(stdout())

### Name: SphericalSymmetry
### Title: Generating function for SphericalSymmetry-class
### Aliases: SphericalSymmetry
### Keywords: distribution

### ** Examples

SphericalSymmetry()

## The function is currently defined as
function(SymmCenter = 0){ 
    new("SphericalSymmetry", SymmCenter = SymmCenter) 
}



cleanEx()
nameEx("TParameter-class")
### * TParameter-class

flush(stderr()); flush(stdout())

### Name: TParameter-class
### Title: Class "TParameter"
### Aliases: TParameter-class initialize,TParameter-method
### Keywords: distribution

### ** Examples

W <- new("TParameter",df=1, ncp = 0)
df(W) # df of this distribution is 1.
df(W) <- 2 # df of this distribution is now 2.



cleanEx()
nameEx("Td-class")
### * Td-class

flush(stderr()); flush(stdout())

### Name: Td-class
### Title: Class "Td"
### Aliases: Td-class Td initialize,Td-method
### Keywords: distribution

### ** Examples

T <- Td(df = 1) # T is a t distribution with df = 1.
r(T)(1) # one random number generated from this distribution, e.g. -0.09697573
d(T)(1) # Density of this distribution is 0.1591549 for x = 1.
p(T)(1) # Probability that x < 1 is 0.75.
q(T)(.1) # Probability that x < -3.077684 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
df(T) # df of this distribution is 1.
df(T) <- 2 # df of this distribution is now 2.
Tn <- Td(df = 1, ncp = 5) 
  # T is a noncentral t distribution with df = 1 and ncp = 5.
d(Tn)(1) ## from R 2.3.0 on ncp no longer ignored...



cleanEx()
nameEx("Truncate-methods")
### * Truncate-methods

flush(stderr()); flush(stdout())

### Name: Truncate-methods
### Title: Methods for function Truncate in Package 'distr'
### Aliases: Truncate-methods Truncate Truncate,AbscontDistribution-method
###   Truncate,DiscreteDistribution-method
###   Truncate,LatticeDistribution-method
###   Truncate,UnivarLebDecDistribution-method
### Keywords: distribution methods

### ** Examples

plot(Truncate(Norm(),lower=-1,upper=2))
TN <- Truncate(Norm(),lower=15,upper=15.7) ### remarkably right!
plot(TN)
r(TN)(30)
TNG <- Truncate(Geom(prob=0.05),lower=325,upper=329) ### remarkably right!
plot(TNG)



cleanEx()
nameEx("UniNormParameter-class")
### * UniNormParameter-class

flush(stderr()); flush(stdout())

### Name: UniNormParameter-class
### Title: Class "UniNormParameter"
### Aliases: UniNormParameter-class initialize,UniNormParameter-method
### Keywords: distribution

### ** Examples

W <- new("UniNormParameter", mean = 0, sd = 1)
sd(W) # sd of this distribution is 1
sd(W) <- 2 # sd of this distribution is now 2



cleanEx()
nameEx("Unif-class")
### * Unif-class

flush(stderr()); flush(stdout())

### Name: Unif-class
### Title: Class "Unif"
### Aliases: Unif-class Unif initialize,Unif-method
### Keywords: distribution

### ** Examples

U <- Unif(Min=0,Max=2) # U is a uniform distribution with Min=0 and Max=2.
r(U)(1) # one random number generated from this distribution, e.g. 1.984357
d(U)(1) # Density of this distribution is 0.5 for x=1.
p(U)(1) # Probability that x<1 is 0.5.
q(U)(.1) # Probability that x<0.2 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
Min(U) # Min of this distribution is 0.
Min(U) <- 1 # Min of this distribution is now 1.
Min(U) # Min of this distribution is 1.
Min(U) <- 0
is(U/2,"Beta") # yes
V <- U/2; as(V,"Beta")



cleanEx()
nameEx("UnifParameter-class")
### * UnifParameter-class

flush(stderr()); flush(stdout())

### Name: UnifParameter-class
### Title: Class "UnifParameter"
### Aliases: UnifParameter-class initialize,UnifParameter-method
### Keywords: distribution

### ** Examples

W <- new("UnifParameter",Min=0,Max=1)
Max(W) # Max of this distribution is 1.
Max(W) <- 2 # Max of this distribution is now 2.



cleanEx()
nameEx("UnivarDistrList-class")
### * UnivarDistrList-class

flush(stderr()); flush(stdout())

### Name: UnivarDistrList-class
### Title: List of univariate distributions
### Aliases: UnivarDistrList-class
###   coerce,UnivariateDistribution,UnivarDistrList-method
### Keywords: distribution list

### ** Examples

(DL <- new("UnivarDistrList", list(Norm(), Exp())))
plot(DL)
as(Norm(), "UnivarDistrList")



cleanEx()
nameEx("UnivarDistrList")
### * UnivarDistrList

flush(stderr()); flush(stdout())

### Name: UnivarDistrList
### Title: Generating function for UnivarDistrList-class
### Aliases: UnivarDistrList
### Keywords: list distribution

### ** Examples

(DL <- UnivarDistrList(Norm(), Exp(), Pois()))
plot(DL)
as(Norm(), "UnivarDistrList")

## The function is currently defined as
function(...){ 
    new("UnivarDistrList", list(...)) 
}



cleanEx()
nameEx("UnivarLebDecDistribution-class")
### * UnivarLebDecDistribution-class

flush(stderr()); flush(stdout())

### Name: UnivarLebDecDistribution-class
### Title: Class "UnivarLebDecDistribution"
### Aliases: UnivarLebDecDistribution-class
###   AffLinUnivarLebDecDistribution-class AcDcLcDistribution-class acPart
###   discretePart acPart<- discretePart<- acPart-methods
###   discretePart-methods acPart<--methods discretePart<--methods
###   acPart,UnivarLebDecDistribution-method
###   discretePart,UnivarLebDecDistribution-method
###   acPart<-,UnivarLebDecDistribution-method
###   discretePart<-,UnivarLebDecDistribution-method acWeight
###   discreteWeight acWeight<- discreteWeight<- acWeight-methods
###   discreteWeight-methods acWeight<--methods discreteWeight<--methods
###   acWeight,UnivarLebDecDistribution-method
###   discreteWeight,UnivarLebDecDistribution-method
###   acWeight<-,UnivarLebDecDistribution-method
###   discreteWeight<-,UnivarLebDecDistribution-method
###   p.discrete,UnivarLebDecDistribution-method
###   d.discrete,UnivarLebDecDistribution-method
###   q.discrete,UnivarLebDecDistribution-method
###   r.discrete,UnivarLebDecDistribution-method
###   p.ac,UnivarLebDecDistribution-method
###   d.ac,UnivarLebDecDistribution-method
###   q.ac,UnivarLebDecDistribution-method
###   r.ac,UnivarLebDecDistribution-method p.discrete-methods
###   d.discrete-methods q.discrete-methods r.discrete-methods p.ac-methods
###   d.ac-methods q.ac-methods r.ac-methods p.discrete d.discrete
###   q.discrete r.discrete p.ac d.ac q.ac r.ac
###   coerce,AbscontDistribution,UnivarLebDecDistribution-method
###   coerce,DiscreteDistribution,UnivarLebDecDistribution-method
###   coerce,AffLinUnivarLebDecDistribution,UnivarLebDecDistribution-method
###   abs,UnivarLebDecDistribution-method
###   log,UnivarLebDecDistribution-method
###   log10,UnivarLebDecDistribution-method
###   Math,UnivarLebDecDistribution-method
###   ^,AcDcLcDistribution,Dirac-method exp,UnivarLebDecDistribution-method
###   sign,UnivarLebDecDistribution-method sign,AcDcLcDistribution-method
###   sqrt,UnivarLebDecDistribution-method sqrt,AcDcLcDistribution-method
### Keywords: distribution

### ** Examples

wg <- flat.mix(UnivarMixingDistribution(Unif(0,1),Unif(4,5),
               withSimplify=FALSE))
myLC <- UnivarLebDecDistribution(discretePart=Binom(3,.3), acPart = wg,
          discreteWeight=.2)
myLC
p(myLC)(0.3)
r(myLC)(30)
q(myLC)(0.9)
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
acPart(myLC)
plot(myLC)
d.discrete(myLC)(2)
p.ac(myLC)(0)
acWeight(myLC)
plot(acPart(myLC))
plot(discretePart(myLC))
gaps(myLC)
support(myLC)
plot(as(Norm(),"UnivarLebDecDistribution"))



cleanEx()
nameEx("UnivarLebDecDistribution")
### * UnivarLebDecDistribution

flush(stderr()); flush(stdout())

### Name: UnivarLebDecDistribution
### Title: Generating function for Class "UnivarLebDecDistribution"
### Aliases: UnivarLebDecDistribution
### Keywords: distribution list

### ** Examples

mylist <- UnivarLebDecDistribution(discretePart=Binom(3,.3), acPart=Norm(2,2),
          acWeight=11/20)
mylist          



cleanEx()
nameEx("UnivarMixingDistribution-class")
### * UnivarMixingDistribution-class

flush(stderr()); flush(stdout())

### Name: UnivarMixingDistribution-class
### Title: Class "UnivarMixingDistribution"
### Aliases: UnivarMixingDistribution-class mixCoeff mixDistr mixCoeff<-
###   mixDistr<- mixCoeff<--methods mixDistr<--methods
###   mixCoeff<-,UnivarMixingDistribution-method
###   mixDistr<-,UnivarMixingDistribution-method mixCoeff-methods
###   mixDistr-methods mixCoeff,UnivarMixingDistribution-method
###   mixDistr,UnivarMixingDistribution-method
###   support,UnivarMixingDistribution-method
###   gaps,UnivarMixingDistribution-method
###   .logExact,UnivarMixingDistribution-method
###   .lowerExact,UnivarMixingDistribution-method
###   Symmetry,UnivarMixingDistribution-method
### Keywords: distribution

### ** Examples

mylist <- UnivarMixingDistribution(Binom(3,.3), Dirac(2), Norm(), 
          mixCoeff=c(1/4,1/5,11/20))
mylist2 <- UnivarMixingDistribution(Binom(3,.3), mylist, 
          mixCoeff=c(.3,.7))
mylist2
p(mylist)(0.3)          
mixDistr(mylist2)



cleanEx()
nameEx("UnivarMixingDistribution")
### * UnivarMixingDistribution

flush(stderr()); flush(stdout())

### Name: UnivarMixingDistribution
### Title: Generating function for Class "UnivarMixingDistribution"
### Aliases: UnivarMixingDistribution
### Keywords: distribution list

### ** Examples

mylist <- UnivarMixingDistribution(Binom(3,.3), Dirac(2), Norm(), 
          mixCoeff=c(1/4,1/5,11/20))



cleanEx()
nameEx("Weibull-class")
### * Weibull-class

flush(stderr()); flush(stdout())

### Name: Weibull-class
### Title: Class "Weibull"
### Aliases: Weibull-class Weibull initialize,Weibull-method
### Keywords: distribution

### ** Examples

W <- Weibull(shape=1,scale=1) # W is a Weibull distribution with shape=1 and scale=1.
r(W)(1) # one random number generated from this distribution, e.g. 0.5204105
d(W)(1) # Density of this distribution is 0.3678794 for x=1.
p(W)(1) # Probability that x<1 is 0.6321206.
q(W)(.1) # Probability that x<0.1053605 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
shape(W) # shape of this distribution is 1.
shape(W) <- 2 # shape of this distribution is now 2.



cleanEx()
nameEx("WeibullParameter-class")
### * WeibullParameter-class

flush(stderr()); flush(stdout())

### Name: WeibullParameter-class
### Title: Class "WeibullParameter"
### Aliases: WeibullParameter-class initialize,WeibullParameter-method
### Keywords: distribution

### ** Examples

W <- new("WeibullParameter",shape=1,scale=1)
shape(W) # shape of this distribution is 1.
shape(W) <- 2 # shape of this distribution is now 2.



cleanEx()
nameEx("decomposePM-methods")
### * decomposePM-methods

flush(stderr()); flush(stdout())

### Name: decomposePM-methods
### Title: Methods for function decomposePM in Package 'distr'
### Aliases: decomposePM-methods decomposePM
###   decomposePM,AbscontDistribution-method
###   decomposePM,DiscreteDistribution-method
###   decomposePM,UnivarLebDecDistribution-method
### Keywords: distribution methods

### ** Examples

decomposePM(Norm())
decomposePM(Binom(2,0.3)-Binom(5,.4))
decomposePM(UnivarLebDecDistribution(Norm(),Binom(2,0.3)-Binom(5,.4), 
            acWeight = 0.3))



cleanEx()
nameEx("distrARITH")
### * distrARITH

flush(stderr()); flush(stdout())

### Name: distrARITH
### Title: Arithmetics on Distributions
### Aliases: distrARITH ARITHMETICS
### Keywords: math distribution arith documentation

### ** Examples

distrARITH()



cleanEx()
nameEx("distrMASK")
### * distrMASK

flush(stderr()); flush(stdout())

### Name: distrMASK
### Title: Masking of/by other functions in package "distr"
### Aliases: distrMASK MASKING
### Keywords: programming distribution documentation

### ** Examples

distrMASK()



cleanEx()
nameEx("distroptions")
### * distroptions

flush(stderr()); flush(stdout())

### Name: distroptions
### Title: functions to change the global variables of the package 'distr'
### Aliases: distroptions getdistrOption DefaultNrGridPoints
###   DistrResolution DistrCollapse TruncQuantile WarningSim WarningArith
###   DefaultNrFFTGridPointsExponent RtoDPQ.e WarningArith WarningSim
###   withSweave warn.makeDNew withgaps use.generalized.inverse.by.default
###   DistributionAggregate.Unique.Warn
### Keywords: distribution

### ** Examples

distroptions("RtoDPQ.e") # returns the value of RtoDPQ.e, by default = 5
currentDistrOptions <- distroptions()
distroptions(RtoDPQ.e = 6)
distroptions("RtoDPQ.e") 
getdistrOption("RtoDPQ.e") 
distroptions(c("WarningSim","WarningArith"))   
getdistrOption("WarningSim")   
distroptions("WarningSim" = FALSE)   
         # switches off warnings as to (In)accuracy due to simulations
distroptions("WarningArith" = FALSE) 
         # switches off warnings as to arithmetics
distroptions(currentDistrOptions)



cleanEx()
nameEx("flat.LCD")
### * flat.LCD

flush(stderr()); flush(stdout())

### Name: flat.LCD
### Title: Flattening a list of Lebesgue decomposed distributions
### Aliases: flat.LCD
### Keywords: math distribution arith

### ** Examples

D1 <- as(Norm(),"UnivarLebDecDistribution")
D2 <- as(Pois(1),"UnivarLebDecDistribution")
D3 <- as(Binom(1,.4),"UnivarLebDecDistribution")
flat.LCD(D1,D2,D3, mixCoeff = c(0.4,0.5,0.1))



cleanEx()
nameEx("flat.mix")
### * flat.mix

flush(stderr()); flush(stdout())

### Name: flat.mix
### Title: Default procedure to fill slots d,p,q given r for Lebesgue
###   decomposed distributions
### Aliases: flat.mix
### Keywords: distribution arith

### ** Examples

D1 <- Norm()
D2 <- Pois(1)
D3 <- Binom(1,.4)
D4 <- UnivarMixingDistribution(D1,D2,D3, mixCoeff = c(0.4,0.5,0.1), 
      withSimplify = FALSE)
D <- UnivarMixingDistribution(D1,D4,D1,D2, mixCoeff = c(0.4,0.3,0.1,0.2), 
      withSimplify = FALSE)
D
D0<-flat.mix(D)
D0
plot(D0)



cleanEx()
nameEx("getLabel")
### * getLabel

flush(stderr()); flush(stdout())

### Name: getLabel
### Title: Labels for distribution objects
### Aliases: getLabel
### Keywords: distribution

### ** Examples

## example due to Kouros Owzar:
foo<- function(law,n, withnames = TRUE)
  {
    data.frame(muhat=mean(r(law)(n)),n=n,law= getLabel(law,withnames))
  } 
### a function that groups certain informations on 
##  created with distribution objects
do.call("rbind",lapply(list(Exp(1),Norm(0,1),Weibull(1,1)),foo,n=100))
do.call("rbind",lapply(list(Exp(1),Norm(0,1),Weibull(1,1)),foo,n=100,FALSE))



cleanEx()
nameEx("igamma")
### * igamma

flush(stderr()); flush(stdout())

### Name: igamma
### Title: Inverse of the digamma function
### Aliases: igamma
### Keywords: math

### ** Examples

igamma(digamma(c(1e-4,1,20,1e8)))



cleanEx()
nameEx("liesInSupport")
### * liesInSupport

flush(stderr()); flush(stdout())

### Name: liesInSupport
### Title: Generic Function for Testing the Support of a Distribution
### Aliases: liesInSupport liesInSupport-methods
###   liesInSupport,UnivarLebDecDistribution,numeric-method
###   liesInSupport,UnivarMixingDistribution,numeric-method
###   liesInSupport,LatticeDistribution,numeric-method
###   liesInSupport,DiscreteDistribution,numeric-method
###   liesInSupport,Distribution,matrix-method
###   liesInSupport,AbscontDistribution,numeric-method
###   liesInSupport,ExpOrGammaOrChisq,numeric-method
###   liesInSupport,Lnorm,numeric-method liesInSupport,Fd,numeric-method
###   liesInSupport,Norm,numeric-method liesInSupport,DExp,numeric-method
###   liesInSupport,Cauchy,numeric-method liesInSupport,Td,numeric-method
###   liesInSupport,Logis,numeric-method
###   liesInSupport,Weibull,numeric-method
###   liesInSupport,Unif,numeric-method liesInSupport,Beta,numeric-method
### Keywords: distribution methods

### ** Examples

liesInSupport(Exp(1), rnorm(10))

# note
x <- rpois(10, lambda = 10)
liesInSupport(Pois(1), x)
# better
liesInSupport(Pois(1), x, checkFin = TRUE)
liesInSupport(Pois(1), 1000*x, checkFin = TRUE)
liesInSupport(-10*Pois(1), -10*x+1, checkFin = TRUE)

xs = c(1000*x,runif(10))
D <- UnivarMixingDistribution(Pois(1),Unif())
liesInSupport(D, xs)




cleanEx()
nameEx("operators-methods")
### * operators-methods

flush(stderr()); flush(stdout())

### Name: operators-methods
### Title: Methods for operators +,-,*,/,... in Package distr
### Aliases: operators-methods operators
###   -,UnivariateDistribution,missing-method
###   -,LatticeDistribution,missing-method -,Norm,missing-method
###   +,UnivariateDistribution,numeric-method
###   +,AbscontDistribution,numeric-method
###   +,DiscreteDistribution,numeric-method
###   +,LatticeDistribution,numeric-method
###   +,UnivarLebDecDistribution,numeric-method
###   +,AffLinAbscontDistribution,numeric-method
###   +,AffLinDiscreteDistribution,numeric-method
###   +,AffLinLatticeDistribution,numeric-method
###   +,AffLinUnivarLebDecDistribution,numeric-method
###   +,CompoundDistribution,numeric-method +,Cauchy,numeric-method
###   +,Dirac,numeric-method +,Norm,numeric-method +,Unif,numeric-method
###   +,numeric,UnivariateDistribution-method
###   +,numeric,LatticeDistribution-method
###   -,UnivariateDistribution,numeric-method
###   -,UnivariateDistribution,UnivariateDistribution-method
###   -,LatticeDistribution,numeric-method
###   -,LatticeDistribution,LatticeDistribution-method
###   -,LatticeDistribution,UnivariateDistribution-method
###   -,UnivariateDistribution,LatticeDistribution-method
###   -,AcDcLcDistribution,AcDcLcDistribution-method
###   -,numeric,UnivariateDistribution-method
###   -,numeric,LatticeDistribution-method
###   *,UnivariateDistribution,numeric-method
###   *,AbscontDistribution,numeric-method
###   *,DiscreteDistribution,numeric-method
###   *,LatticeDistribution,numeric-method
###   *,UnivarLebDecDistribution,numeric-method
###   *,CompoundDistribution,numeric-method
###   *,AffLinAbscontDistribution,numeric-method
###   *,AffLinDiscreteDistribution,numeric-method
###   *,AffLinLatticeDistribution,numeric-method
###   *,AffLinUnivarLebDecDistribution,numeric-method *,DExp,numeric-method
###   *,Exp,numeric-method *,ExpOrGammaOrChisq,numeric-method
###   *,Weibull,numeric-method *,Cauchy,numeric-method
###   *,Dirac,numeric-method *,Norm,numeric-method *,Logis,numeric-method
###   *,Lnorm,numeric-method *,Unif,numeric-method
###   *,numeric,UnivariateDistribution-method
###   *,numeric,LatticeDistribution-method
###   /,UnivariateDistribution,numeric-method
###   /,LatticeDistribution,numeric-method
###   +,UnivariateDistribution,UnivariateDistribution-method
###   +,AbscontDistribution,AbscontDistribution-method
###   +,AbscontDistribution,DiscreteDistribution-method
###   +,DiscreteDistribution,AbscontDistribution-method
###   +,DiscreteDistribution,DiscreteDistribution-method
###   +,LatticeDistribution,DiscreteDistribution-method
###   +,LatticeDistribution,LatticeDistribution-method
###   +,UnivarLebDecDistribution,UnivarLebDecDistribution-method
###   +,AcDcLcDistribution,AcDcLcDistribution-method +,Binom,Binom-method
###   +,Cauchy,Cauchy-method +,Chisq,Chisq-method +,Dirac,Dirac-method
###   +,ExpOrGammaOrChisq,ExpOrGammaOrChisq-method +,Pois,Pois-method
###   +,Nbinom,Nbinom-method +,Norm,Norm-method +,Logis,numeric-method
###   +,Dirac,UnivariateDistribution-method
###   +,Dirac,DiscreteDistribution-method
###   +,UnivariateDistribution,Dirac-method -,numeric,Beta-method
###   -,Dirac,Dirac-method *,Dirac,Dirac-method
###   *,Dirac,UnivariateDistribution-method
###   *,UnivariateDistribution,Dirac-method
###   *,AcDcLcDistribution,AcDcLcDistribution-method /,Dirac,Dirac-method
###   /,numeric,Dirac-method /,numeric,AcDcLcDistribution-method
###   /,AcDcLcDistribution,AcDcLcDistribution-method
###   ^,AcDcLcDistribution,numeric-method
###   ^,AcDcLcDistribution,Integer-method
###   ^,AcDcLcDistribution,AcDcLcDistribution-method
###   ^,numeric,AcDcLcDistribution-method
### Keywords: math distribution arith

### ** Examples

N <- Norm(0,3)
P <- Pois(4)
a <- 3
N + a
N + P
N - a
a * N
a * P
N / a + sin( a * P - N)
N * P
N / N
1.2 ^ N
abs(N) ^ 1.3



cleanEx()
nameEx("options")
### * options

flush(stderr()); flush(stdout())

### Name: options
### Title: additional options in package 'distr'
### Aliases: options newDevice
### Keywords: environment iplot dplot

### ** Examples

getOption("newDevice") 
options("newDevice"=TRUE) 



cleanEx()
nameEx("p-methods")
### * p-methods

flush(stderr()); flush(stdout())

### Name: p-methods
### Title: Methods for Function p in Package 'distr'
### Aliases: p.r-methods p.r p.r,Distribution-method p-methods p
###   p,Distribution-method
### Keywords: distribution methods

### ** Examples

require(distr)
N <- Norm()
p(N)(0.3)
p.r(N)(0.3)



cleanEx()
nameEx("plot-methods")
### * plot-methods

flush(stderr()); flush(stdout())

### Name: plot-methods
### Title: Methods for Function plot in Package 'distr'
### Aliases: plot plot-methods
###   plot,AffLinUnivarLebDecDistribution,missing-method
###   plot,UnivarLebDecDistribution,missing-method
###   plot,AbscontDistribution,missing-method
###   plot,DiscreteDistribution,missing-method
###   plot,CompoundDistribution,missing-method
###   plot,DistrList,missing-method
### Keywords: methods hplot distribution

### ** Examples

plot(Binom(size = 4, prob = 0.3))
plot(Binom(size = 4, prob = 0.3), do.points = FALSE)
plot(Binom(size = 4, prob = 0.3), verticals = FALSE)
plot(Binom(size = 4, prob = 0.3), main = TRUE)
plot(Binom(size = 4, prob = 0.3), main = FALSE)
plot(Binom(size = 4, prob = 0.3), cex.points = 1.2, pch = 20)
plot(Binom(size = 4, prob = 0.3), xlab = list("a1","a2", "a3"),
           ylab=list("p"="U","q"="V","d"="W"))
B <- Binom(size = 4, prob = 0.3)
plot(B, col = "red", col.points = "green", main = TRUE, col.main = "blue", 
     col.sub = "orange", sub = TRUE, cex.sub = 0.6, col.inner = "brown")
plot(Nbinom(size = 4,prob = 0.3), cex.points = 1.2, col = "red", 
     col.points = "green")
plot(Nbinom(size = 4,prob = 0.3), cex.points = 1.2, pch.u = 20, pch.a = 10)
plot(Norm(), main = TRUE, cex.main = 3, tmar = 6)
plot(Norm(), inner = FALSE, main = TRUE, cex.main = 3, tmar = 6)
plot(Norm(), lwd = 3, col = "red", ngrid = 200, lty = 3, las = 2)
plot(Norm(), main = "my Distribution: %A", 
     inner = list(expression(paste(lambda,"-density of %C(%P)")), "CDF",
                  "Pseudo-inverse with param's %N"), 
     sub = "this plot was correctly generated on %D", 
     cex.inner = 0.9, cex.sub = 0.8)

plot(Norm(),panel.first=grid(4,4))
## does not (yet) work as desired:
plot(Norm(),panel.first=list(grid(5,5),grid(3,3),grid(4,4)))
li <- list(substitute(grid(5,5)),substitute(grid(3,3)),substitute(grid(4,4)))
plot(Norm(),panel.first=li)

plot(Cauchy())
plot(Cauchy(), xlim = c(-4,4))
plot(Chisq())
### the next ylab argument is just for illustration purposes
plot(Chisq(),mfColRow = FALSE,to.draw.arg="d",
     xlab="x",ylab=list(expression(paste(lambda,"-density of %C(%P)"))))
## substitution can be switched off
plot(Chisq(),mfColRow = FALSE,to.draw.arg="d",
     xlab="x",ylab=list(expression(paste(lambda,"-density of %C(%P)"))), withSubst=FALSE)
plot(Chisq(), log = "xy", ngrid = 100)
Ch <- Chisq(); setgaps(Ch); plot(Ch, do.points = FALSE)
setgaps(Ch, exactq = 3); plot(Ch, verticals = FALSE)
plot(Ch, cex = 1.2, pch.u = 20, pch.a = 10, col.points = "green", 
     col.vert = "red")

## Not run: 
##D  # to save time 
##D ## some distribution with gaps
##D wg <- flat.mix(UnivarMixingDistribution(Unif(0,1),Unif(4,5), 
##D                withSimplify=FALSE))
##D # some Lebesgue decomposed distribution 
##D mymix <- UnivarLebDecDistribution(acPart = wg, discretePart = Binom(4,.4),
##D          acWeight = 0.4)
##D plot(mymix)         
##D #
##D ## selection of subpanels for plotting
##D N <- Norm()
##D par(mfrow=c(1,2))
##D plot(N, mfColRow = FALSE, to.draw.arg=c("d","q"))
##D plot(N, mfColRow = FALSE, to.draw.arg=c(2,3))
##D par(mfrow=c(1,1))
##D 
##D wg <- flat.mix(UnivarMixingDistribution(Unif(0,1),Unif(4,5),
##D                withSimplify=FALSE))
##D myLC <- UnivarLebDecDistribution(discretePart=Binom(3,.3), acPart = wg,
##D           discreteWeight=.2)
##D layout(matrix(c(rep(1,6),2,2,3,3,4,4,5,5,5,6,6,6), 
##D               nrow=3, byrow=TRUE))
##D plot(myLC,mfColRow = FALSE,
##D      to.draw.arg=c("p","d.c","p.c","q.c", "p.d","q.d"))
##D 
##D P <- Pois(2)
##D plot(as(P,"UnivarLebDecDistribution"),mfColRow = FALSE,to.draw.arg=c("d.d"))
##D ### the next ylab argument is just for illustration purposes
##D plot(as(P,"UnivarLebDecDistribution"),mfColRow = FALSE,to.draw.arg=c("d.d"),
##D      xlab="x",ylab=list(expression(paste(lambda,"-density of %C(%P)"))))
## End(Not run)



cleanEx()
nameEx("q-methods")
### * q-methods

flush(stderr()); flush(stdout())

### Name: q-methods
### Title: Methods for Function q in Package 'distr'
### Aliases: q-methods q q,Distribution-method q.l-methods q.l
###   q.l,Distribution-method
### Keywords: distribution methods

### ** Examples

require(distr)
N <- Norm()
q(N)(0.3)
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
q.l(N)(0.3)



cleanEx()
nameEx("qqbounds")
### * qqbounds

flush(stderr()); flush(stdout())

### Name: qqbounds
### Title: Computation of confidence intervals for qqplot
### Aliases: qqbounds
### Keywords: hplot distribution

### ** Examples

qqplot(Norm(15,sqrt(30)), Chisq(df=15))
## uses:
qqbounds(x = rnorm(30),Norm(),alpha=0.95,n=30,
        withConf.pw = TRUE, withConf.sim  = TRUE,
        exact.sCI=TRUE ,exact.pCI= TRUE,
        nosym.pCI = FALSE)
qqbounds(x = rchisq(30,df=4),Chisq(df=4),alpha=0.95,n=30,
        withConf.pw = TRUE, withConf.sim  = TRUE,
        exact.sCI=FALSE ,exact.pCI= FALSE,
        nosym.pCI = FALSE)
qqbounds(x = rchisq(30,df=4),Chisq(df=4),alpha=0.95,n=30,
        withConf.pw = TRUE, withConf.sim  = TRUE,
        exact.sCI=TRUE ,exact.pCI= TRUE,
        nosym.pCI = TRUE)



cleanEx()
nameEx("qqplot")
### * qqplot

flush(stderr()); flush(stdout())

### Name: qqplot
### Title: Methods for Function qqplot in Package 'distr'
### Aliases: qqplot qqplot-methods qqplot,ANY,ANY-method
###   qqplot,UnivariateDistribution,UnivariateDistribution-method
### Keywords: hplot distribution

### ** Examples

qqplot(Norm(15,sqrt(30)), Chisq(df=15))
## some discrete Distributions:
P <- Pois(5)
B <- Binom(size=2000,prob=5/2000)
qqplot(B,P)
## some Lebesgue-Decomposed distributions:
mylist <- UnivarLebDecDistribution(discretePart=Binom(3,.3), acPart=Norm(2,2),
               acWeight=11/20)
mylist2 <- mylist+0.1
qqplot(mylist,mylist2)
qqplot(mylist,mylist2,exact.pCI=FALSE,exact.sCI=FALSE)



cleanEx()
nameEx("simplifyD-methods")
### * simplifyD-methods

flush(stderr()); flush(stdout())

### Name: simplifyD-methods
### Title: Methods for function simplifyD in Package 'distr'
### Aliases: simplifyD-methods simplifyD
###   simplifyD,AbscontDistribution-method
###   simplifyD,DiscreteDistribution-method
###   simplifyD,UnivarLebDecDistribution-method
###   simplifyD,UnivarMixingDistribution-method
### Keywords: distribution methods

### ** Examples

set.seed(123)
Mix1 <- UnivarMixingDistribution(Norm(),Binom(2,.3),
  UnivarLebDecDistribution(acPart = Chisq(df = 2), discretePart = Nbinom(3,.09),
                           acWeight = 0.3),
  Norm()-Chisq(df=3), mixCoeff=c(0,0,0.2,0.8), withSimplify = FALSE)
Mix2 <- UnivarMixingDistribution(Norm(),Mix1, DExp(2),
        mixCoeff = c(0,0.2,0.8), withSimplify = FALSE)
Mix2        
simplifyD(Mix2)



cleanEx()
nameEx("simplifyr-methods")
### * simplifyr-methods

flush(stderr()); flush(stdout())

### Name: simplifyr-methods
### Title: Methods for Function simplifyr in Package 'distr'
### Aliases: simplifyr-methods simplifyr
###   simplifyr,UnivariateDistribution-method
### Keywords: math distribution arith

### ** Examples

F <- ( Norm() + Binom() + Pois() + Exp() ) * 2 - 10
system.time(r(F)(10^6))
simplifyr(F, size = 10^6)
system.time(r(F)(10^6))


cleanEx()
nameEx("standardMethods")
### * standardMethods

flush(stderr()); flush(stdout())

### Name: standardMethods
### Title: Utility to automatically generate accessor and replacement
###   functions
### Aliases: standardMethods
### Keywords: utilities programming

### ** Examples

setClass("testclass", representation(a = "numeric", b = "character"))
standardMethods("testclass")



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
