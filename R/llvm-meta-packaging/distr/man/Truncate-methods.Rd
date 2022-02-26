\name{Truncate-methods}
\docType{methods}
\alias{Truncate-methods}
\alias{Truncate}
\alias{Truncate,AbscontDistribution-method}
\alias{Truncate,DiscreteDistribution-method}
\alias{Truncate,LatticeDistribution-method}
\alias{Truncate,UnivarLebDecDistribution-method}
\title{ Methods for function Truncate in Package `distr' }
\description{Truncate-methods}
\usage{
Truncate(object, ...)
\S4method{Truncate}{AbscontDistribution}(object, lower = -Inf, upper = Inf)
\S4method{Truncate}{DiscreteDistribution}(object, lower= -Inf, upper = Inf)
\S4method{Truncate}{LatticeDistribution}(object, lower= -Inf, upper = Inf)
\S4method{Truncate}{UnivarLebDecDistribution}(object, lower = -Inf, upper = Inf, 
                    withSimplify = getdistrOption("simplifyD"))
}
\arguments{
  \item{object}{distribution object}
  \item{\dots}{not yet used; takes up \code{lower}, 
  \code{upper}, \code{withSimplify}.}
  \item{lower}{numeric; lower truncation point}
  \item{upper}{numeric; upper truncation point}
  \item{withSimplify}{logical; is result to be piped through a call to 
         \code{\link{simplifyD}}?}
}
\value{the corresponding distribution of the truncated random variable}
\section{Methods}{\describe{
\item{Truncate}{\code{signature(object = "AbscontDistribution")}: 
returns the distribution of \code{min(upper,max(X,lower))}
conditioned to \code{lower<=X<=upper}, if \code{X} is 
distributed according to \code{object};
if slot \code{.logExact} of argument \code{object} is \code{TRUE} 
and if either there is only one-sided truncation or both truncation
points lie on the same side of the median, we use this representation
to enhance the range of applicability, in particular, for slot \code{r},
we profit from Peter Dalgaard's clever log-tricks as indicated in 
\url{http://r.789695.n4.nabble.com/help-on-sampling-from-the-truncated-normal-gamma-distribution-on-the-far-end-probability-is-very-low-td868119.html#a868120}. To this
end we use the internal functions
(i.e.; non exported to namespace) \code{\link{.trunc.up}} and
\code{\link{.trunc.low}} which provide functional slots \code{r,d,p,q} for 
one-sided truncation. In case of two sided truncation, we simply use one-sided
truncation successively --- first left and then right in case we are right of
the median, and the other way round else;
the result is again of class \code{"AbscontDistribution"};
}
\item{Truncate}{\code{signature(object = "DiscreteDistribution")}: 
returns the distribution of \code{min(upper,max(X,lower))}
conditioned to \code{lower<=X<=upper}, if \code{X} is 
distributed according to \code{object};
the result is again of class \code{"DiscreteDistribution"}}
\item{Truncate}{\code{signature(object = "LatticeDistribution")}: 
if length of the corresp. \code{lattice} is infinite  and 
slot \code{.logExact} of argument \code{object} is \code{TRUE}, 
we proceed similarly as in case of \code{AbscontDistribution}, also 
using internal functions \code{\link{.trunc.up}} and \code{\link{.trunc.low}}; 
else we use the corresponding \code{"DiscreteDistribution"} method;
the result is again of class \code{"LatticeDistribution"}}
\item{Truncate}{\code{signature(object = "UnivarLebDecDistribution")}: 
returns the distribution of \code{min(upper,max(X,lower))}
conditioned to \code{lower<=X<=upper}, if \code{X} is 
distributed according to \code{object};
the result is again of class \code{"UnivarLebDecDistribution"}}
}}
\seealso{\code{\link{Huberize}}, \code{\link{Minimum}}}
\examples{
plot(Truncate(Norm(),lower=-1,upper=2))
TN <- Truncate(Norm(),lower=15,upper=15.7) ### remarkably right!
plot(TN)
r(TN)(30)
TNG <- Truncate(Geom(prob=0.05),lower=325,upper=329) ### remarkably right!
plot(TNG)
}
\keyword{distribution}
\keyword{methods}
\concept{truncation}
