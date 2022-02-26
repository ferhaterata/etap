\name{DistrList-class}
\docType{class}
\alias{DistrList-class}
\alias{coerce,Distribution,DistrList-method}
\alias{show,DistrList-method}

\title{List of distributions}
\description{Create a list of distributions}
\section{Objects from the Class}{
  Objects can be created by calls of the form \code{new("DistrList", ...)}.
  More frequently they are created via the generating function 
  \code{DistrList}. 
}
\section{Slots}{
  \describe{
    \item{\code{.Data}}{Object of class \code{"list"}. 
      A list of distributions.}
  }
}
\section{Extends}{
Class \code{"list"}, from data part.\cr
Class \code{"vector"}, by class \code{"list"}.
}
\section{Methods}{
  \describe{
    \item{show}{\code{signature(object = "DistrList")}}
    \item{plot}{\code{signature(object = "DistrList")}}
    \item{coerce}{\code{signature(from = "Distribution", to = "DistrList")}:
      create a \code{"DistrList"} object from a \code{"Distribution"} object}
  }
}
%\references{}
\author{Matthias Kohl \email{Matthias.Kohl@stamats.de}}
%\note{}
\seealso{\code{\link{DistrList}}, \code{\link[distr]{Distribution-class}}}
\examples{
(DL <- new("DistrList", list(Norm(), Exp())))
plot(DL)
as(Norm(), "DistrList")
}
\keyword{distribution}
\keyword{list}
\concept{multivariate distribution}
\concept{S4 distribution class}

