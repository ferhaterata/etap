\name{UnivarDistrList}
\alias{UnivarDistrList}

\title{Generating function for UnivarDistrList-class}
\description{Generates an object of class \code{"UnivarDistrList"}.}
\usage{UnivarDistrList(..., Dlist)}
\arguments{
  \item{\dots}{Objects of class \code{"UnivariateDistribution"} (or subclasses)}
  \item{Dlist}{an optional list or object of class \code{"UnivarDistrList"};
  if not missing it is appended to argument \code{\dots}; this way
  \code{UnivarMixingDistribution} may also be called with a list (or
  \code{"UnivarDistrList"}-object) as argument as suggested in an e-mail
  by Krunoslav Sever (thank you!)}
}
%\details{}
\value{Object of class \code{"UnivarDistrList"}}
%\references{}
\author{Matthias Kohl \email{Matthias.Kohl@stamats.de}}
%\note{}
\seealso{\code{\link{DistrList-class}}, \code{\link{UnivarDistrList-class}},
  \code{\link{UnivarDistrList}}}
\examples{
(DL <- UnivarDistrList(Norm(), Exp(), Pois()))
plot(DL)
as(Norm(), "UnivarDistrList")

## The function is currently defined as
function(...){ 
    new("UnivarDistrList", list(...)) 
}
}
\keyword{list}
\keyword{distribution}
\concept{univariate distribution}
\concept{S4 distribution class}

