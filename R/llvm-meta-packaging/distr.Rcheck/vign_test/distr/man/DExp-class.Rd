\name{DExp-class}
\docType{class}
\alias{DExp-class}
\alias{DExp}
\alias{Laplace}
\alias{DoubleExponential}
\alias{initialize,DExp-method}
\title{Class "DExp"}
\description{
  The double exponential or Laplace distribution with rate \eqn{\lambda} has density
  \deqn{
    f(x) = \frac{1}{2}\lambda {e}^{- \lambda |x|}}{
    f(x) = 1/2 lambda e^(- lambda |x|)}

  C.f. \code{\link{Exp-class}}, \code{\link[stats:Exponential]{rexp}}
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{DExp(rate)}.
This object is a double exponential (or Laplace) distribution. 
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
  Class \code{"AbscontDistribution"}, directly.\cr
  Class \code{"UnivariateDistribution"}, by class \code{"AbscontDistribution"}.
  Class \code{"Distribution"}, by class \code{"AbscontDistribution"}.
}

\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "DExp")}:
      initialize method}
    \item{rate}{\code{signature(object = "DExp")}:
      returns the slot rate of the parameter of the distribution}
    \item{rate<-}{\code{signature(object = "DExp")}:
      modifies the slot rate of the parameter of the distribution}
    \item{*}{\code{signature(e1 = "DExp", e2 = "numeric")}: 
    For the Laplace distribution we use its closedness under scaling transformations.}
  }
}

\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}
}
\seealso{
\code{\link{Exp-class}}
\code{\link{ExpParameter-class}}
\code{\link{AbscontDistribution-class}}
\code{\link{Reals-class}}
\code{\link[stats:Exponential]{rexp}}
}
\examples{
D <- DExp(rate = 1) # D is a Laplace distribution with rate = 1.
r(D)(1) # one random number generated from this distribution, e.g. 0.4190765
d(D)(1) # Density of this distribution is 0.1839397 for x = 1.
p(D)(1) # Probability that x < 1 is 0.8160603.
q(D)(.1) # Probability that x < -1.609438 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
rate(D) # rate of this distribution is 1.
rate(D) <- 2 # rate of this distribution is now 2.
3*D ###  still a DExp -distribution
}
\keyword{distribution}
\concept{absolutely continuous distribution}
\concept{Double exponential distribution}
\concept{Laplace distribution}
\concept{S4 distribution class}
\concept{generating function}
