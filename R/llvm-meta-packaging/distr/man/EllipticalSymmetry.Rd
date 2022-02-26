\name{EllipticalSymmetry}
\alias{EllipticalSymmetry}

\title{Generating function for EllipticalSymmetry-class}
\description{Generates an object of class \code{"EllipticalSymmetry"}.}
\usage{EllipticalSymmetry(SymmCenter = 0)}
\arguments{
  \item{SymmCenter}{ numeric: center of symmetry }
}
%\details{}
\value{Object of class \code{"EllipticalSymmetry"}}
%\references{}
\author{Matthias Kohl \email{Matthias.Kohl@stamats.de}}
%\note{}
\seealso{\code{\link{EllipticalSymmetry-class}}, \code{\link{DistributionSymmetry-class}}}
\examples{
EllipticalSymmetry()

## The function is currently defined as
function(SymmCenter = 0){ 
    new("EllipticalSymmetry", SymmCenter = SymmCenter) 
}
}
\concept{elliptical symmetry}
\concept{symmetry}
\keyword{distribution}
