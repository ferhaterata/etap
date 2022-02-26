\name{RtoDPQ.d}
\alias{RtoDPQ.d}
\title{Default procedure to fill slots d,p,q given r for discrete distributions}
\description{
function to do get empirical density, cumulative distribution and quantile function from random numbers}
\usage{
RtoDPQ.d(r, e = getdistrOption("RtoDPQ.e"))
}
\arguments{
  \item{r}{ the random number generator }
  \item{e}{ \eqn{10^e} numbers are generated, a higher number leads to a better result. }
}
\details{
  \code{RtoDPQ.d} generates \eqn{10^e} random numbers, by default \eqn{e =}
  \code{RtoDPQ.e} which are used to produce a density, cdf and
  quantile function.
  Of course, the results are usually not exact as they rely on random numbers.}
\value{ RtoDPQ returns a list of functions.
  \item{dfun }{ density }
  \item{pfun }{ cumulative distribution function }
  \item{qfun }{ quantile function }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
}
\note{
  Use RtoDPQ for absolutely continuous and RtoDPQ.d for discrete
  distributions.
}
\seealso{ 
\code{\link{UnivariateDistribution-class}}, 
\code{\link{density}}, 
\code{\link{approxfun}}, 
\code{\link{ecdf}}}
\examples{
rn2 <- function(n){rnorm(n)^2}
x <- RtoDPQ(r = rn2, e = 4, n = 512)
# returns density, cumulative distribution and quantile function of
# squared standard  normal distribution

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
\concept{discrete distribution}
\concept{utility}
