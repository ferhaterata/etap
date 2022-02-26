\name{CompoundDistribution-class}
\docType{class}
\alias{CompoundDistribution-class}
\alias{NumbOfSummandsDistr}
\alias{SummandsDistr}
\alias{NumbOfSummandsDistr-methods}
\alias{SummandsDistr-methods}
\alias{NumbOfSummandsDistr,CompoundDistribution-method}
\alias{SummandsDistr,CompoundDistribution-method}
\alias{coerce,CompoundDistribution,UnivarLebDecDistribution-method}
\alias{UnivDistrListOrDistribution-class}

\title{Class "CompoundDistribution"}
\description{\code{CompoundDistribution}-class is a class to formalize 
                   compound distributions; it is a subclass to
                   class \code{UnivarMixingDistribution}.}
\section{Objects from the Class}{
Objects can be created by calls of the form 
\code{new("CompoundDistribution", ...)}.
  More frequently they are created via the generating function 
  \code{\link{CompoundDistribution}}.
}
\section{Slots}{
  \describe{
    \item{\code{NumbOfSummandsDistr}}{Object of class \code{"DiscreteDistribution"},
     the frequency distribution.}
    \item{\code{SummandsDistr}}{Object of class \code{"UnivDistrListOrDistribution"},
     that is, either of class \code{"UnivarDistrList"} (non i.i.d. case) or
     of class \code{"UnivariateDistribution"} (i.i.d. case); the summand distribution(s).}
    \item{\code{mixCoeff}}{Object of class \code{"numeric"}: a vector of 
            probabilities for the mixing components.}
    \item{\code{mixDistr}}{Object of class \code{"UnivarDistrList"}: a list of
    univariate distributions containing the mixing components; must be of same
    length as \code{mixCoeff}.}
    \item{\code{img}}{Object of class \code{"Reals"}: the space of the image of this distribution which has dimension 1
    and the name "Real Space" }
    \item{\code{param}}{Object of class \code{"Parameter"}: the parameter of this distribution, having only the
    slot name "Parameter of a discrete distribution" }
    \item{\code{r}}{Object of class \code{"function"}: generates random numbers}
    \item{\code{d}}{fixed to \code{NULL}}
    \item{\code{p}}{Object of class \code{"function"}: cumulative distribution function}
    \item{\code{q}}{Object of class \code{"function"}: quantile function}
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
Class \code{"UnivarMixingDistribution"}
class \code{"UnivarDistribution"} by class \code{"UnivarMixingDistribution"},
class \code{"Distribution"} by class \code{"UnivariateDistribution"}.
}
\section{Methods}{
  \describe{
    \item{show}{\code{signature(object = "CompoundDistribution")} prints the object}
    \item{SummandsDistr}{\code{signature(object = "CompoundDistribution")} returns the corresponding slot}
    \item{NumbOfSummandsDistr}{\code{signature(object = "CompoundDistribution")} returns the corresponding slot}
  }
}
\section{setAs relations}{
  There is a coerce method to coerce objects of class \code{"CompoundDistribution"} to
  class \code{UnivarLebDecDistribution}; this is done by a simple call to \code{simplifyD}.
}


\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}
  }

\seealso{
\code{\link{Parameter-class}}, 
\code{\link{UnivariateDistribution-class}}, 
\code{\link{LatticeDistribution-class}}, 
\code{\link{AbscontDistribution-class}}, 
\code{\link{simplifyD}}, 
\code{\link{flat.mix}}
}
\examples{
CP <- CompoundDistribution(Pois(),Norm())
CP
p(CP)(0.3)          
plot(CP)
}
\keyword{distribution}
\concept{lattice distribution}
\concept{support of a distribution}
\concept{S4 distribution class}
\concept{generating function}
\concept{compound distribution}
