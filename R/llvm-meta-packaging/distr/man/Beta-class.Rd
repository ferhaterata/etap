\name{Beta-class}
\docType{class}
\alias{Beta-class}
\alias{Beta}
\alias{initialize,Beta-method}
\title{Class "Beta"}
\description{
  The Beta distribution with parameters \code{shape1} \eqn{= a} and
  \code{shape2} \eqn{= b} has density
  \deqn{f(x)=\frac{\Gamma(a+b)}{\Gamma(a)\Gamma(b)}{x}^{a-1} {(1-x)}^{b-1}%
  }{Gamma(a+b)/(Gamma(a)Gamma(b))x^(a-1)(1-x)^(b-1)}
  for \eqn{a > 0}, \eqn{b > 0} and \eqn{0 \le x \le 1}{0 <= x <= 1}
  where the boundary values at \eqn{x=0} or \eqn{x=1} are defined as
  by continuity (as limits).
}
\note{ 
  The non-central Beta distribution is defined (Johnson et al, 1995,
  pp. 502) as the distribution of \eqn{X/(X+Y)} where
  \eqn{X \sim \chi^2_{2a}(\lambda)}{X ~ chi^2_2a(lambda)} and
  \eqn{Y \sim \chi^2_{2b}}{Y ~ chi^2_2b}.
  C.f. \code{\link[stats:Beta]{rbeta}} }

\section{Ad hoc methods}{
 For R Version \code{<2.3.0} ad hoc methods are provided for slots \code{q}, \code{r} if \code{ncp!=0};
      for R Version \code{>=2.3.0} the methods from package \pkg{stats} are used.
      }

\section{Objects from the Class}{
  Objects can be created by calls of the form \code{Beta(shape1, shape2)}.
  This object is a beta distribution.
}
\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Reals"}:
      The space of the image of this distribution has got dimension 1 and the name "Real Space". }
    \item{\code{param}}{Object of class \code{"BetaParameter"}:
      the parameter of this distribution (shape1 and shape2), declared at its instantiation }
    \item{\code{r}}{Object of class \code{"function"}:
      generates random numbers (calls function rbeta)}
    \item{\code{d}}{Object of class \code{"function"}:
      density function (calls function dbeta)}
    \item{\code{p}}{Object of class \code{"function"}:
      cumulative function (calls function pbeta)}
    \item{\code{q}}{Object of class \code{"function"}:
      inverse of the cumulative function (calls function qbeta)}
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
  Class \code{"AbscontDistribution"}, directly. \cr
  Class \code{"UnivariateDistribution"}, by class \code{"AbscontDistribution"}. \cr
  Class \code{"Distribution"}, by class \code{"AbscontDistribution"}.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "Beta")}:
      initialize method}
    \item{shape1}{\code{signature(object = "Beta")}:
      returns the slot shape1 of the parameter of the distribution}
    \item{shape1<-}{\code{signature(object = "Beta")}:
      modifies the slot shape1 of the parameter of the distribution}
    \item{shape2}{\code{signature(object = "Beta")}:
      returns the slot shape2 of the parameter of the distribution}
    \item{shape2<-}{\code{signature(object = "Beta")}:
      modifies the slot shape2 of the parameter of the distribution}
    \item{\code{-}}{\code{signature(e1 = "numeric", e2 = "Beta")} if \code{ncp(e2)==0} and \code{e1 == 1},
     an exact (central) \code{Beta(shape1 = shape2(e2), shape2 = shape1(e2))} is returned, else
     the default method is used; exact}
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
}
\seealso{
  \code{\link{BetaParameter-class}}
  \code{\link{AbscontDistribution-class}}
  \code{\link{Reals-class}}
  \code{\link[stats:Beta]{rbeta}}
}
\examples{
B <- Beta(shape1 = 1, shape2 = 1)
# B is a beta distribution with shape1 = 1 and shape2 = 1.
r(B)(1) # one random number generated from this distribution, e.g. 0.6979795
d(B)(1) # Density of this distribution is 1 for x=1.
p(B)(1) # Probability that x < 1 is 1.
q(B)(.1) # Probability that x < 0.1 is 0.1.
shape1(B) # shape1 of this distribution is 1.
shape1(B) <- 2 # shape1 of this distribution is now 2.
Bn <- Beta(shape1 = 1, shape2 = 3, ncp = 5) 
# Bn is a beta distribution with shape1 = 1 and shape2 = 3 and ncp = 5.
B0 <- Bn; ncp(B0) <- 0; 
# B0 is just the same beta distribution as Bn but with ncp = 0
q(B0)(0.1) ## 
q(Bn)(0.1) ## => from R 2.3.0 on ncp no longer ignored...
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
}
\keyword{distribution}
\concept{absolutely continuous distribution}
\concept{Beta distribution}
\concept{S4 distribution class}
\concept{generating function}
