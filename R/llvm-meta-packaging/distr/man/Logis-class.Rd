\name{Logis-class}
\docType{class}
\alias{Logis-class}
\alias{Logis}
\alias{initialize,Logis-method}

\title{Class "Logis"}
\description{ The Logistic distribution with \code{location} \eqn{= \mu}{= m}, 
  by default \code{= 0}, and \code{scale} \eqn{= \sigma}{= s}, by default \code{= 1}, 
  has distribution function
  \deqn{
    p(x) = \frac{1}{1 + e^{-(x-\mu)/\sigma}}%
  }{p(x) = 1 / (1 + exp(-(x-m)/s))}  and density
  \deqn{
    d(x)= \frac{1}{\sigma}\frac{e^{(x-\mu)/\sigma}}{(1 + e^{(x-\mu)/\sigma})^2}%
  }{d(x) = 1/s exp((x-m)/s) (1 + exp((x-m)/s))^-2.}

  It is a long-tailed distribution with mean \eqn{\mu}{m} and variance
  \eqn{\pi^2/3 \sigma^2}{pi^2 /3 s^2}. C.f. \code{\link[stats:Logistic]{rlogis}} 
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{Logis(location, scale)}.
This object is a logistic distribution.
}
\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Reals"}: The space of the image of this distribution has got dimension 1
    and the name "Real Space". }
    \item{\code{param}}{Object of class \code{"LogisParameter"}: the parameter of this distribution (location and scale),
     declared at its instantiation }
    \item{\code{r}}{Object of class \code{"function"}: generates random numbers (calls function rlogis)}
    \item{\code{d}}{Object of class \code{"function"}: density function (calls function dlogis)}
    \item{\code{p}}{Object of class \code{"function"}: cumulative function (calls function plogis)}
    \item{\code{q}}{Object of class \code{"function"}: inverse of the cumulative function (calls function qlogis)}
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
    \item{initialize}{\code{signature(.Object = "Logis")}: initialize method }
    \item{location}{\code{signature(object = "Logis")}: returns the slot \code{location} of the parameter of the distribution }
    \item{location<-}{\code{signature(object = "Logis")}: modifies the slot \code{location} of the parameter of the distribution }
    \item{scale}{\code{signature(object = "Logis")}: returns the slot \code{scale} of the parameter of the distribution }
    \item{scale<-}{\code{signature(object = "Logis")}: modifies the slot \code{scale} of the parameter of the distribution }
    \item{*}{\code{signature(e1 = "Logis", e2 = "numeric")}}
    \item{+}{\code{signature(e1 = "Logis", e2 = "numeric")}: 
    For the logistic location scale family we use its closedness under affine linear transformations.}
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
  }



\seealso{
\code{\link{LogisParameter-class}}
\code{\link{AbscontDistribution-class}}
\code{\link{Reals-class}}
\code{\link[stats:Logistic]{rlogis}}





}
\examples{
L <- Logis(location = 1,scale = 1)
# L is a logistic distribution with  location = 1 and scale = 1.
r(L)(1) # one random number generated from this distribution, e.g. 5.87557
d(L)(1) # Density of this distribution is 0.25 for x = 1.
p(L)(1) # Probability that x < 1 is 0.5.
q(L)(.1) # Probability that x < -1.197225 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
location(L) # location of this distribution is 1.
location(L) <- 2 # location of this distribution is now 2.
}
\keyword{distribution}
\concept{absolutely continuous distribution}
\concept{Logistic distribution}
\concept{S4 distribution class}
\concept{location scale family}
