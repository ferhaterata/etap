\name{Arcsine-class}
\docType{class}
\alias{Arcsine-class}
\alias{Arcsine}
\alias{initialize,Arcsine-method}
\title{Class "Arcsine"}
\description{
  The Arcsine distribution has density
  \deqn{f(x)=\frac{1}{\pi \sqrt{1-x^2}%
  }}{1/sqrt(1+x^2)/pi}
  for \eqn{-1 < x < 1}{-1 < x < 1}.
}

\section{Objects from the Class}{
  Objects can be created by calls of the form \code{Arcsine()}.
  This object is an Arcsine distribution.
}
\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Reals"}:
      The space of the image of this distribution has got dimension 1 and the name "Real Space". }
    \item{\code{r}}{Object of class \code{"function"}:
      generates random numbers (calls function rArcsine)}
    \item{\code{d}}{Object of class \code{"function"}:
      density function (calls function dArcsine)}
    \item{\code{p}}{Object of class \code{"function"}:
      cumulative function (calls function pArcsine)}
    \item{\code{q}}{Object of class \code{"function"}:
      inverse of the cumulative function (calls function qArcsine)}
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
  Class \code{"AbscontDistribution"}, directly. \cr
  Class \code{"UnivariateDistribution"}, by class \code{"AbscontDistribution"}. \cr
  Class \code{"Distribution"}, by class \code{"AbscontDistribution"}.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "Arcsine")}:
      initialize method}
  }
}

\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}
  }
\seealso{
  \code{\link{AbscontDistribution-class}}
  \code{\link{Reals-class}}
}
\examples{
A <- Arcsine()
# A is a Arcsine distribution with shape1 = 1 and shape2 = 1.
r(A)(3) # three random number generated from this distribution, e.g. 0.6979795
d(A)(c(-2,-1,-0.2,0,0.2,1,2)) # Density at x=c(-1,-0.2,0,0.2,1).
p(A)(c(-2,-1,-0.2,0,0.2,1,2)) # cdf at q=c(-1,-0.2,0,0.2,1).
q(A)(c(0,0.2,1,2)) # quantile function at at x=c(0,0.2,1).
## in RStudio or Jupyter IRKernel, use q.l(A)(c(0,0.2,1,2)) instead
}
\keyword{distribution}
\concept{absolutely continuous distribution}
\concept{Arcsine distribution}
\concept{S4 distribution class}
\concept{generating function}
