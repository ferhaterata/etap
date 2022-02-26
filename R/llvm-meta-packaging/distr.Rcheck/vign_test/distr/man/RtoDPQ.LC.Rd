\name{RtoDPQ.LC}
\alias{RtoDPQ.LC}
\title{Default procedure to fill slots d,p,q given r for Lebesgue decomposed distributions}
\description{
  function to do get empirical density, cumulative distribution and quantile function from random numbers}
\usage{
RtoDPQ.LC(r, e = getdistrOption("RtoDPQ.e"), 
          n = getdistrOption("DefaultNrGridPoints"), y = NULL)
}
\arguments{
  \item{r}{ the random number generator }
  \item{e}{ \eqn{10^e} numbers are generated, a higher number leads to a better result. }
  \item{n}{ The number of grid points used to create the approximated functions, a higher number leads to a better result.}
  \item{y}{a (numeric) vector or \code{NULL}}
}
\details{
RtoDPQ.LC generates \eqn{10^e} random numbers, by default \deqn{e = RtoDPQ.e}. 
Replicates are assumed to be part of the discrete part, unique values to be
part of the a.c. part of the distribution. For the replicated ones,
we generate a discrete distribution by a call to \code{\link{DiscreteDistribution}}.

For the a.c. part, similarly to \code{\link{RtoDPQ}} we have an optional parameter \code{y}
for using N. Horbenko's quantile trick: i.e.; on an equally spaced grid \code{x.grid} on [0,1], apply
\code{f(q(x)(x.grid))}, write the result to \code{y} and use these
values instead of simulated ones.

The a.c. density is formed on the basis of \eqn{n}
points using approxfun and density (applied to the unique values), by default \deqn{n = DefaultNrGridPoints}.
The cumulative distribution function is based on all random variables, 
and, as well as the quantile function, is also created on the basis of \eqn{n} points using 
\code{approxfun} and \code{ecdf}.  Of course, the results are usually not exact as they rely on random numbers.}
\value{ \code{RtoDPQ.LC} returns an object of class \code{UnivarLebDecDistribution}.
}

\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}}

\note{ Use \code{RtoDPQ} for absolutely continuous and \code{RtoDPQ.d} for discrete distributions. }

\seealso{ 
\code{\link{UnivariateDistribution-class}}, 
\code{\link{density}}, 
\code{\link{approxfun}}, 
\code{\link{ecdf}}}
\examples{
rn2 <- function(n)ifelse(rbinom(n,1,0.3),rnorm(n)^2,rbinom(n,4,.3))
x <- RtoDPQ.LC(r = rn2, e = 4, n = 512)
plot(x)
# returns density, cumulative distribution and quantile function of
# squared standard normal distribution
d.discrete(x)(4)
x2 <- RtoDPQ.LC(r = rn2, e = 5, n = 1024) # for a better result
plot(x2)
}
\keyword{math}
\keyword{distribution}
\keyword{arith}
\concept{random sample}
\concept{image distribution}
\concept{absolutely continuous distribution}
\concept{utility}
