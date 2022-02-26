\name{Dirac-class}
\docType{class}
\alias{Dirac-class}
\alias{Dirac}
\alias{initialize,Dirac-method}
\alias{log,Dirac-method}
\alias{Math,Dirac-method}

\title{Class "Dirac"  }
\description{ The Dirac distribution with location \eqn{l}, by default \eqn{=0}, has density
\eqn{d(x) = 1} for \eqn{x = l}, \eqn{0} else.
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{Dirac(location)}.
This object is a \code{Dirac} distribution. 
}
\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Naturals"}: The space of the image of this
     distribution has got dimension 1 and the name "Real Space". }
    \item{\code{param}}{Object of class \code{"DiracParameter"}: the parameter of this distribution (location), declared at its instantiation }
    \item{\code{r}}{Object of class \code{"function"}: generates random numbers }
    \item{\code{d}}{Object of class \code{"function"}: density function }
    \item{\code{p}}{Object of class \code{"function"}: cumulative function }
    \item{\code{q}}{Object of class \code{"function"}: inverse of the cumulative function }
    \item{\code{support}}{Object of class \code{"numeric"}: a (sorted) vector containing the support of the discrete density function}
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
Class \code{"DiscreteDistribution"}, directly.\cr
Class \code{"UnivariateDistribution"}, by class \code{"DiscreteDistribution"}.\cr
Class \code{"Distribution"}, by class \code{"DiscreteDistribution"}.
}
\section{Methods}{
  \describe{
    \item{-}{\code{signature(e1 = "Dirac", e2 = "Dirac")}}
    \item{+}{\code{signature(e1 = "Dirac", e2 = "Dirac")}} 
    \item{*}{\code{signature(e1 = "Dirac", e2 = "Dirac")}}
    \item{/}{\code{signature(e1 = "Dirac", e2 = "Dirac")}: 
    For the Dirac distribution these operations are trivial.}
    \item{initialize}{\code{signature(.Object = "Dirac")}: initialize method }
    \item{location}{\code{signature(object = "Dirac")}: returns the slot \code{location} of the parameter of the distribution }
    \item{location<-}{\code{signature(object = "Dirac")}: modifies the slot \code{location} of the parameter of the distribution }
    \item{log}{\code{signature(object = "Dirac")}: returns an object of class \code{"Dirac"} distribution with log-transformed
      \code{location} parameter. }
    \item{Math}{\code{signature(object = "Dirac")}: given a \code{"Math"} group generic \code{fun} an object of class 
      \code{"Dirac"} distribution with \code{fun}-transformed \code{location} parameter is returned. }
  }
 further arithmetic methods see \link{operators-methods}
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}}

\seealso{
\code{\link{DiracParameter-class}}
\code{\link{DiscreteDistribution-class}}
\code{\link{Naturals-class}}
}
\examples{
D <- Dirac(location = 0) # D is a Dirac distribution with location=0.
r(D)(1)
# r(D)(1) generates a pseudo-random-number according to a Dirac
# distribution with location = 0,
# which of course will take 0 as value almost surely.
d(D)(0) # Density of this distribution is 1 for x = 0.
p(D)(1) # Probability that x < 1 is 1.
q(D)(.1) # q(D)(x) is always 0 (= location).
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
location(D) # location of this distribution is 0.
location(D) <- 2 # location of this distribution is now 2.
}
\keyword{distribution}
\concept{location family}
\concept{lattice distribution}
\concept{discrete distribution}
\concept{Dirac distribution}
\concept{S4 parameter class}
