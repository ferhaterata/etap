\name{showobj-methods}
\docType{methods}
\alias{showobj}
\alias{showobj-methods}
\alias{showobj,UnivariateDistribution-method}
\alias{showobj,DistrList-method}
\alias{showobj,UnivarMixingDistribution-method}
\alias{showobj,UnivarLebDecDistribution-method}
\alias{showobj,CompoundDistribution-method}
\title{Helping Methods for Functions print/show in Package `distr' }
\description{showobj-methods}

\usage{
showobj(object, ...)
\S4method{showobj}{UnivariateDistribution}(object, className = class(object)[1])
\S4method{showobj}{CompoundDistribution}(object, className = class(object)[1])
\S4method{showobj}{DistrList}(object, className = class(object)[1])
\S4method{showobj}{UnivarMixingDistribution}(object, className = class(object)[1])
\S4method{showobj}{UnivarLebDecDistribution}(object, className = class(object)[1],
objs)
}
\arguments{
  \item{\dots}{further parameters for \code{showobj}; not yet used.}
  \item{object}{distribution [list] object}
  \item{className}{name of the class of the object}
  \item{objs}{a character capturing the input from \code{show}, \code{print}}
}
\value{a character vector, which is then shown by method \code{show},
but can also be indented if necessary --- like in the possibly nested 
list classes}

\seealso{\code{\link{print-methods}}}
\keyword{print}
\keyword{methods}
\keyword{internal}
\keyword{distribution}





