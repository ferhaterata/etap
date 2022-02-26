\name{RtoDPQ}
\alias{RtoDPQ}
\title{Default procedure to fill slots d,p,q given r for a.c. distributions}
\description{
  function to do get empirical density, cumulative distribution and quantile function from random numbers}
\usage{
RtoDPQ(r, e = getdistrOption("RtoDPQ.e"), 
       n = getdistrOption("DefaultNrGridPoints"), y = NULL)
}
\arguments{
  \item{r}{ the random number generator }
  \item{e}{ \eqn{10^e} numbers are generated, a higher number leads to a better result. }
  \item{n}{ The number of grid points used to create the approximated functions, a higher number leads to a better result.}
  \item{y}{a (numeric) vector or \code{NULL}}
}
\details{
RtoDPQ generates \eqn{10^e} random numbers, by default \deqn{e = RtoDPQ.e}. 
Instead of using simulated grid points, we have an optional parameter \code{y}
for using N. Horbenko's quantile trick: i.e.; on an equally spaced grid \code{x.grid} on [0,1], apply
\code{f(q(x)(x.grid))} and write the result to \code{y} and produce density and cdf from this
value \code{y} given to \code{RtoDPQ} as argument (instead of simulating grid points).

The density is formed on the basis of \eqn{n}
points using approxfun and density, by default \deqn{n = DefaultNrGridPoints}.
The cumulative distribution function and the quantile function are also created on the basis of \eqn{n} points using 
\code{approxfun} and \code{ecdf}.  Of course, the results are usually not exact as they rely on random numbers.}
\value{ \code{RtoDPQ} returns a list of functions.
  \item{dfun }{ density }
  \item{pfun }{ cumulative distribution function }
  \item{qfun }{ quantile function }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}}

\note{ Use \code{RtoDPQ} for absolutely continuous and \code{RtoDPQ.d} for discrete distributions. }

\seealso{ 
\code{\link{UnivariateDistribution-class}}, 
\code{\link{density}}, 
\code{\link{approxfun}}, 
\code{\link{ecdf}}}
\examples{
rn2 <- function(n){rnorm(n)^2}
x <- RtoDPQ(r = rn2, e = 4, n = 512)
# returns density, cumulative distribution and quantile function of
# squared standard normal distribution
x$dfun(4)
RtoDPQ(r = rn2, e = 5, n = 1024) # for a better result

rp2 <- function(n){rpois(n, lambda = 1)^2}
x <- RtoDPQ.d(r = rp2, e = 5)
# returns density, cumulative distribution and quantile function of
# squared Poisson distribution with parameter lambda=1
}
\keyword{math}
\keyword{distribution}
\keyword{arith}
\concept{random sample}
\concept{image distribution}
\concept{absolutely continuous distribution}
\concept{utility}
