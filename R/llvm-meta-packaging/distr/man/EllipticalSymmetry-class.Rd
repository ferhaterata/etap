\name{EllipticalSymmetry-class}
\docType{class}
\alias{EllipticalSymmetry-class}

\title{Class for Elliptically Symmetric Distributions}
\description{Class for elliptically symmetric distributions.}
\section{Objects from the Class}{
  Objects can be created by calls of the form \code{new("EllipticalSymmetry")}.
  More frequently they are created via the generating function 
  \code{EllipticalSymmetry}. Elliptical symmetry for instance leads to 
  a simplification for the computation of optimally robust influence curves.
}
\section{Slots}{
  \describe{
    \item{\code{type}}{Object of class \code{"character"}:
      contains \dQuote{elliptical symmetric distribution} }
    \item{\code{SymmCenter}}{Object of class \code{"numeric"}:
      center of symmetry }
  }
}
\section{Extends}{
Class \code{"DistributionSymmetry"}, directly.\cr
Class \code{"Symmetry"}, by class \code{"DistributionSymmetry"}.
}
%\section{Methods}{}
%\references{}
\author{Matthias Kohl \email{Matthias.Kohl@stamats.de}}
%\note{}
\seealso{\code{\link{EllipticalSymmetry}}, \code{\link{DistributionSymmetry-class}}}
\examples{
new("EllipticalSymmetry")
}
\concept{elliptical symmetry}
\concept{symmetry}
\keyword{classes}
\keyword{distribution}
