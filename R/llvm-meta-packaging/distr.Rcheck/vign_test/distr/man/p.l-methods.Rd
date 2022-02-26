\name{p.l-methods}
\docType{methods}
\alias{p.l-methods}
\alias{p.l}
\alias{p.l,AbscontDistribution-method}
\alias{p.l,DiscreteDistribution-method}
\alias{p.l,UnivarLebDecDistribution-method}
\alias{p.l,UnivarMixingDistribution-method}
\title{Methods for Function p.l in Package `distr' }
\description{p-methods}

\section{Methods}{
   return the left continuous cumulative distribution function,
   i.e.; \eqn{p.l(t) = P(object < t)}{p.l(t) = P(object < t)} 
\describe{
\item{p.l}{\code{signature(object = "AbscontDistribution")}} 
\item{p.l}{\code{signature(object = "DiscreteDistribution")}} 
\item{p.l}{\code{signature(object = "UnivarLebDecDistribution")}}
\item{p.l}{\code{signature(object = "UnivarMixingDistribution")}}
}}
\seealso{
\code{\link{DiscreteDistribution-class}}
\code{\link{UnivarLebDecDistribution-class}}
}
\keyword{distribution}
\keyword{methods}
\concept{cumulative distribution function}
\concept{CDF}
\concept{left-continuous}
