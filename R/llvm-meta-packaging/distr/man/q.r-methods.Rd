\name{q.r-methods}
\docType{methods}
\alias{q.r-methods}
\alias{q.r}
\alias{q.r,AbscontDistribution-method}
\alias{q.r,DiscreteDistribution-method}
\alias{q.r,UnivarLebDecDistribution-method}
\alias{q.r,UnivarMixingDistribution-method}
\title{Methods for Function q.r in Package `distr'}
\description{q.r-methods}

\section{Methods}{
return the right-continuous quantile function, i.e.; 
\eqn{{\rm q.r}(s)=\sup\{t \,\big|\, P({\tt object}\leq t)\leq s\}}{q.r(s)=sup\{t|P(object<=t)<=s\}}
\describe{
\item{q.r}{\code{signature(object  = "DiscreteDistribution")}} 
\item{q.r}{\code{signature(object  = "AbscontDistribution")}} 
\item{q.r}{\code{signature(object  = "UnivarLebDecDistribution")}}
\item{q.r}{\code{signature(object  = "UnivarMixingDistribution")}}
}}

\seealso{
\code{\link{DiscreteDistribution-class}}
\code{\link{UnivarLebDecDistribution-class}}
}
\keyword{distribution}
\keyword{methods}
\concept{pseudo-inverse distribution function}
\concept{quantile function}
\concept{left-continuous}
\concept{right-continuous}
