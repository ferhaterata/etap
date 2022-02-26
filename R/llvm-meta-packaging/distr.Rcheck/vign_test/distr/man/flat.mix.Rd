\name{flat.mix}
\alias{flat.mix}
\title{Default procedure to fill slots d,p,q given r for Lebesgue decomposed distributions}
\description{
  function to do get empirical density, cumulative distribution and quantile function from random numbers}
\usage{
flat.mix(object)
}
\arguments{
  \item{object}{object of class \code{UnivariateMixingDistribution}}
}
\details{
flat.mix generates \eqn{10^e} random numbers, by default \deqn{e = RtoDPQ.e}. 
Replicates are assumed to be part of the discrete part, unique values to be
part of the a.c. part of the distribution. For the replicated ones,
we generate a discrete distribution by a call to \code{\link{DiscreteDistribution}}.
The a.c. density is formed on the basis of \eqn{n}
points using approxfun and density (applied to the unique values), by default \deqn{n = DefaultNrGridPoints}.
The cumulative distribution function is based on all random variables, 
and, as well as the quantile function, is also created on the basis of \eqn{n} points using 
\code{approxfun} and \code{ecdf}.  Of course, the results are usually not exact as they rely on random numbers.}
\value{ \code{flat.mix} returns an object of class \code{UnivarLebDecDistribution}.
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
D1 <- Norm()
D2 <- Pois(1)
D3 <- Binom(1,.4)
D4 <- UnivarMixingDistribution(D1,D2,D3, mixCoeff = c(0.4,0.5,0.1), 
      withSimplify = FALSE)
D <- UnivarMixingDistribution(D1,D4,D1,D2, mixCoeff = c(0.4,0.3,0.1,0.2), 
      withSimplify = FALSE)
D
D0<-flat.mix(D)
D0
plot(D0)
}
\keyword{distribution}
\keyword{arith}
\concept{random sample}
\concept{image distribution}
\concept{absolutely continuous distribution}
\concept{utility}
