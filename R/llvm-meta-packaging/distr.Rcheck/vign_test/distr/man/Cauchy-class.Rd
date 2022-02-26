\name{Cauchy-class}
\docType{class}
\alias{Cauchy-class}
\alias{Cauchy}
\alias{initialize,Cauchy-method}

\title{Class "Cauchy"}
\description{  The Cauchy distribution with location \eqn{l}, by default \eqn{=0}, and scale \eqn{s} , by default \eqn{=1},has
  density
  \deqn{f(x) = \frac{1}{\pi s}
    \left( 1 + \left(\frac{x - l}{s}\right)^2 \right)^{-1}%
  }{f(x) = 1 / (pi s (1 + ((x-l)/s)^2))}
  for all \eqn{x}.
C.f. \code{\link[stats:Cauchy]{rcauchy}}
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{Cauchy(location, scale)}.
This object is a Cauchy distribution.
}
\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Reals"}: The domain of this distribution has got dimension 1
    and the name "Real Space". }
    \item{\code{param}}{Object of class \code{"CauchyParameter"}: the parameter of this distribution (location and scale),
     declared at its instantiation }
    \item{\code{r}}{Object of class \code{"function"}: generates random numbers (calls function \code{rcauchy})}
    \item{\code{d}}{Object of class \code{"function"}: density function (calls function \code{dcauchy})}
    \item{\code{p}}{Object of class \code{"function"}: cumulative function (calls function \code{pcauchy})}
    \item{\code{q}}{Object of class \code{"function"}: inverse of the cumulative function (calls function \code{qcauchy})}
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
\section{Is-Relations}{
By means of \code{setIs}, R ``knows'' that a distribution object \code{obj} of class \code{"Cauchy"} with location 0 and scale 1 also is
a T distribution with parameters \code{df = 1, ncp = 0}. 
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "Cauchy")}: initialize method }
    \item{location}{\code{signature(object = "Cauchy")}: returns the slot \code{location} of the parameter of the distribution }
    \item{location<-}{\code{signature(object = "Cauchy")}: modifies the slot \code{location} of the parameter of the distribution }
    \item{scale}{\code{signature(object = "Cauchy")}: returns the slot \code{scale} of the parameter of the distribution }
    \item{scale<-}{\code{signature(object = "Cauchy")}: modifies the slot \code{scale} of the parameter of the distribution }
    \item{+}{\code{signature(e1 = "Cauchy", e2 = "Cauchy")}: For the Cauchy distribution the exact convolution formula is
      implemented thereby improving the general numerical approximation.}
    \item{*}{\code{signature(e1 = "Cauchy", e2 = "numeric")}}
    \item{+}{\code{signature(e1 = "Cauchy", e2 = "numeric")}: 
    For the Cauchy location scale family we use its closedness under affine linear transformations.}
  }
further arithmetic methods see \link{operators-methods}
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}}


\seealso{
\code{\link{CauchyParameter-class}}
\code{\link{AbscontDistribution-class}}
\code{\link{Reals-class}}
\code{\link[stats:Cauchy]{rcauchy}}





}
\examples{
C <- Cauchy(location = 1, scale = 1) # C is a Cauchy distribution with location=1 and scale=1.
r(C)(1) # one random number generated from this distribution, e.g. 4.104603
d(C)(1) # Density of this distribution is 0.3183099 for x=1.
p(C)(1) # Probability that x<1 is 0.5.
q(C)(.1) # Probability that x<-2.077684 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
location(C) # location of this distribution is 1.
location(C) <- 2 # location of this distribution is now 2.
is(C,"Td") # no
C0 <- Cauchy() # standard, i.e. location = 0, scale = 1
is(C0,"Td") # yes
as(C0,"Td") 
}
\keyword{distribution}
\concept{absolutely continuous distribution}
\concept{Cauchy distribution}
\concept{T(1) distribution}
\concept{S4 distribution class}
\concept{generating function}
