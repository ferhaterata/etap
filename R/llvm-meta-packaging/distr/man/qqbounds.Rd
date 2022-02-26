\name{qqbounds}
\title{Computation of confidence intervals for qqplot}
\usage{
qqbounds(x,D,alpha,n,withConf.pw, withConf.sim,
         exact.sCI=(n<100),exact.pCI=(n<100),
         nosym.pCI = FALSE, debug = FALSE)

}
\alias{qqbounds}

\arguments{
\item{x}{data to be checked for compatibility with distribution \code{D}.}
\item{D}{object of class \code{"UnivariateDistribution"}, the assumed data
distribution.}
\item{alpha}{confidence level}
\item{n}{sample size}
\item{withConf.pw}{logical; shall pointwise confidence lines be computed?}
\item{withConf.sim}{logical; shall simultaneous confidence lines be computed?}
\item{exact.pCI}{logical; shall pointwise CIs be determined with exact Binomial distribution?}
\item{exact.sCI}{logical; shall simultaneous CIs be determined with exact kolmogorov distribution?}
\item{nosym.pCI}{logical; shall we use (shortest) asymmetric CIs?}
\item{debug}{logical; if \code{TRUE} additional output to debug confidence bounds.}
}
\description{
  We compute confidence intervals for QQ plots.
  These can be simultaneous (to check whether the whole data set is compatible)
  or pointwise (to check whether each (single) data point is compatible);}

\details{
  Both simultaneous  and pointwise confidence intervals come in a
  finite-sample and an asymptotic version;
  the finite sample versions will get quite slow
  for large data sets \code{x}, so in these cases the asymptotic version
  will be preferrable.\cr
   For simultaneous intervals,
  the finite sample version is based on C function \code{"pkolmogorov2x"}
  from package \pkg{stats}, while the asymptotic one uses
   R function \code{pkstwo} again from package \pkg{stats}, both taken
   from the code to \code{\link[stats:ks.test]{ks.test}}.

   Both finite sample and asymptotic versions use the fact,
   that the distribution of the supremal distance between the
   empirical distribution \eqn{\hat F_n}{F.emp} and the corresponding theoretical one
   \eqn{F} (assuming data from \eqn{F})
   does not depend on \eqn{F} for continuous distribution \eqn{F}
   and leads to the Kolmogorov distribution (compare, e.g. Durbin(1973)).
   In case of \eqn{F} with jumps, the corresponding Kolmogorov distribution
   is used to produce conservative intervals.
 \cr
    For pointwise intervals,
  the finite sample version is based on corresponding binomial distributions,
  (compare e.g., Fisz(1963)), while the asymptotic one uses a CLT approximation
  for this binomial distribution. In fact, this approximation is only valid
  for distributions with strictly positive density at the evaluation quantiles.

  In the finite sample version, the binomial distributions will in general not
  be symmetric, so that, by setting \code{nosym.pCI} to \code{TRUE} we may
  produce shortest asymmetric confidence intervals (albeit with a considerable
  computational effort).

  The symmetric intervals returned by default will
  be conservative (which also applies to distributions with jumps in this case).

  For distributions with jumps or with density (nearly) equal to 0 at the
  corresponding quantile, we use the approximation of \code{(D-E(D))/sd(D)}
  by the standard normal at these points; this latter approximation is only
  available if package \pkg{distrEx} is installed; otherwise the corresponding
  columns will be filled with \code{NA}.
}
\value{
  A list with components \code{crit} --- a matrix with the lower and upper confidence
  bounds, and \code{err} a logical vector of length 2.

  Component \code{crit} is a matrix with \code{length(x)} rows
  and four columns \code{c("sim.left","sim.right","pw.left","pw.right")}.
  Entries will be set to \code{NA} if the corresponding \code{x} component
  is not in \code{support(D)} or if the computation method returned an error
  or if the corresponding parts have not been required (if \code{withConf.pw}
  or \code{withConf.sim} is \code{FALSE}).

  \code{err} has components \code{pw}
  ---do we have a non-error return value for the computation of pointwise CI's
  (\code{FALSE} if \code{withConf.pw} is \code{FALSE})---  and \code{sim}
  ---do we have a   non-error return value for the computation of simultaneous CI's
  (\code{FALSE} if \code{withConf.sim} is \code{FALSE}).
}
\references{
  Durbin, J. (1973)
  \emph{Distribution theory for tests based on the sample distribution
    function}.  SIAM.

  Fisz, M. (1963). \emph{Probability Theory and Mathematical Statistics}.
  3rd ed. Wiley, New York.
}
\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}
}
\seealso{
  \code{\link[stats:qqnorm]{qqplot}} from package \pkg{stats} -- the standard QQ plot
  function, \code{\link[stats:ks.test]{ks.test}} again from package \pkg{stats}
  for the implementation of the Kolmogorov distributions;
  \code{\link[distr]{qqplot}} from package \pkg{distr} for
  comparisons of distributions, and
 \code{\link[distrMod]{qqplot}} from package \pkg{distrMod} for comparisons
 of data with models, as well as  \code{\link[RobAStBase]{qqplot}} for
 checking of corresponding robust esimators.
}
\examples{
qqplot(Norm(15,sqrt(30)), Chisq(df=15))
## uses:
qqbounds(x = rnorm(30),Norm(),alpha=0.95,n=30,
        withConf.pw = TRUE, withConf.sim  = TRUE,
        exact.sCI=TRUE ,exact.pCI= TRUE,
        nosym.pCI = FALSE)
qqbounds(x = rchisq(30,df=4),Chisq(df=4),alpha=0.95,n=30,
        withConf.pw = TRUE, withConf.sim  = TRUE,
        exact.sCI=FALSE ,exact.pCI= FALSE,
        nosym.pCI = FALSE)
qqbounds(x = rchisq(30,df=4),Chisq(df=4),alpha=0.95,n=30,
        withConf.pw = TRUE, withConf.sim  = TRUE,
        exact.sCI=TRUE ,exact.pCI= TRUE,
        nosym.pCI = TRUE)
}
\keyword{hplot}
\keyword{distribution}
