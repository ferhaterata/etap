\name{qqplot}
\docType{methods}
\alias{qqplot}
\alias{qqplot-methods}
\alias{qqplot,ANY,ANY-method}
\alias{qqplot,UnivariateDistribution,UnivariateDistribution-method}

\title{Methods for Function qqplot in Package `distr'}
\usage{
qqplot(x, y, ...)
\S4method{qqplot}{UnivariateDistribution,UnivariateDistribution}(x, y,
    n = 30, withIdLine = TRUE, withConf = TRUE,
    withConf.pw  = withConf,  withConf.sim = withConf,
    plot.it = TRUE, xlab = deparse(substitute(x)),
    ylab = deparse(substitute(y)), ...,
    width = 10, height = 5.5, withSweave = getdistrOption("withSweave"),
    mfColRow = TRUE, n.CI = n, col.IdL = "red", lty.IdL = 2, lwd.IdL = 2,
    alpha.CI = .95, exact.pCI = (n<100), exact.sCI = (n<100), nosym.pCI = FALSE,
    col.pCI = "orange", lty.pCI = 3, lwd.pCI = 2, pch.pCI = par("pch"),
    cex.pCI = par("cex"),
    col.sCI = "tomato2", lty.sCI = 4, lwd.sCI = 2, pch.sCI = par("pch"),
    cex.sCI = par("cex"),
    cex.pch = par("cex"), col.pch = par("col"),
    jit.fac = 0, check.NotInSupport = TRUE,
    col.NotInSupport = "red", with.legend = TRUE, legend.bg = "white",
    legend.pos = "topleft", legend.cex = 0.8, legend.pref = "", 
    legend.postf = "", legend.alpha = alpha.CI, debug = FALSE, withSubst = TRUE)
\S4method{qqplot}{ANY,ANY}(x, y,
    plot.it = TRUE, xlab = deparse(substitute(x)),
    ylab = deparse(substitute(y)), ...)
}

\arguments{
\item{x}{object of class \code{"ANY"} (\pkg{stats}-method) or
of code \code{"UnivariateDistribution"}; to be compared to \code{y}.}
\item{y}{object of class \code{"ANY"} (\pkg{stats}-method) or
of class \code{"UnivariateDistribution"}.}
\item{n}{numeric; number of quantiles at which to do the comparison.}
\item{withIdLine}{logical; shall line \code{y = x} be plotted in?}
\item{withConf}{logical; shall confidence lines be plotted?}
\item{withConf.pw}{logical; shall pointwise confidence lines be plotted?}
\item{withConf.sim}{logical; shall simultaneous confidence lines be plotted?}
\item{plot.it}{logical; shall be plotted at all (inherited from \code{\link[stats:qqnorm]{qqplot}})?}
\item{xlab}{x-label}
\item{ylab}{y-label}
\item{\dots}{further parameters for function \code{plot}}
\item{width}{width (in inches) of the graphics device opened}
\item{height}{height (in inches) of the graphics device opened}
\item{withSweave}{logical: if \code{TRUE} (for working with \command{Sweave})
        no extra device is opened and height/width are not set}
\item{mfColRow}{shall default partition in panels be used --- defaults to \code{TRUE}}
\item{n.CI}{numeric; number of points to be used for confidence interval}
\item{col.IdL}{color for the identity line}
\item{lty.IdL}{line type for the identity line}
\item{lwd.IdL}{line width for the identity line}
\item{alpha.CI}{confidence level}
\item{exact.pCI}{logical; shall pointwise CIs be determined with exact Binomial distribution?}
\item{exact.sCI}{logical; shall simultaneous CIs be determined with exact kolmogorov distribution?}
\item{nosym.pCI}{logical; shall we use (shortest) asymmetric CIs?}
\item{col.pCI}{color for the pointwise CI}
\item{lty.pCI}{line type for the pointwise CI}
\item{lwd.pCI}{line width for the pointwise CI}
\item{pch.pCI}{symbol for points (for discrete mass points) in pointwise CI}
\item{cex.pCI}{magnification factor for points (for discrete mass points) in pointwise CI}
\item{col.sCI}{color for the simultaneous CI}
\item{lty.sCI}{line type for the simultaneous CI}
\item{lwd.sCI}{line width for the simultaneous CI}
\item{pch.sCI}{symbol for points (for discrete mass points) in simultaneous CI}
\item{cex.sCI}{magnification factor for points (for discrete mass points) in simultaneous CI}
\item{cex.pch}{magnification factor for the plotted symbols}
\item{col.pch}{color for the plotted symbols}
\item{jit.fac}{jittering factor used for discrete distributions}
\item{check.NotInSupport}{logical; shall we check if all \code{x}-quantiles lie in \code{support(y)}?}
\item{col.NotInSupport}{logical; if preceding check \code{TRUE} color of \code{x}-quantiles if not in \code{support(y)}}
\item{with.legend}{logical; shall a legend be plotted?}
\item{legend.bg}{background color for the legend}
\item{legend.pos}{position for the legend}
\item{legend.cex}{magnification factor for the legend}
\item{legend.pref}{character to be prepended to legend text}
\item{legend.postf}{character to be appended to legend text}
\item{legend.alpha}{nominal coverage probability}
\item{debug}{logical; if \code{TRUE} additional output to debug confidence bounds.}
\item{withSubst}{logical; if \code{TRUE} (default) pattern substitution for
      titles and lables is used; otherwise no substitution is used. }
}

\description{
  We generalize function \code{\link[stats:qqnorm]{qqplot}} from package \pkg{stats} to
  be applicable to distribution objects.  In this context,
  \code{qqplot} produces a QQ plot of two distributions, i.e.; argument \code{x}
  is the distribution to be checked for compatibility, and \code{y} is the
  model (\eqn{H_0}{H0}-)distribution.
   Graphical parameters may be given as arguments to \code{qqplot}.
   The \pkg{stats} function
  is just the method for signature \code{x=ANY,y=ANY}.
  In all title and axis label arguments, if \code{withSubst} is \code{TRUE},
  the following patterns are substituted:
\describe{
\item{\code{"\%C"}}{class of argument \code{x}}
\item{\code{"\%A"}}{deparsed argument \code{x}}
\item{\code{"\%D"}}{time/date-string when the plot was generated}
}
}
\details{
\describe{
\item{qqplot}{\code{signature(x = "ANY", y = "ANY")}: function \code{qqplot} from
package \pkg{stats}.}
\item{qqplot}{\code{signature(x = "UnivariateDistribution", y = "UnivariateDistribution")}:
produces a QQ plot for two univariate distributions.}
}
}
\value{
  A list of elements containing the information needed to compute the 
  respective QQ plot, in particular it extends the elements of the 
  return value of function \code{\link[stats:qqnorm]{qqplot}} 
  from package \pkg{stats}, i.e., a
  list with components \code{x} and \code{y} for x and y coordinates
  of the plotted points; more specifically it contains
  \item{x}{The x coordinates of the points that were/would be plotted}
  \item{y}{The corresponding quantiles of the second distribution,
           \emph{including \code{\link{NA}}s}.}
  \item{crit}{A matrix with the lower and upper confidence bounds
               (computed by \code{qqbounds}).}
  \item{err}{logical vector of length 2.}
  (elements \code{crit} and \code{err} are taken from the return
   value(s) of \code{qqbounds}).
   The return value allows to recover all information used to produce the plot
   for later use in enhanced graphics (e.g. with ggplot).   
}
\references{
  Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988)
  \emph{The New S Language}.
  Wadsworth & Brooks/Cole.
}
\seealso{
  \code{\link[stats:qqnorm]{qqplot}} from package \pkg{stats} -- the standard QQ plot
  function and
  \code{\link{qqbounds}}, used by \code{qqplot} to produce confidence
   intervals.
}
\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}
}
\examples{
qqplot(Norm(15,sqrt(30)), Chisq(df=15))
## some discrete Distributions:
P <- Pois(5)
B <- Binom(size=2000,prob=5/2000)
qqplot(B,P)
\donttest{
## takes too much time for R CMD check --as-cran
qqplot(B,P, nosym.pCI=TRUE)
}
## some Lebesgue-Decomposed distributions:
mylist <- UnivarLebDecDistribution(discretePart=Binom(3,.3), acPart=Norm(2,2),
               acWeight=11/20)
mylist2 <- mylist+0.1
qqplot(mylist,mylist2)
qqplot(mylist,mylist2,exact.pCI=FALSE,exact.sCI=FALSE)
\donttest{
## takes too much time for R CMD check --as-cran
qqplot(mylist,mylist2,nosym.pCI=TRUE)
## some ac. distribution with a gap
mylist3 <- UnivarMixingDistribution(Unif(0,0.3),Unif(0.6,1),mixCoeff=c(0.8,0.2))
gaps(mylist3)
mylist4 <- UnivarMixingDistribution(Unif(0,0.3),Unif(0.6,1),mixCoeff=c(0.6,0.4))
qqplot(mylist3,mylist4)
qqplot(mylist3,mylist4,nosym.pCI=TRUE)
}
}
\keyword{hplot}
\keyword{distribution}
