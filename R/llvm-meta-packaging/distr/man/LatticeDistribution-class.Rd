\name{LatticeDistribution-class}
\docType{class}
\alias{AffLinLatticeDistribution-class}
\alias{LatticeDistribution-class}
\alias{lattice}
\alias{lattice-method}
\alias{lattice,LatticeDistribution-method}
\alias{initialize,LatticeDistribution-method}
\alias{initialize,AffLinLatticeDistribution-method}
\alias{sqrt,LatticeDistribution-method}
\alias{coerce,LatticeDistribution,DiscreteDistribution-method}
\alias{coerce,AffLinLatticeDistribution,AffLinDiscreteDistribution-method}


\title{Class "LatticeDistribution"}
\description{The \code{LatticeDistribution}-class is the mother-class of the 
classes \code{Binom}, \code{Dirac}, \code{Geom}, \code{Hyper}, \code{Nbinom} and 
\code{Poisson}. It formalizes a distribution on a regular affine
linear lattice.}
\section{Objects from the Class}{
The usual way to generate objects of class \code{LatticeDistribution} is to call 
the generating function \code{\link{LatticeDistribution}}. \cr
Somewhat more flexible, but also proner to inconsistencies is a call to 
\code{new("LatticeDistribution")}, where you may explicitly specify random 
number generator, (counting) density, cumulative distribution and quantile 
functions. For conveniance, in this call to \code{new("LatticeDistribution")}, 
an additional possibility is to only specify the random number generator. The 
function \code{RtoDPQ.d} then approximates the three remaining slots \code{d}, 
\code{p} and \code{q} by random sampling. 
}


\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Reals"}: the space of the image 
    of this distribution which has dimension 1 and the name "Real Space" }
    \item{\code{param}}{Object of class \code{"Parameter"}: the parameter of 
    this distribution, having only the slot name 
    "Parameter of a discrete distribution" }
    \item{\code{r}}{Object of class \code{"function"}: 
                     generates random numbers}
    \item{\code{d}}{Object of class \code{"function"}: 
                     (counting) density/probability function}
    \item{\code{p}}{Object of class \code{"function"}: 
                     cumulative distribution function}
    \item{\code{q}}{Object of class \code{"function"}: 
                     quantile function}
    \item{\code{support}}{Object of class \code{"numeric"}: a (sorted) vector 
                           containing the support of the discrete
    density function}
    \item{\code{lattice}}{Object of class \code{"Lattice"}: the lattice 
                           generating the support.}
    \item{\code{.withArith}}{logical: used internally to issue warnings as to 
            interpretation of arithmetics}
    \item{\code{.withSim}}{logical: used internally to issue warnings as to 
          accuracy}
    \item{\code{.logExact}}{logical: used internally to flag the case where 
    there are explicit formulae for the log version of density, cdf, and 
    quantile function}
    \item{\code{.lowerExact}}{logical: used internally to flag the case where 
    there are explicit formulae for the lower tail version of cdf and quantile 
    function}
    \item{\code{Symmetry}}{object of class \code{"DistributionSymmetry"};
     used internally to avoid unnecessary calculations.}
  }
}
\section{Extends}{
Class \code{"UnivariateDistribution"}, directly.\cr
Class \code{"Distribution"}, by class \code{"UnivariateDistribution"}.
}
\section{Methods}{
  \describe{
    \item{\code{initialize}}{\code{signature(.Object = "LatticeDistribution")}: 
                              initialize method }
    \item{-}{\code{signature(e1 = "LatticeDistribution")}: 
                   application of `-' to this lattice distribution}
    \item{*}{\code{signature(e1 = "LatticeDistribution", e2 = "numeric")}: 
                   multiplication of this lattice distribution
    by an object of class `numeric'}
    \item{/}{\code{signature(e1 = "LatticeDistribution", e2 = "numeric")}: 
    division of this lattice distribution by an object of class `numeric'}
    \item{+}{\code{signature(e1 = "LatticeDistribution", e2 = "numeric")}: 
    addition of this lattice distribution to an object of class `numeric'}
    \item{-}{\code{signature(e1 = "LatticeDistribution", e2 = "numeric")}: 
    subtraction of an object of class `numeric' from this lattice 
    distribution }
    \item{*}{\code{signature(e1 = "numeric", e2 = "LatticeDistribution")}: 
    multiplication of this lattice distribution by an object of class `numeric'}
    \item{+}{\code{signature(e1 = "numeric", e2 = "LatticeDistribution")}: 
    addition of this lattice distribution to an object of class `numeric'}
    \item{-}{\code{signature(e1 = "numeric", e2 = "LatticeDistribution")}: 
    subtraction of this lattice distribution from an object of class `numeric'}
    \item{+}{\code{signature(e1 = "LatticeDistribution", 
    e2 = "LatticeDistribution")}: Convolution of two lattice distributions. 
    Slots p, d and q are approximated by grids.}
    \item{-}{\code{signature(e1 = "LatticeDistribution", 
    e2 = "LatticeDistribution")}: Convolution of two lattice
    distributions. The slots p, d and q are approximated by grids.}
    \item{\code{sqrt}}{\code{signature(x = "LatticeDistribution")}:  exact 
         image distribution of \code{sqrt(x)}.}
    \item{\code{lattice}}{accessor method to the corresponding slot.}
    \item{\code{coerce}}{\code{signature(from = "LatticeDistribution",
    to = "DiscreteDistribution")}: coerces an object from 
    \code{"LatticeDistribution"} to \code{"DiscreteDistribution"}
    thereby cancelling out support points with probability 0.}
  }
}

\section{Internal subclass "AffLinLatticeDistribution"}{
To enhance accuracy of several functionals on distributions,
  mainly from package \pkg{distrEx}, there is an internally used 
  (but exported) subclass \code{"AffLinLatticeDistribution"} which has extra slots 
  \code{a}, \code{b} (both of class \code{"numeric"}),  and \code{X0} 
  (of class \code{"LatticeDistribution"}), to capture the fact 
  that the object has the same distribution as \code{a * X0 + b}. This is 
  the class of the return value of methods 
  \describe{
    \item{-}{\code{signature(e1 = "LatticeDistribution")}}
    \item{*}{\code{signature(e1 = "LatticeDistribution", e2 = "numeric")}}
    \item{/}{\code{signature(e1 = "LatticeDistribution", e2 = "numeric")}}
    \item{+}{\code{signature(e1 = "LatticeDistribution", e2 = "numeric")}}
    \item{-}{\code{signature(e1 = "LatticeDistribution", e2 = "numeric")}}
    \item{*}{\code{signature(e1 = "numeric", e2 = "LatticeDistribution")}}
    \item{+}{\code{signature(e1 = "numeric", e2 = "LatticeDistribution")}}
    \item{-}{\code{signature(e1 = "numeric", e2 = "LatticeDistribution")}}
    \item{-}{\code{signature(e1 = "AffLinLatticeDistribution")}}
    \item{*}{\code{signature(e1 = "AffLinLatticeDistribution", e2 = "numeric")}}
    \item{/}{\code{signature(e1 = "AffLinLatticeDistribution", e2 = "numeric")}}
    \item{+}{\code{signature(e1 = "AffLinLatticeDistribution", e2 = "numeric")}}
    \item{-}{\code{signature(e1 = "AffLinLatticeDistribution", e2 = "numeric")}}
    \item{*}{\code{signature(e1 = "numeric", e2 = "AffLinLatticeDistribution")}}
    \item{+}{\code{signature(e1 = "numeric", e2 = "AffLinLatticeDistribution")}}
    \item{-}{\code{signature(e1 = "numeric", e2 = "AffLinLatticeDistribution")}}
  }
 There is also an explicit \code{coerce}-method from class
 \code{"AffLinLatticeDistribution"} to class \code{"AffLinDiscreteDistribution"}
 which cancels out support points with probability 0.
}

\author{Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}}

\note{ Working with a computer, we use a finite interval as support which 
carries at least mass \code{1-getdistrOption("TruncQuantile")}. }

\seealso{
\code{\link{LatticeDistribution}}
\code{\link{Parameter-class}}
\code{\link{Lattice-class}}
\code{\link{UnivariateDistribution-class}}
\code{\link{DiscreteDistribution-class}}
\code{\link{Binom-class}}
\code{\link{Dirac-class}}
\code{\link{Geom-class}}
\code{\link{Hyper-class}}
\code{\link{Nbinom-class}}
\code{\link{Pois-class}}
\code{\link{AbscontDistribution-class}}
\code{\link{Reals-class}}
\code{\link{RtoDPQ.d}}
}
\examples{
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
}
\keyword{distribution}
\concept{discrete distribution}
\concept{lattice distribution}
\concept{lattice of a distribution}
\concept{S4 distribution class}
\concept{generating function}
