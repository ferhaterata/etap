\name{Lnorm-class} 
\docType{class}
\alias{Lnorm-class}
\alias{Lnorm}
\alias{initialize,Lnorm-method}

\title{Class "Lnorm"}
\description{ 
  The log normal distribution has density
  \deqn{
    d(x) = \frac{1}{\sqrt{2\pi}\sigma x} e^{-(\log(x) - \mu)^2/2 \sigma^2}%
  }{d(x) = 1/(sqrt(2 pi) sigma x) e^-((log x - mu)^2 / (2 sigma^2))}
  where \eqn{\mu}, by default \eqn{=0}, and \eqn{\sigma}, by default \eqn{=1}, are the mean and standard
  deviation of the logarithm.
C.f. \code{\link[stats:Lognormal]{rlnorm}} }
\section{Objects from the Class}{
Objects can be created by calls of the form \code{Lnorm(meanlog, sdlog)}.
This object is a log normal distribution.
}
\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Reals"}: The space of the image of this distribution has got dimension 1
    and the name "Real Space". }
    \item{\code{param}}{Object of class \code{"LnormParameter"}: the parameter of this distribution (meanlog and sdlog),
     declared at its instantiation }
    \item{\code{r}}{Object of class \code{"function"}: generates random numbers (calls function \code{rlnorm})}
    \item{\code{d}}{Object of class \code{"function"}: density function (calls function \code{dlnorm})}
    \item{\code{p}}{Object of class \code{"function"}: cumulative function (calls function \code{plnorm})}
    \item{\code{q}}{Object of class \code{"function"}: inverse of the cumulative function (calls function \code{qlnorm})}
    \item{\code{.withArith}}{logical: used internally to issue warnings as to 
            interpretation of arithmetics}
    \item{\code{.withSim}}{logical: used internally to issue warnings as to 
          accuracy}
    \item{\code{.logExact}}{logical: used internally to flag the case where 
    there are explicit formulae for the log version of density, cdf, and 
    quantile function}
    \item{\code{.lowerExact}}{logical: used internally to flag the case where 
    there are explicit formulae for the lower tail version of cdf and quantile 
    function}
    \item{\code{Symmetry}}{object of class \code{"DistributionSymmetry"};
     used internally to avoid unnecessary calculations.}
  }
}
\section{Extends}{
Class \code{"AbscontDistribution"}, directly.\cr
Class \code{"UnivariateDistribution"}, by class \code{"AbscontDistribution"}.\cr
Class \code{"Distribution"}, by class \code{"AbscontDistribution"}.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "Lnorm")}: initialize method }
    \item{meanlog}{\code{signature(object = "Lnorm")}: returns the slot \code{meanlog} of the parameter of the distribution }
    \item{meanlog<-}{\code{signature(object = "Lnorm")}: modifies the slot \code{meanlog} of the parameter of the distribution }
    \item{sdlog}{\code{signature(object = "Lnorm")}: returns the slot \code{sdlog} of the parameter of the distribution }
    \item{sdlog<-}{\code{signature(object = "Lnorm")}: modifies the slot \code{sdlog} of the parameter of the distribution }
    \item{*}{\code{signature(e1 = "Lnorm", e2 = "numeric")}:
    For the Lognormal distribution we use its closedness under positive scaling transformations.}
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
  }

\note{  The mean is \eqn{E(X) = exp(\mu + 1/2 \sigma^2)}, and the variance
  \eqn{Var(X) = exp(2\mu + \sigma^2)(exp(\sigma^2) - 1)}{%
    Var(X) = exp(2*mu + sigma^2)*(exp(sigma^2) - 1)} and
  hence the coefficient of variation is
  \eqn{\sqrt{exp(\sigma^2) - 1}}{sqrt(exp(sigma^2) - 1)} which is
    approximately \eqn{\sigma} when that is small (e.g., \eqn{\sigma < 1/2}).
%% Mode = exp(max(0, mu - sigma^2)); Median = exp(mu)
}

\seealso{
\code{\link{LnormParameter-class}}
\code{\link{AbscontDistribution-class}}
\code{\link{Reals-class}}
\code{\link[stats:Lognormal]{rlnorm}}





}
\examples{
L <- Lnorm(meanlog=1,sdlog=1) # L is a lnorm distribution with mean=1 and sd=1.
r(L)(1) # one random number generated from this distribution, e.g. 3.608011
d(L)(1) # Density of this distribution is 0.2419707 for x=1.
p(L)(1) # Probability that x<1 is 0.1586553.
q(L)(.1) # Probability that x<0.754612 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
meanlog(L) # meanlog of this distribution is 1.
meanlog(L) <- 2 # meanlog of this distribution is now 2.
}
\keyword{distribution}
\concept{absolutely continuous distribution}
\concept{Log-Normal distribution}
\concept{S4 distribution class}
