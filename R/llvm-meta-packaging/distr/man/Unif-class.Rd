\name{Unif-class} 
\docType{class}
\alias{Unif-class}
\alias{Unif}
\alias{initialize,Unif-method}

\title{Class "Unif"}
\description{ 
  The uniform distribution has density
  \deqn{d(x) = \frac{1}{max-min}}{d(x) = 1/(max-min)}
  for \eqn{min}, by default \eqn{=0}, \eqn{\le x \le max}, by default \eqn{=1}.
C.f. \code{\link[stats:Uniform]{runif}} 
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{Unif(Min, Max)}.
This object is a uniform distribution.
}
\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Reals"}: The space of the image of this distribution has got dimension 1
    and the name "Real Space". }
    \item{\code{param}}{Object of class \code{"UnifParameter"}: the parameter of this distribution (Min and Max),
     declared at its instantiation }
    \item{\code{r}}{Object of class \code{"function"}: generates random numbers (calls function \code{runif})}
    \item{\code{d}}{Object of class \code{"function"}: density function (calls function \code{dunif})}
    \item{\code{p}}{Object of class \code{"function"}: cumulative function (calls function \code{punif})}
    \item{\code{q}}{Object of class \code{"function"}: inverse of the cumulative function (calls function \code{qunif})}
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
By means of \code{setIs}, R ``knows'' that a distribution object \code{obj} of class \code{"Unif"} with Min 0 and Max 1 also is
a Beta distribution with parameters \code{shape1 = 1, shape2 = 1, ncp = 0}. 
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "Unif")}: initialize method }
    \item{Min}{\code{signature(object = "Unif")}: returns the slot \code{Min} of the parameter of the distribution }
    \item{Min<-}{\code{signature(object = "Unif")}: modifies the slot \code{Min} of the parameter of the distribution }
    \item{Max}{\code{signature(object = "Unif")}: returns the slot \code{Max} of the parameter of the distribution }
    \item{Max<-}{\code{signature(object = "Unif")}: modifies the slot \code{Max} of the parameter of the distribution }
    \item{*}{\code{signature(e1 = "Unif", e2 = "numeric")}: multiplication of this uniform distribution
    by an object of class `numeric'}
    \item{+}{\code{signature(e1 = "Unif", e2 = "numeric")}: addition of this uniform distribution
    to an object of class `numeric'}
}}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}}


\seealso{
\code{\link{UnifParameter-class}}
\code{\link{AbscontDistribution-class}}
\code{\link{Reals-class}}
\code{\link[stats:Uniform]{runif}}

}
\examples{
U <- Unif(Min=0,Max=2) # U is a uniform distribution with Min=0 and Max=2.
r(U)(1) # one random number generated from this distribution, e.g. 1.984357
d(U)(1) # Density of this distribution is 0.5 for x=1.
p(U)(1) # Probability that x<1 is 0.5.
q(U)(.1) # Probability that x<0.2 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
Min(U) # Min of this distribution is 0.
Min(U) <- 1 # Min of this distribution is now 1.
Min(U) # Min of this distribution is 1.
Min(U) <- 0
is(U/2,"Beta") # yes
V <- U/2; as(V,"Beta")
}
\keyword{distribution}
\concept{absolutely continuous distribution}
\concept{Uniform distribution}
\concept{S4 distribution class}
\concept{generating function}
