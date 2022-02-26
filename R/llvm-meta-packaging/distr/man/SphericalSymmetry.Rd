\name{SphericalSymmetry}
\alias{SphericalSymmetry}

\title{Generating function for SphericalSymmetry-class}
\description{Generates an object of class \code{"SphericalSymmetry"}.}
\usage{SphericalSymmetry(SymmCenter = 0)}
\arguments{
  \item{SymmCenter}{ numeric: center of symmetry }
}
%\details{}
\value{Object of class \code{"SphericalSymmetry"}}
%\references{}
\author{Matthias Kohl \email{Matthias.Kohl@stamats.de}}
%\note{}
\seealso{\code{\link{SphericalSymmetry-class}}, \code{\link{DistributionSymmetry-class}}}
\examples{
SphericalSymmetry()

## The function is currently defined as
function(SymmCenter = 0){ 
    new("SphericalSymmetry", SymmCenter = SymmCenter) 
}
}
\concept{spherical symmetry}
\keyword{distribution}
