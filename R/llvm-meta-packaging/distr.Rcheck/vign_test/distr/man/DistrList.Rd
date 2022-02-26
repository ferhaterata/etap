\name{DistrList}
\alias{DistrList}

\title{Generating function for DistrList-class}
\description{Generates an object of class \code{"DistrList"}.}
\usage{DistrList(..., Dlist)}
\arguments{
  \item{\dots}{Objects of class \code{"Distribution"} (or subclasses)}
  \item{Dlist}{an optional list or object of class \code{"DistrList"};
  if not missing it is appended to argument \code{\dots}; this way
  \code{DistrList} may also be called with a list (or
  \code{"DistrList"}-object) as argument as suggested in an e-mail
  by Krunoslav Sever (thank you!)}
}

%\details{}
\value{Object of class \code{"DistrList"}}
%\references{}
\author{Matthias Kohl \email{Matthias.Kohl@stamats.de}}
%\note{}
\seealso{\code{\link{DistrList-class}}, \code{\link{UnivarDistrList-class}},
  \code{\link{UnivarDistrList}}}
\examples{
(DL <- DistrList(Norm(), Exp(), Pois()))
plot(DL)
as(Norm(), "DistrList")

## The function is currently defined as
function(...){ 
    new("DistrList", list(...)) 
}
}
\keyword{distribution}
\keyword{list}
\concept{multivariate distribution}
\concept{S4 distribution class}
\concept{generating function}
