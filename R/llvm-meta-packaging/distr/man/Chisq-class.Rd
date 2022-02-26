\name{Chisq-class}
\docType{class}
\alias{Chisq-class}
\alias{Chisq}
\alias{initialize,Chisq-method}
\title{Class "Chisq"}
\description{
  The chi-squared distribution with \code{df}\eqn{= n} degrees of
  freedom has density
  \deqn{f_n(x) = \frac{1}{{2}^{n/2} \Gamma (n/2)} {x}^{n/2-1} {e}^{-x/2}}{%
    f_n(x) = 1 / (2^(n/2) Gamma(n/2))  x^(n/2-1) e^(-x/2)}
  for \eqn{x > 0}.  The mean and variance are \eqn{n} and \eqn{2n}.

  The non-central chi-squared distribution with \code{df}\eqn{= n}
  degrees of freedom and non-centrality parameter \code{ncp}
  \eqn{= \lambda} has density
  \deqn{
    f(x) = e^{-\lambda / 2}
      \sum_{r=0}^\infty \frac{(\lambda/2)^r}{r!}\, f_{n + 2r}(x)}{%
    f(x) = exp(-lambda/2) SUM_{r=0}^infty ((lambda/2)^r / r!) dchisq(x, df + 2r)
  }
  for \eqn{x \ge 0}.  For integer \eqn{n}, this is the distribution of
  the sum of squares of \eqn{n} normals each with variance one,
  \eqn{\lambda} being the sum of squares of the normal means.
  
  C.f. \code{\link[stats:Chisquare]{rchisq}}
}
 

\section{Objects from the Class}{
  Objects can be created by calls of the form \code{Chisq(df, ncp)}.
  This object is a chi-squared distribution.
}
\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Reals"}:
      The space of the image of this distribution has got dimension 1 and the name "Real Space".}
    \item{\code{param}}{Object of class \code{"ChisqParameter"}:
      the parameter of this distribution (df and ncp), declared at its instantiation}
    \item{\code{r}}{Object of class \code{"function"}:
      generates random numbers (calls function rchisq)}
    \item{\code{d}}{Object of class \code{"function"}:
      density function (calls function dchisq)}
    \item{\code{p}}{Object of class \code{"function"}:
      cumulative function (calls function pchisq)}
    \item{\code{q}}{Object of class \code{"function"}:
      inverse of the cumulative function (calls function qchisq)}
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
Class \code{"UnivariateDistribution"}, by class \code{"AbscontDistribution"}.\cr
Class \code{"Distribution"}, by class \code{"UnivariateDistribution"}.
}

\section{Is-Relations}{
By means of \code{setIs}, R ``knows'' that a distribution object \code{obj} of class \code{"Chisq"} with non-centrality 0 also is
a Gamma distribution with parameters \code{shape = df(obj)/2, scale = 2}. 
}

\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "Chisq")}: initialize method }
    \item{df}{\code{signature(object = "Chisq")}:
      returns the slot df of the parameter of the distribution }
    \item{df<-}{\code{signature(object = "Chisq")}:
      modifies the slot df of the parameter of the distribution }
    \item{ncp}{\code{signature(object = "Chisq")}:
      returns the slot ncp of the parameter of the distribution }
    \item{ncp<-}{\code{signature(object = "Chisq")}:
      modifies the slot ncp of the parameter of the distribution }
    \item{+}{\code{signature(e1 = "Chisq", e2 = "Chisq")}: 
    For the chi-squared distribution we use its closedness under convolutions.}
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr
  Matthias Kohl \email{Matthias.Kohl@stamats.de}}
\note{
Warning: The code for pchisq and qchisq is unreliable for values of ncp above approximately 290. 
}
\seealso{
\code{\link{ChisqParameter-class}}
\code{\link{AbscontDistribution-class}}
\code{\link{Reals-class}}
\code{\link[stats:Chisquare]{rchisq}}
}
\examples{
C <- Chisq(df = 1, ncp = 1) # C is a chi-squared distribution with df=1 and ncp=1.
r(C)(1) # one random number generated from this distribution, e.g. 0.2557184
d(C)(1) # Density of this distribution is 0.2264666 for x = 1.
p(C)(1) # Probability that x < 1 is 0.4772499.
q(C)(.1) # Probability that x < 0.04270125 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
df(C) # df of this distribution is 1.
df(C) <- 2 # df of this distribution is now 2.
is(C, "Gammad") # no
C0 <- Chisq() # default: Chisq(df=1,ncp=0)
is(C0, "Gammad") # yes
as(C0,"Gammad")
}
\keyword{distribution}
\concept{absolutely continuous distribution}
\concept{Chi square distribution}
\concept{S4 distribution class}
\concept{generating function}
