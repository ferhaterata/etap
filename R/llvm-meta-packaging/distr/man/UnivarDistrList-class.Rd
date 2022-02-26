\name{UnivarDistrList-class}
\docType{class}
\alias{UnivarDistrList-class}
\alias{coerce,UnivariateDistribution,UnivarDistrList-method}

\title{List of univariate distributions}
\description{Create a list of univariate distributions}
\section{Objects from the Class}{
  Objects can be created by calls of the form \code{new("UnivarDistrList", ...)}.
  More frequently they are created via the generating function 
  \code{\link{DistrList}}. 
}
\section{Slots}{
  \describe{
      \item{\code{.Data}}{Object of class \code{"list"}. 
      A list of univariate distributions.}
  }
}
\section{Extends}{
Class \code{"DistrList"}, directly.\cr
Class \code{"list"}, by class \code{"DistrList"}.\cr
Class \code{"vector"}, by class \code{"DistrList"}.
}
\section{Methods}{
  \describe{
    \item{coerce}{\code{signature(from = "UnivariateDistribution", to = "UnivarDistrList")}:
      create a \code{UnivarDistrList} object from a univariate distribution}
  }
}
%\references{}
\author{Matthias Kohl \email{Matthias.Kohl@stamats.de}}
%\note{}
\seealso{\code{\link{UnivarDistrList}}, \code{\link{DistrList-class}},
    \code{\link[distr]{UnivariateDistribution-class}}}
\examples{
(DL <- new("UnivarDistrList", list(Norm(), Exp())))
plot(DL)
as(Norm(), "UnivarDistrList")
}
\keyword{distribution}
\keyword{list}
\concept{multivariate distribution}
\concept{S4 distribution class}

