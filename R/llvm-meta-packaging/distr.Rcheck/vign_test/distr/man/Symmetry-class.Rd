\name{Symmetry-class}
\docType{class}
\alias{Symmetry-class}
\alias{show,Symmetry-method}
\alias{type}
\alias{type,Symmetry-method}
\alias{SymmCenter}
\alias{SymmCenter,Symmetry-method}

\title{Class of Symmetries}
\description{Class of symmetries of various objects.}
\section{Objects from the Class}{A virtual Class: No objects may be created from it.}
\section{Slots}{
  \describe{
    \item{\code{type}}{Object of class \code{"character"}:
      discribes type of symmetry. }
    \item{\code{SymmCenter}}{Object of class \code{"ANY"}:
      center of symmetry. }
  }
}
\section{Methods}{
  \describe{
    \item{type}{\code{signature(object = "Symmetry")}: 
      accessor function for slot \code{type}}

    \item{SymmCenter}{\code{signature(object = "Symmetry")}: 
      accessor function for slot \code{SymmCenter}}

    \item{show}{\code{signature(object = "Symmetry")}}
  }
}
%\references{}
\author{Matthias Kohl \email{Matthias.Kohl@stamats.de}}
%\note{}
\seealso{\code{\link{DistributionSymmetry-class}}, \code{\link{OptionalNumeric-class}}}
%\examples{}
\concept{symmetry}
\keyword{classes}
