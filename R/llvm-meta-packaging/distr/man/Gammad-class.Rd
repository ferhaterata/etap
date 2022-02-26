\name{Gammad-class} 
\docType{class}
\alias{Gammad-class}
\alias{Gammad}
\alias{initialize,Gammad-method}

\title{Class "Gammad"}
\description{   The Gammad distribution with parameters \code{shape} \eqn{=\alpha}{= a},
  by default \code{= 1}, and \code{scale} \eqn{=\sigma}{= s}, by default \code{= 1}, has 
  density
  \deqn{
    d(x)= \frac{1}{{\sigma}^{\alpha}\Gamma(\alpha)} {x}^{\alpha-1} e^{-x/\sigma}%
  }{d(x)= 1/(s^a Gamma(a)) x^(a-1) e^-(x/s)}
  for \eqn{x > 0}, \eqn{\alpha > 0}{a > 0} and \eqn{\sigma > 0}{s > 0}.
  The mean and variance are
  \eqn{E(X) = \alpha\sigma}{E(X) = a*s} and
  \eqn{Var(X) = \alpha\sigma^2}{Var(X) = a*s^2}. C.f. \code{\link[stats:GammaDist]{rgamma}} 
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{Gammad(scale, shape)}.
This object is a gamma distribution.
}
\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Reals"}: The space of the image of this distribution has got dimension 1
    and the name "Real Space". }
    \item{\code{param}}{Object of class \code{"GammaParameter"}: the parameter of this distribution (scale and shape), declared at its instantiation }
    \item{\code{r}}{Object of class \code{"function"}: generates random numbers (calls function rgamma)}
    \item{\code{d}}{Object of class \code{"function"}: density function (calls function dgamma)}
    \item{\code{p}}{Object of class \code{"function"}: cumulative function (calls function pgamma)}
    \item{\code{q}}{Object of class \code{"function"}: inverse of the cumulative function (calls function qgamma)}
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
Class \code{"ExpOrGammaOrChisq"}, directly.\cr
Class \code{"AbscontDistribution"}, by class \code{"ExpOrGammaOrChisq"}.\cr
Class \code{"UnivariateDistribution"}, by class \code{"AbscontDistribution"}.\cr
Class \code{"Distribution"}, by class \code{"UnivariateDistribution"}.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "Gammad")}: initialize method }
    \item{scale}{\code{signature(object = "Gammad")}: returns the slot \code{scale} of the parameter of the distribution }
    \item{scale<-}{\code{signature(object = "Gammad")}: modifies the slot \code{scale} of the parameter of the distribution }
    \item{shape}{\code{signature(object = "Gammad")}: returns the slot \code{shape} of the parameter of the distribution }
    \item{shape<-}{\code{signature(object = "Gammad")}: modifies the slot \code{shape} of the parameter of the distribution }
    \item{+}{\code{signature(e1 = "Gammad", e2 = "Gammad")}: 
    For the Gamma distribution we use its closedness under convolutions.}
    \item{*}{\code{signature(e1 = "Gammad", e2 = "numeric")}: 
    For the Gamma distribution we use its closedness under positive scaling transformations.}
  }
}

\author{Thomas Stabla \email{statho3@web.de},\cr 
        Florian Camphausen \email{fcampi@gmx.de},\cr
        Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
        Matthias Kohl \email{Matthias.Kohl@stamats.de}}


\seealso{
\code{\link{GammaParameter-class}}
\code{\link{AbscontDistribution-class}}
\code{\link{Reals-class}}
\code{\link[stats:GammaDist]{rgamma}}





}
\examples{
G <- Gammad(scale=1,shape=1) # G is a gamma distribution with scale=1 and shape=1.
r(G)(1) # one random number generated from this distribution, e.g. 0.1304441
d(G)(1) # Density of this distribution is 0.3678794 for x=1.
p(G)(1) # Probability that x<1 is 0.6321206.
q(G)(.1) # Probability that x<0.1053605 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
scale(G) # scale of this distribution is 1.
scale(G) <- 2 # scale of this distribution is now 2.
}
\keyword{distribution}
\concept{Gamma distribution}
\concept{absolutely continuous distribution}
\concept{S4 distribution class}
\concept{generating function}
