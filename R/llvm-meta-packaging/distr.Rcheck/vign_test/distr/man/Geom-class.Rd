\name{Geom-class}
\docType{class}
\alias{Geom-class}
\alias{Geom}
\alias{initialize,Geom-method}

\title{Class "Geom" }
\description{
  The geometric distribution with \code{prob} \eqn{= p} has density
  \deqn{p(x) = p {(1-p)}^{x}}{p(x) = p (1-p)^x}
  for \eqn{x = 0, 1, 2, \ldots}{x = 0, 1, 2, ...}
  
  C.f. \code{\link[stats:Geometric]{rgeom}}
}
\section{Objects from the Class}{
  Objects can be created by calls of the form \code{Geom(prob)}.
  This object is a geometric distribution. 
}
\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Naturals"}:
      The space of the image of this distribution has got dimension 1
      and the name "Natural Space".}
    \item{\code{param}}{Object of class \code{"NbinomParameter"}:
      the parameter of this distribution (prob),  
      declared at its instantiation (size=1)}
    \item{\code{r}}{Object of class \code{"function"}:
      generates random numbers (calls function rgeom)}
    \item{\code{d}}{Object of class \code{"function"}:
      density function (calls function dgeom)}
    \item{\code{p}}{Object of class \code{"function"}:
      cumulative function (calls function pgeom)}
    \item{\code{q}}{Object of class \code{"function"}:
      inverse of the cumulative function (calls function qgeom).
      The quantile is defined as the smallest value \eqn{x} such that
      \eqn{F(x) \ge p}, where \eqn{F} is the distribution function.}      
    \item{\code{support}}{Object of class \code{"numeric"}:
      a (sorted) vector containing the support of the discrete density
      function}
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
Class \code{"Nbinom"}, directly.\cr
Class \code{"UnivariateDistribution"}, by class \code{"DiscreteDistribution"}.\cr
Class \code{"Distribution"}, by class \code{"DiscreteDistribution"}.
}
\section{Contains-Relations}{
By means of a \code{contains} argument in the class declaration, R ``knows'' 
that a distribution object \code{obj} of class \code{"Geom"} also is a 
negative Binomial distribution with parameters \code{size = 1, prob = prob(obj)}
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "Geom")}: initialize method}
    \item{prob}{\code{signature(object = "Geom")}:
      returns the slot prob of the parameter of the distribution}
    \item{prob<-}{\code{signature(object = "Geom")}:
      modifies the slot prob of the parameter of the distribution}
  }
}

\author{
Thomas Stabla \email{statho3@web.de},\cr 
Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
}
\note{Working with a computer, we use a finite interval as support which carries 
      at least mass \code{1-getdistrOption("TruncQuantile")}. }

\seealso{
\code{\link{Nbinom-class}}
\code{\link{GeomParameter-class}}
\code{\link{DiscreteDistribution-class}}
\code{\link{Naturals-class}}
\code{\link[stats:Geometric]{rgeom}}
}
\examples{
G <- Geom(prob = 0.5) # G is a geometric distribution with prob = 0.5.
r(G)(1) # one random number generated from this distribution, e.g. 0
d(G)(1) # Density of this distribution is 0.25 for x = 1.
p(G)(1) # Probability that x<1 is 0.75.
q(G)(.1) # x = 0 is the smallest value x such that p(G)(x) >= 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
prob(G) # prob of this distribution is 0.5.
prob(G) <- 0.6 # prob of this distribution is now 0.6.
as(G,"Nbinom")
G+G+G
}
\keyword{distribution}
\concept{discrete distribution}
\concept{lattice distribution}
\concept{Geometric distribution}
\concept{Negative Binomial distribution}
\concept{S4 parameter class}
\concept{generating function}
