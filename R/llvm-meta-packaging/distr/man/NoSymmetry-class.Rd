\name{NoSymmetry-class}
\docType{class}
\alias{NoSymmetry-class}

\title{Class for Non-symmetric Distributions}
\description{Class for non-symmetric distributions.}
\section{Objects from the Class}{
  Objects can be created by calls of the form \code{new("NoSymmetry")}.
  More frequently they are created via the generating function 
  \code{NoSymmetry}.
}
\section{Slots}{
  \describe{
    \item{\code{type}}{Object of class \code{"character"}:
      contains \dQuote{non-symmetric distribution} }
    \item{\code{SymmCenter}}{Object of class \code{"NULL"} }
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
\seealso{\code{\link{NoSymmetry}}, \code{\link[distr]{Distribution-class}}}
\examples{
new("NoSymmetry")
}
\concept{symmetry}
\keyword{classes}
\keyword{distribution}
