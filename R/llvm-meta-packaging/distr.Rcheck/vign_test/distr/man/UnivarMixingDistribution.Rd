\name{UnivarMixingDistribution}
\alias{UnivarMixingDistribution}

\title{Generating function for Class "UnivarMixingDistribution"}
\description{Generates an object of class \code{"UnivarMixingDistribution"}.}
\usage{UnivarMixingDistribution(..., Dlist, mixCoeff, 
                                withSimplify = getdistrOption("simplifyD"))}
\arguments{
  \item{\dots}{Objects of class \code{"UnivariateDistribution"} (or subclasses)}
  \item{Dlist}{an optional list or object of class \code{"UnivarDistrList"};
  if not missing it is appended to argument \code{\dots}; this way 
  \code{UnivarMixingDistribution} may also be called with a list (or 
  \code{"UnivarDistrList"}-object) as argument as suggested in an e-mail
  by Krunoslav Sever (thank you!)}
  \item{mixCoeff}{Objects of class \code{"numeric"} : a vector of 
            probabilities for the mixing components (must be of same length as
            arguments in \dots).}
  \item{withSimplify}{\code{"logical"}: shall the return value be piped through a 
   call to \code{simplifyD}?}
}
\details{If \code{mixCoeff} is missing, all elements in \code{\dots}
  are equally weighted.}
\value{Object of class \code{"UnivarMixingDistribution"}, or if 
argument \code{withSimplify} is \code{TRUE} and the resulting 
object would have one mixing component with probability (almost) 1,
\code{UnivarMixingDistribution} will return this component.}
%\references{}
\author{Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}}
%\note{}
\seealso{\code{\link{UnivarMixingDistribution-class}},
  \code{\link{simplifyD}}}
\examples{
mylist <- UnivarMixingDistribution(Binom(3,.3), Dirac(2), Norm(), 
          mixCoeff=c(1/4,1/5,11/20))
}
\keyword{distribution}
\keyword{list}
\concept{multivariate distribution}
\concept{S4 distribution class}
\concept{generating function}

