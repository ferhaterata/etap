\name{PosDefSymmMatrix-class}
\docType{class}
\alias{PosDefSymmMatrix-class}
\alias{PosSemDefSymmMatrix-class}

\title{Positive-[Semi-]definite, symmetric matrices}
\description{The class of positive-[semi-]definite, symmetric matrices.}
\section{Objects from the Class}{
  Objects can be created by calls of the form \code{new("PosSemDefSymmMatrix", ...)}
  resp. \code{new("PosDefSymmMatrix", ...)}.
  More frequently they are created via the generating functions
  \code{PosSemDefSymmMatrix} resp. \code{PosDefSymmMatrix}. 
}
\section{Slots}{
  \describe{
    \item{\code{.Data}}{Object of class \code{"matrix"}. 
      A numeric matrix with finite entries.}
  }
}
\section{Extends}{
[Class \code{"PosSemDefSymmMatrix"}, directly]
Class \code{"matrix"}, from data part.\cr
Class \code{"structure"}, by class \code{"matrix"}.\cr
Class \code{"array"}, by class \code{"matrix"}.\cr
Class \code{"vector"}, by class "matrix", with explicit coerce.\cr
Class \code{"vector"}, by class "matrix", with explicit coerce.
}
%\section{Methods}{}
%\references{}
\author{Matthias Kohl \email{Matthias.Kohl@stamats.de},
Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}}
%\note{}
\seealso{\code{\link{PosDefSymmMatrix}}, \code{\link[methods:StructureClasses]{matrix-class}}}
\examples{
new("PosDefSymmMatrix", diag(2))
}
\concept{positive-definite matrix}
\concept{positive-semi-definite matrix}
\concept{symmetric matrix}
\keyword{classes}
\keyword{array}
