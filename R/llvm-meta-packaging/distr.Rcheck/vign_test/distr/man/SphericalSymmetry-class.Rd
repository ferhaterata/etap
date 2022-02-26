\name{SphericalSymmetry-class}
\docType{class}
\alias{SphericalSymmetry-class}

\title{Class for Spherical Symmetric Distributions}
\description{Class for spherical symmetric distributions.}
\section{Objects from the Class}{
  Objects can be created by calls of the form \code{new("SphericalSymmetry")}.
  More frequently they are created via the generating function 
  \code{SphericalSymmetry}. Spherical symmetry for instance leads to 
  a simplification for the computation of optimally robust influence curves.
}
\section{Slots}{
  \describe{
    \item{\code{type}}{Object of class \code{"character"}:
      contains \dQuote{spherical symmetric distribution} }
    \item{\code{SymmCenter}}{Object of class \code{"numeric"}:
      center of symmetry }
  }
}
\section{Extends}{
Class \code{"EllipticalSymmetry"}, directly.\cr
Class \code{"DistributionSymmetry"}, by class \code{"EllipticalSymmetry"}.\cr
Class \code{"Symmetry"}, by class \code{"EllipticalSymmetry"}.
}
%\section{Methods}{}
%\references{}
\author{Matthias Kohl \email{Matthias.Kohl@stamats.de}}
%\note{}
\seealso{\code{\link{SphericalSymmetry}}, \code{\link{DistributionSymmetry-class}}}
\examples{
new("SphericalSymmetry")
}
\concept{spherical symmetry}
\keyword{classes}
\keyword{distribution}
