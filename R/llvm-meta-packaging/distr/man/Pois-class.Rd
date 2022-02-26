\name{Pois-class}
\docType{class}
\alias{Pois-class}
\alias{Pois}
\alias{initialize,Pois-method}
\title{Class "Pois" }
\description{
  The Poisson distribution has density
%-- please leave the linebreaking for the next two ! --
  \deqn{p(x) = \frac{\lambda^x e^{-\lambda}}{x!}}{%
        p(x) = lambda^x exp(-lambda)/x!}
  for \eqn{x = 0, 1, 2, \ldots}.  The mean and variance are
  \eqn{E(X) = Var(X) = \lambda}.

  C.f. \code{\link[stats:Poisson]{rpois}}
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{Pois(lambda)}.
This object is a Poisson distribution. 
}
\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Naturals"}:
      The space of the image of this distribution has got dimension 1
      and the name "Natural Space".}
    \item{\code{param}}{Object of class \code{"PoisParameter"}:
      the parameter of this distribution (lambda), declared at its
      instantiation}
    \item{\code{r}}{Object of class \code{"function"}:
      generates random numbers (calls function rpois)}
    \item{\code{d}}{Object of class \code{"function"}:
      density function (calls function dpois)}
    \item{\code{p}}{Object of class \code{"function"}:
      cumulative function (calls function ppois)}
    \item{\code{q}}{Object of class \code{"function"}:
      inverse of the cumulative function (calls function qpois).
      The quantile is defined as the smallest value \eqn{x} such that
      \eqn{F(x) \ge p}, where \eqn{F} is the distribution function.}
    \item{\code{support}}{Object of class \code{"numeric"}: a (sorted)
      vector containing the support of the discrete density function}
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
Class \code{"DiscreteDistribution"}, directly.
Class \code{"UnivariateDistribution"}, by class \code{"DiscreteDistribution"}.
Class \code{"Distribution"}, by class \code{"DiscreteDistribution"}.
}
\section{Methods}{
  \describe{
    \item{+}{\code{signature(e1 = "Pois", e2 = "Pois")}:
      For the Poisson distribution the exact convolution formula is
      implemented thereby improving the general numerical approximation.}
    \item{initialize}{\code{signature(.Object = "Pois")}:
      initialize method}
    \item{lambda}{\code{signature(object = "Pois")}:
      returns the slot lambda of the parameter of the distribution}
    \item{lambda<-}{\code{signature(object = "Pois")}:
      modifies the slot lambda of the parameter of the distribution}
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
}
\note{Working with a computer, we use a finite interval as support which carries at least mass \code{1-getdistrOption("TruncQuantile")}. }
\seealso{
\code{\link{PoisParameter-class}}
\code{\link{DiscreteDistribution-class}}
\code{\link{Naturals-class}}
\code{\link[stats:Poisson]{rpois}}
}
\examples{
P <- Pois(lambda = 1) # P is a Poisson distribution with lambda = 1.
r(P)(1) # one random number generated from this distribution, e.g. 1
d(P)(1) # Density of this distribution is 0.3678794 for x = 1.
p(P)(0.4) # Probability that x < 0.4 is 0.3678794.
q(P)(.1) # x = 0 is the smallest value x such that p(B)(x) >= 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
lambda(P) # lambda of this distribution is 1.
lambda(P) <- 2 # lambda of this distribution is now 2.
R <- Pois(lambda = 3) # R is a Poisson distribution with lambda = 2.
S <- P + R # R is a Poisson distribution with lambda = 5(=2+3).
}
\keyword{distribution}
\concept{discrete distribution}
\concept{lattice distribution}
\concept{Poisson distribution}
\concept{S4 parameter class}
\concept{generating function}
