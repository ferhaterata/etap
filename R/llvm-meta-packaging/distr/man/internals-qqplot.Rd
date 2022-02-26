\name{internals_for_qqplot}
\alias{internals_for_qqplot}
\alias{.inGaps}
\alias{.isReplicated}
\alias{.NotInSupport}
\alias{.SingleDiscrete}
\alias{.makeLenAndOrder}
\alias{.q2kolmogorov}
\alias{.BinomCI.in}
\alias{.BinomCI}
\alias{.BinomCI.nosym}
\alias{.q2pw}
\alias{.confqq}
\alias{.deleteItemsMCL}
\alias{.distrExInstalled}


\title{Internal functions for qqplot of package distr}

\description{These functions are used internally by qqplot of package distr.}

\usage{
.inGaps(x,gapm)
.isReplicated(x, tol = .Machine$double.eps)
.NotInSupport(x,D)
.SingleDiscrete(x,D)
.makeLenAndOrder(x,ord)

.BinomCI.in(t,p.bi,x.i, del.i=0,D.i,n.i,alpha.i)
.BinomCI(x,p.b,D,n,alpha, silent0 = TRUE)
.BinomCI.nosym(x,p.b,D,n,alpha, silent0 = TRUE)

.q2kolmogorov(alpha,n,exact=(n<100), silent0 = TRUE)
.q2pw(x,p.b,D,n,alpha,exact=(n<100),nosym=FALSE, silent0 = TRUE)

.confqq(x,D, datax=FALSE, withConf.pw  = TRUE,  withConf.sim = TRUE, alpha,
                    col.pCI, lty.pCI, lwd.pCI, pch.pCI, cex.pCI,
                    col.sCI, lty.sCI, lwd.sCI, pch.sCI, cex.sCI,
                    n,exact.sCI=(n<100),exact.pCI=(n<100),
                    nosym.pCI = FALSE, with.legend = TRUE,
                    legend.bg = "white", legend.pos = "topleft",
                    legend.cex = 0.8, legend.pref = "", legend.postf = "",
                    legend.alpha = alpha, qqb0 = NULL, transf0=NULL, debug = FALSE)

.deleteItemsMCL(mcl)
.distrExInstalled
}


\arguments{
\item{x}{a (numeric) vector}
\item{gapm}{matrix; the gap matrix as in slot \code{gaps} of
  an \code{"AbscontDistribution"} or \code{"UnivarLebDecDistribution"}
  object.
  }
\item{tol}{numeric; tolerance for separating points.}
\item{D}{object of class \code{"UnivariateDistribution"}}
\item{datax}{logical; (to be used in \pkg{distrMod}) shall data be plotted on x-axis?}
\item{ord}{integer; the result of a call to \code{order}}
\item{alpha}{numeric in [0,1]; confidence level}
\item{n}{integer; sample size}
\item{exact}{logical; shall finite sample version be used?}
\item{t}{current  (half of the) width of the confidence interval.}
\item{p.bi}{(local) (binomial) c.d.f. value at \code{x.i}.}
\item{x.i}{a (numeric) vector}
\item{del.i}{numeric; a (local) asymmetry parameter to pass on to
\code{optim} and \code{uniroot} --- the endpoints of the searched interval
are \code{x.i+t/sqrt(n)+del.i/sqrt(n)} and \code{x.i-t/sqrt(n)+del.i/sqrt(n)}.}
\item{D.i}{object of class \code{"UnivariateDistribution"}}
\item{n.i}{integer; (local) sample size}
\item{alpha.i}{numeric in [0,1]; (local) confidence level}
\item{p.b}{(binomial) c.d.f. value at \code{x}.}
\item{nosym}{logical; shall we compute shortest (asymmetric) confidence intervals;}
\item{withConf.pw}{logical; shall pointwise confidence lines be plotted?}
\item{withConf.sim}{logical; shall simultaneous confidence lines be plotted?}
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
\item{with.legend}{logical; shall a legend be plotted?}
\item{legend.bg}{background color for the legend}
\item{legend.pos}{position for the legend}
\item{legend.cex}{magnification factor for the legend}
\item{legend.pref}{character to be prepended to legend text}
\item{legend.postf}{character to be appended to legend text}
\item{legend.alpha}{nominal coverage probability}
\item{mcl}{arguments in call as a list}
\item{qqb0}{precomputed return value of \code{qqbounds}}
\item{transf0}{optional transformation of x-values (by default \code{NULL} and then ignored)}
\item{debug}{logical; if \code{TRUE} additional output to debug confidence bounds. }
\item{silent0}{logical; it is used as argument \code{silent} in \code{try}-catches
          within this function. }
}

\details{
\code{.inGaps} produces a logical vector of same length as \code{x} with
entries \code{TRUE} if the corresponding component of \code{x} lies within a
gap as given by gap matrix \code{gapm} and \code{FALSE} otherwise.

\code{.isReplicated} produces a logical vector of same length as \code{x} with
entries \code{TRUE} if the corresponding component of \code{x} appears at least
twice within \code{x} and \code{FALSE} otherwise.

\code{.NotInSupport} produces a logical vector of same length as \code{x} with
entries \code{TRUE} if the corresponding component of \code{x} does not
lie within the support of \code{D} and \code{FALSE} otherwise.

\code{.SingleDiscrete} produces a numerical vector of same length as \code{x} with
values \code{0}  if the corresponding component of \code{x} is discrete mass point
of \code{D}, \code{1}  if the corresponding component of \code{x} lies within
the continuous support of \code{D}, \code{2} and \code{3}
if the corresponding component of \code{x}
is a left resp. right end point of a gap of \code{D}, and \code{4} if
the corresponding component of \code{x} does not lie within the support of \code{D}
at all.

\code{.makeLenAndOrder} by standard recycling roules respectively by truncation
at the end, forces \code{x} to length \code{length{ord}} and then orders the
result according to \code{ord}.

\code{.q2kolmogorov}, in the finite sample version (\code{exact==TRUE}),
returns the corresponding \code{alpha}-quantile
of the exact Kolmogorov distribution multiplied by \eqn{\sqrt{n}}{sqrt(n)}, and
in the asymptotic version (\code{exact==FALSE}),
the the corresponding (upper) \code{alpha}-quantile
of the asymptotic Kolmogorov distribution. Doing so we make use of
C-function \code{"pkolmogorov2x"} (from \code{\link[stats]{ks.test}} in package \pkg{stats})
and R-function \code{pkstwo} (again from \code{\link[stats]{ks.test}} in package \pkg{stats}).

\code{.BinomCI.in} in a non-vectorized form, computes,
for given \code{t}, \code{x}, \eqn{\alpha}{\code{alpha}}, \eqn{\delta}{\code{del}},
and for \eqn{X\sim D}{X distributed as D}, the discrepancy
\deqn{P(\sqrt{n} |X-x-\delta| \leq t) - \alpha}{P(sqrt(n) abs(X-x-del) <= t) - alpha}


\code{.BinomCI}, in a vectorized form, computes,
for given \code{x}, \eqn{\alpha}{\code{alpha}}, \eqn{\delta}{\code{del}},
values \code{t} such that,
pointwise in \code{x} and for \eqn{X\sim D}{X distributed as D},
\deqn{P(\sqrt{n} |X-x-\delta| \leq t) = \alpha}{P(sqrt(n) abs(X-x-del) <= t) = alpha}

\code{.BinomCI.nosym}, in an outer loop, by varying \code{del} in the former
formula, tries to minimize the length of
a corresponding level alpha confidence interval containing the estimate.


\code{.q2pw} computes  pointwise finite sample or asymptotic confidence widths
by means of binomial probabilities / quantiles, in the former case either
symmetric (default) or shortest asymmetric; in the asymptotic case, for
distributions without a Lebesgue density, for the corresponding
density value at the quantile appearing in the expression for the
asymptotic variance, we make an approximation of \code{(D-E(D))/sd(D)} by
the standard normal, using the density of the latter one; this latter approximation
is only  available if \code{.distrExInstalled == TRUE}; otherwise the corresponding
columns will be filled with \code{NA}.

\code{.confqq} calls \code{qqbound} to compute the confidence intervals
and plots them; returns the return value of qqbound.

\code{.deleteItemsMCL} deletes arguments from a call list which
functions like \code{plot}, \code{lines}, \code{points} cannot digest;
this is necessary in the manipulation of an original call
to a specific \code{qqplot} method to pass on the \code{\dots} argument
correctly to calls the mentioned functions.

\code{.distrExInstalled} is a constant logical --- \code{TRUE} if package
\pkg{distrEx} is installed.

}


\value{
\item{.inGaps}{a logical vector of same length as \code{x}.}
\item{.isReplicated}{a logical vector of same length as \code{x}.}
\item{.NotInSupport}{a logical vector of same length as \code{x}.}
\item{.SingleDiscrete}{a vector of same length as \code{x} with entries in the
set \eqn{\{0,1,2,3,4\}}{{0,1,2,3,4}}.}
\item{.makeLenAndOrder}{a numeric of length \code{length(ord}.}
\item{.BinomCI.in}{a numeric of length 1: the discrepancy
\deqn{P(\sqrt{n} |X-x-\delta| \leq t) - \alpha}{P(sqrt(n) abs(X-x-del) <= t) - alpha}
}
\item{.BinomCI}{a numeric matrix with two columns \code{"left"} and \code{"right"}
with the corresponding pointwise confidence widths.}
\item{.BinomCI.nosym}{a numeric matrix with two columns \code{"left"} and \code{"right"}
with the corresponding pointwise confidence widths.}

\item{.q2kolmogorov}{a numeric of length 1; a corresponding quantile of the
(exact/asymptotic) Kolmogorov distribution}
\item{.q2pw}{a numeric matrix with two columns \code{"left"} and \code{"right"}
with the corresponding pointwise confidence widths.}
\item{.confqq}{\code{invisible(NULL)}}
\item{.deleteItemsMCL}{the manipulated list of arguments}
}

\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},
}

\seealso{\code{\link[stats]{ks.test}}, \code{\link[distr]{qqplot}}
, \code{\link[distrMod]{qqplot}}, \code{\link[RobAStBase]{qqplot}}
}
\keyword{internal}
\concept{utilities}
