\name{DistrSymmList}
\alias{DistrSymmList}

\title{Generating function for DistrSymmList-class}
\description{
  Generates an object of class \code{"DistrSymmList"}.
}
\usage{
DistrSymmList(...)
}
\arguments{
  \item{\dots}{ Objects of class \code{"DistributionSymmetry"} which
    shall form the list of symmetry types. }
}
%\details{}
\value{ Object of class \code{"DistrSymmList"} }
%\references{}
\author{Matthias Kohl \email{Matthias.Kohl@stamats.de}}
%\note{}
\seealso{\code{\link{DistrSymmList-class}}}
\examples{
DistrSymmList(NoSymmetry(), SphericalSymmetry(SymmCenter = 1), 
              EllipticalSymmetry(SymmCenter = 2))

## The function is currently defined as
function (...){
    new("DistrSymmList", list(...))
}
}
\concept{symmetry}
\keyword{distribution}
