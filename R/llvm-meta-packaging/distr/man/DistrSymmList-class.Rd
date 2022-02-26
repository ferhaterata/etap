\name{DistrSymmList-class}
\docType{class}
\alias{DistrSymmList-class}

\title{List of Symmetries for a List of Distributions}
\description{Create a list of symmetries for a list of distributions}
\section{Objects from the Class}{
  Objects can be created by calls of the form \code{new("DistrSymmList", ...)}.
  More frequently they are created via the generating function 
  \code{DistrSymmList}.
}
\section{Slots}{
  \describe{
    \item{\code{.Data}}{ Object of class \code{"list"}. A list 
      of objects of class \code{"DistributionSymmetry"}. }
  }
}
\section{Extends}{
Class \code{"list"}, from data part.\cr
Class \code{"vector"}, by class \code{"list"}.
}
%\section{Methods}{
%}
%\references{}
\author{Matthias Kohl \email{Matthias.Kohl@stamats.de}}
%\note{}
\seealso{\code{\link{DistributionSymmetry-class}}}
\examples{
new("DistrSymmList", list(NoSymmetry(), SphericalSymmetry(SymmCenter = 1), 
                          EllipticalSymmetry(SymmCenter = 2)))
}
\concept{symmetry}
\keyword{classes}
\keyword{distribution}
