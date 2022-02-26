\name{getLow,getUp}
\alias{getUp}
\alias{getUp-methods}
\alias{getUp,AbscontDistribution-method}
\alias{getUp,DiscreteDistribution-method}
\alias{getUp,LatticeDistribution-method}
\alias{getUp,UnivarLebDecDistribution-method}
\alias{getUp,UnivarMixingDistribution-method}
\alias{getLow}
\alias{getLow-methods}
\alias{getLow,AbscontDistribution-method}
\alias{getLow,DiscreteDistribution-method}
\alias{getLow,LatticeDistribution-method}
\alias{getLow,UnivarLebDecDistribution-method}
\alias{getLow,UnivarMixingDistribution-method}

\title{getLow, getUp functions of package distr}

\description{
getLow, getUp return lower and upper endpoint of a distribution ---
truncated to lower/upper \code{TruncQuantile} if infinite; in case of an object 
of class \code{"LatticeDistribution"} with infinite lattice length, we search
for the smallest/largest point in the lattice which is returned by succesive
halving of \code{x=0.5} in \code{q(object)(x, lower.tail)} for \code{lower.tail} 
\code{TRUE} resp. \code{false}.}

\usage{
\S4method{getUp}{AbscontDistribution}(object,
                                      eps = getdistrOption("TruncQuantile"))
\S4method{getUp}{DiscreteDistribution}(object, ...)
\S4method{getUp}{LatticeDistribution}(object, ...)
\S4method{getUp}{UnivarLebDecDistribution}(object,
                                      eps = getdistrOption("TruncQuantile"))
\S4method{getUp}{UnivarMixingDistribution}(object,
                                      eps = getdistrOption("TruncQuantile"))
\S4method{getLow}{AbscontDistribution}(object,
                                       eps = getdistrOption("TruncQuantile"))
\S4method{getLow}{DiscreteDistribution}(object, ...)
\S4method{getLow}{LatticeDistribution}(object, ...)
\S4method{getLow}{UnivarLebDecDistribution}(object,
                                      eps = getdistrOption("TruncQuantile"))
\S4method{getLow}{UnivarMixingDistribution}(object,
                                      eps = getdistrOption("TruncQuantile"))
}
\arguments{
  \item{object}{a distribution object}
  \item{eps}{truncation point (numeric)}
  \item{\dots}{for convenience only; makes it possible to call \code{getLow}, 
  \code{getUp} with argument \code{eps} no matter of the class of \code{object};
  is ignored in these functions.}
}



\value{
\item{getLow,getUp}{a \code{numeric} of length 1}
}


\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}
  }

\keyword{methods}
\keyword{distribution}
\concept{support}
\concept{utilities}
