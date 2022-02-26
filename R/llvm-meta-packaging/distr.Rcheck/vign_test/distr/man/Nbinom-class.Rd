\name{Nbinom-class} 
\docType{class}
\alias{Nbinom-class}
\alias{Nbinom}
\alias{initialize,Nbinom-method}

\title{Class "Nbinom" }
\description{
  The negative binomial distribution with \code{size} \eqn{= n}, by default \eqn{=1}, and
  \code{prob} \eqn{= p}, by default \eqn{=0.5}, has density
  \deqn{
    d(x) = \frac{\Gamma(x+n)}{\Gamma(n) x!} p^n (1-p)^x}{%
    d(x) = Gamma(x+n)/(Gamma(n) x!) p^n (1-p)^x}
  for \eqn{x = 0, 1, 2, \ldots}

  This represents the number of failures
  which occur in a sequence of Bernoulli trials before a target number
  of successes is reached.
  C.f. \code{\link[stats:NegBinomial]{rnbinom}} 
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{Nbinom(prob, size)}.
This object is a negative binomial distribution. 
}
\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Naturals"}: The space of the image of this
     distribution has got dimension 1 and the name "Natural Space". }
    \item{\code{param}}{Object of class \code{"NbinomParameter"}: the parameter of this distribution (prob, size),
     declared at its instantiation }
    \item{\code{r}}{Object of class \code{"function"}: generates random numbers (calls function \code{rnbinom}) }
    \item{\code{d}}{Object of class \code{"function"}: density function (calls function \code{dnbinom}) }
    \item{\code{p}}{Object of class \code{"function"}: cumulative function (calls function \code{pnbinom}) }
    \item{\code{q}}{Object of class \code{"function"}: inverse of the cumulative function (calls function \code{qnbinom}).
  The quantile is defined as the smallest value \eqn{x} such that
  \eqn{F(x) \ge p}, where \eqn{F} is the distribution function.}
    \item{\code{support}}{Object of class \code{"numeric"}: a (sorted) vector containing the support of the discrete
    density function}
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
    \item{initialize}{\code{signature(.Object = "Nbinom")}: initialize method }
    \item{prob}{\code{signature(object = "Nbinom")}: returns the slot \code{prob} of the parameter of the distribution }
    \item{prob<-}{\code{signature(object = "Nbinom")}: modifies the slot \code{prob} of the parameter of the distribution }
    \item{size}{\code{signature(object = "Nbinom")}: returns the slot \code{size} of the parameter of the distribution }
    \item{size<-}{\code{signature(object = "Nbinom")}: modifies the slot \code{size} of the parameter of the distribution }
    \item{+}{\code{signature(e1 = "Nbinom", e2 = "Nbinom")}: 
    For the negative binomial distribution we use its closedness under convolutions.}
  }
}

\author{
 Thomas Stabla \email{statho3@web.de},\cr 
 Florian Camphausen \email{fcampi@gmx.de},\cr
 Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
 Matthias Kohl \email{Matthias.Kohl@stamats.de}}

\note{Working with a computer, we use a finite interval as support which carries at least mass \code{1-getdistrOption("TruncQuantile")}. }

\seealso{
\code{\link{NbinomParameter-class}}
\code{\link{Geom-class}}
\code{\link{DiscreteDistribution-class}}
\code{\link{Naturals-class}}
\code{\link[stats:NegBinomial]{rnbinom}}
}
\examples{
N <- Nbinom(prob = 0.5, size = 1) # N is a binomial distribution with prob=0.5 and size=1.
r(N)(1) # one random number generated from this distribution, e.g. 3
d(N)(1) # Density of this distribution is  0.25 for x=1.
p(N)(0.4) # Probability that x<0.4 is 0.5.
q(N)(.1) # x=0 is the smallest value x such that p(B)(x)>=0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
size(N) # size of this distribution is 1.
size(N) <- 2 # size of this distribution is now 2.
}
\keyword{distribution}
\concept{discrete distribution}
\concept{lattice distribution}
\concept{Negative Binomial distribution}
\concept{S4 parameter class}
\concept{generating function}
