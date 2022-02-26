\name{gaps-methods}
\docType{methods}
\alias{gaps-methods}
\alias{setgaps-methods}
\alias{gaps<--methods}
\alias{gaps}
\alias{setgaps}
\alias{gaps<-}
\alias{gaps,AbscontDistribution-method}
\alias{gaps<-,AbscontDistribution-method}
\alias{setgaps,AbscontDistribution-method}
\alias{setgaps,UnivarMixingDistribution-method}
\title{ Methods for Functions gaps and setgaps in Package `distr' }
\description{[set]gaps-methods}
\usage{gaps(object)
gaps(object)
gaps(object) <- value
setgaps(object, ...)
\S4method{gaps}{AbscontDistribution}(object)
%\S4method{gaps<-}{AbscontDistribution}(object, value)
\S4method{setgaps}{AbscontDistribution}(object, exactq = 6, 
           ngrid = 50000, ...)
}
\arguments{
  \item{object}{object of class  \code{"AbscontDistribution"} (or subclasses)}
  \item{\dots}{further arguments to be passed to \code{setgaps}; not yet used.}
  \item{value}{\eqn{n \times 2}{n x 2} matrix \code{m} of numerics where 
               \code{c(t(m))} is an ordered vector; value to be assigned to slot 
               \code{gaps}}
  \item{exactq}{density values smaller than 
                \eqn{10^{\scriptsize -{\rm exactq}}}{10^-exactq}
                are considered as \eqn{0}.} 
  \item{ngrid}{number of gridpoints at which the density is evaluated.} 
}

\section{Methods}{\describe{
\item{gaps}{\code{signature(object = "AbscontDistribution")}: returns  slot 
\code{gaps} of an absolutely continuous distribution}
\item{setgaps}{\code{signature(object = "AbscontDistribution")}: tries to find 
out the gaps (where \code{d(object)} is approximately
 0) and fills slot \code{gaps} of \code{object} correspondingly}
\item{setgaps}{\code{signature(object = "UnivarMixingDistribution")}: 
for each mixing component, if it has a slot \code{gaps}, tries to find out the gaps 
 and fills slot \code{gaps} of the component correspondingly, and,
 subsequently merges all found gap-slots of the components to a gap-slot
 for the object, using internal function \code{\link{.mergegaps2}}.}
\item{gaps<-}{\code{signature(object = "AbscontDistribution")}: modifies  slot 
\code{gaps} of an absolutely continuous distribution}
}}
\keyword{methods}
\keyword{distribution}
\concept{absolutely continuous distribution}
\concept{accessor function}
\concept{replacement function}
