\name{p-methods}
\docType{methods}
\alias{p.r-methods}
\alias{p.r}
\alias{p.r,Distribution-method}
\alias{p-methods}
\alias{p}
\alias{p,Distribution-method}
\title{ Methods for Function p in Package `distr' }
\description{p-methods}

\section{Methods}{\describe{

\item{p}{\code{signature(object = "Distribution")}: returns the cumulative distribution function (c.d.f.),
i.e.; \eqn{p(t) = P(object \le t)}{p(t) = P(object <= t)}  }
\item{p.r}{\code{signature(object  = "Distribution")}: 
from distr-2.6 onwards, we provide this as a synonym for 
method \code{p}; this synonym more explicitely states that we are dealing with
the right-continuous variant of a c.d.f.}
}}
\seealso{
\code{\link{Distribution-class}}, \code{p.l}
}
\examples{
require(distr)
N <- Norm()
p(N)(0.3)
p.r(N)(0.3)
}
\keyword{distribution}
\keyword{methods}
\concept{cumulative distribution function}
\concept{accessor function}
\concept{CDF}
\concept{right-continuous}
