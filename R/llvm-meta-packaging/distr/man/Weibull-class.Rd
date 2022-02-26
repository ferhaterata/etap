\name{Weibull-class} 
\docType{class}
\alias{Weibull-class}
\alias{Weibull}
\alias{initialize,Weibull-method}

\title{Class "Weibull"}
\description{  The Weibull distribution with \code{shape} parameter \eqn{a}, by default \eqn{=1}, and
  \code{scale} parameter \eqn{\sigma}{b} has density given by, by default \eqn{=1},
  \deqn{d(x) = (a/\sigma) {(x/\sigma)}^{a-1} \exp (-{(x/\sigma)}^{a})}{%
        d(x) = (a/b) (x/b)^(a-1) exp(- (x/b)^a)}
  for \eqn{x > 0}.

C.f. \code{\link[stats:Weibull]{rweibull}}
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{Weibull(shape, scale)}.
This object is a Weibull distribution.
}
\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Reals"}: The space of the image of this distribution has got dimension 1
    and the name "Real Space". }
    \item{\code{param}}{Object of class \code{"WeibullParameter"}: the parameter of this distribution (shape and scale),
     declared at its instantiation }
    \item{\code{r}}{Object of class \code{"function"}: generates random numbers (calls function \code{rweibull})}
    \item{\code{d}}{Object of class \code{"function"}: density function (calls function \code{dweibull})}
    \item{\code{p}}{Object of class \code{"function"}: cumulative function (calls function \code{pweibull})}
    \item{\code{q}}{Object of class \code{"function"}: inverse of the cumulative function (calls function \code{qweibull})}
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
    \item{initialize}{\code{signature(.Object = "Weibull")}: initialize method }
    \item{scale}{\code{signature(object = "Weibull")}: returns the slot \code{scale} of the parameter of the distribution }
    \item{scale<-}{\code{signature(object = "Weibull")}: modifies the slot \code{scale} of the parameter of the distribution }
    \item{shape}{\code{signature(object = "Weibull")}: returns the slot \code{shape} of the parameter of the distribution }
    \item{shape<-}{\code{signature(object = "Weibull")}: modifies the slot \code{shape} of the parameter of the distribution }
    \item{*}{\code{signature(e1 = "Weibull", e2 = "numeric")}:
    For the Weibull distribution we use its closedness under positive scaling transformations.}
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}}

\note{ The density is \eqn{d(x)=0} for \eqn{x < 0}.\cr
The cumulative is
  \eqn{p(x) = 1 - \exp(-{(x/\sigma)}^a)}{p(x) = 1 - exp(- (x/b)^a)},\cr
  the mean is \eqn{E(X) = \sigma \Gamma(1 + 1/a)}{E(X) = b Gamma(1 + 1/a)},\cr
  and the \eqn{Var(X) = \sigma^2(\Gamma(1 + 2/a)-(\Gamma(1 + 1/a))^2)}{%
           Var(X) = b^2 * (gamma(1 + 2/a) - (gamma(1 + 1/a))^2)}.

}

\seealso{
\code{\link{WeibullParameter-class}}
\code{\link{AbscontDistribution-class}}
\code{\link{Reals-class}}
\code{\link[stats:Weibull]{rweibull}}





}
\examples{
W <- Weibull(shape=1,scale=1) # W is a Weibull distribution with shape=1 and scale=1.
r(W)(1) # one random number generated from this distribution, e.g. 0.5204105
d(W)(1) # Density of this distribution is 0.3678794 for x=1.
p(W)(1) # Probability that x<1 is 0.6321206.
q(W)(.1) # Probability that x<0.1053605 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
shape(W) # shape of this distribution is 1.
shape(W) <- 2 # shape of this distribution is now 2.
}
\keyword{distribution}
\concept{absolutely continuous distribution}
\concept{Weibull distribution}
\concept{S4 distribution class}
\concept{generating function}
