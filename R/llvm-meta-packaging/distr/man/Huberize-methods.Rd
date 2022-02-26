\name{Huberize-methods}
\docType{methods}
\alias{Huberize-methods}
\alias{Huberize}
\alias{Huberize,AcDcLcDistribution-method}
\title{ Methods for function Huberize in Package `distr' }
\description{Huberize-methods}
\usage{
Huberize(object, ...)
\S4method{Huberize}{AcDcLcDistribution}(object,lower,upper,
                    withSimplify = getdistrOption("simplifyD"))
}
\arguments{
  \item{object}{distribution object}
  \item{\ldots}{further arguments for \code{Huberize}; takes up \code{lower}, 
  \code{upper}, \code{withSimplify}.}
  \item{lower}{numeric; lower truncation point}
  \item{upper}{numeric; upper truncation point}
  \item{withSimplify}{logical; is result to be piped through a call to
         \code{\link{simplifyD}}?}

}
\value{the corresponding distribution of the truncated random variable}
\section{Methods}{\describe{
\item{Huberize}{\code{signature(object = "AcDcLcDistribution")}:
returns the unconditioned
distribution of \code{min(upper,max(X,lower))}, if \code{X} is
distributed according to \code{object};
the result is of class \code{"UnivarLebDecDistribution"} in general.}
}}
\examples{
Hub <- Huberize(Norm(),lower=-1,upper=2)
Hub 
plot(Hub)
}
\seealso{\code{\link{Truncate}}}
\keyword{distribution}
\keyword{methods}
\concept{truncation}
