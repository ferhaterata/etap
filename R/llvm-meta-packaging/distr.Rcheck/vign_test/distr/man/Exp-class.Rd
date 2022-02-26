\name{Exp-class}
\docType{class}
\alias{Exp-class}
\alias{Exp}
\alias{initialize,Exp-method}
\title{Class "Exp"}
\description{
  The exponential distribution with rate \eqn{\lambda} has density
  \deqn{
    f(x) = \lambda {e}^{- \lambda x}}{
    f(x) = lambda e^(- lambda x)}
  for \eqn{x \ge 0}.

  C.f. \code{\link[stats:Exponential]{rexp}}
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{Exp(rate)}.
This object is an exponential distribution. 
}
\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Reals"}:
      The space of the image of this distribution has got dimension 1
      and the name "Real Space".}
    \item{\code{param}}{Object of class \code{"ExpParameter"}:
      the parameter of this distribution (rate), declared at its instantiation }
    \item{\code{r}}{Object of class \code{"function"}:
      generates random numbers (calls function rexp)}
    \item{\code{d}}{Object of class \code{"function"}:
      density function (calls function dexp)}
    \item{\code{p}}{Object of class \code{"function"}:
      cumulative function (calls function pexp)}
    \item{\code{q}}{Object of class \code{"function"}:
      inverse of the cumulative function (calls function qexp)}
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
  Class \code{"UnivariateDistribution"}, by class \code{"AbscontDistribution"}.
  Class \code{"Distribution"}, by class \code{"AbscontDistribution"}.
}
\section{Is-Relations}{
By means of \code{setIs}, R ``knows'' that a distribution object \code{obj} of class \code{"Exp"} also is
a Gamma distribution with parameters \code{shape = 1, scale = 1/rate(obj)} and a Weibull  distribution with 
parameters \code{shape = 1, scale = 1/rate(obj)}
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "Exp")}:
      initialize method}
    \item{rate}{\code{signature(object = "Exp")}:
      returns the slot rate of the parameter of the distribution}
    \item{rate<-}{\code{signature(object = "Exp")}:
      modifies the slot rate of the parameter of the distribution}
    \item{*}{\code{signature(e1 = "Exp", e2 = "numeric")}: 
    For the exponential distribution we use its closedness under positive scaling transformations.}
  }
}

\author{
Thomas Stabla \email{statho3@web.de},\cr 
Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
}
\seealso{
\code{\link{ExpParameter-class}}
\code{\link{AbscontDistribution-class}}
\code{\link{Reals-class}}
\code{\link[stats:Exponential]{rexp}}
}
\examples{
E <- Exp(rate = 1) # E is a exp distribution with rate = 1.
r(E)(1) # one random number generated from this distribution, e.g. 0.4190765
d(E)(1) # Density of this distribution is 0.3678794 for x = 1.
p(E)(1) # Probability that x < 1 is 0.6321206.
q(E)(.1) # Probability that x < 0.1053605 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
rate(E) # rate of this distribution is 1.
rate(E) <- 2 # rate of this distribution is now 2.
is(E, "Gammad") # yes
as(E,"Gammad")
is(E, "Weibull") 
E+E+E ###  a Gammad -distribution
2*E+Gammad(scale=1)
}
\keyword{distribution}
\concept{Exponential distribution}
\concept{memoryless distribution}
\concept{absolutely continuous distribution}
\concept{S4 distribution class}
\concept{generating function}
