\name{AbscontDistribution-class} 
\docType{class}
\alias{AbscontDistribution-class}
\alias{AffLinDistribution-class}
\alias{AffLinAbscontDistribution-class}
\alias{sqrt,AbscontDistribution-method}
\alias{initialize,AbscontDistribution-method}
\alias{initialize,AffLinAbscontDistribution-method}
\alias{sqrt,AbscontDistribution-method}

\title{Class "AbscontDistribution"}
\description{The \code{AbscontDistribution}-class is the mother-class of the classes \code{Beta}, \code{Cauchy}, 
\code{Chisq}, \code{Exp}, \code{F}, \code{Gammad}, \code{Lnorm}, \code{Logis}, \code{Norm}, \code{T}, \code{Unif} and 
\code{Weibull}. Further absolutely continuous distributions can be defined either by declaration of
own random number generator, density, cumulative distribution and quantile functions, or as result of a 
convolution of two absolutely continuous distributions or by application of a mathematical operator to an absolutely
continuous distribution.}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("AbscontDistribution", r, d, p, q)}.
More comfortably, you may use the generating function \code{\link{AbscontDistribution}}.
The result of these calls is an absolutely continuous distribution. 
}
\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Reals"}: the space of the image of this distribution which has dimension 1
    and the name "Real Space" }
    \item{\code{param}}{Object of class \code{"Parameter"}: the parameter of this distribution, having only 
    the slot name "Parameter of an absolutely continuous distribution" }
    \item{\code{r}}{Object of class \code{"function"}: generates random numbers}
    \item{\code{d}}{Object of class \code{"function"}: density function}
    \item{\code{p}}{Object of class \code{"function"}: cumulative distribution function}
    \item{\code{q}}{Object of class \code{"function"}: quantile function}
    \item{\code{gaps}}{[from version 1.9 on] Object of class \code{"OptionalMatrix"}, 
          i.e.; an object which may either be \code{NULL} ora \code{matrix}. 
          This slot, if non-\code{NULL}, contains left and right 
          endpoints of intervals where the density of the object is 0. This slot 
          may be inspected by the accessor \code{\link{gaps}()} and modified by a corresponding
          replacement method. It may also be filled automatically by 
         \code{\link{setgaps}()}. For saved objects from earlier versions, we provide functions
         \code{\link{isOldVersion}} and \code{\link{conv2NewVersion}}.}
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
}}
\section{Extends}{
Class \code{"UnivariateDistribution"}, directly. \cr
Class \code{"Distribution"}, by class \code{"UnivariateDistribution"}.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "AbscontDistribution")}: initialize method }
    \item{Math}{\code{signature(x = "AbscontDistribution")}: application of a mathematical function, e.g. \code{sin} or
    \code{exp} (does not work with \code{log}, \code{sign}!), to this absolutely continouos distribution
    \itemize{
      \item \code{abs}: \code{signature(x = "AbscontDistribution")}: exact image distribution of \code{abs(x)}.
      \item \code{exp}: \code{signature(x = "AbscontDistribution")}:  exact image distribution of \code{exp(x)}.
      \item \code{sign}: \code{signature(x = "AbscontDistribution")}:  exact image distribution of \code{sign(x)}.
      \item \code{sqrt}: \code{signature(x = "AbscontDistribution")}:  exact image distribution of \code{sqrt(x)}.
      \item \code{log}: \code{signature(x = "AbscontDistribution")}:  (with optional further argument \code{base}, defaulting to \code{exp(1)}) exact image distribution of \code{log(x)}.
      \item \code{log10}: \code{signature(x = "AbscontDistribution")}:  exact image distribution of \code{log10(x)}.
      \item \code{gamma}: \code{signature(x = "AbscontDistribution")}:  exact image distribution of \code{gamma(x)}.
      \item \code{lgamma}: \code{signature(x = "AbscontDistribution")}:  exact image distribution of \code{lgamma(x)}.
      \item \code{digamma}: \code{signature(x = "AbscontDistribution")}:  exact image distribution of \code{digamma(x)}.
      \item \code{sqrt}: \code{signature(x = "AbscontDistribution")}:  exact image distribution of \code{sqrt(x)}.
    }}
    \item{-}{\code{signature(e1 = "AbscontDistribution")}: application of `-' to this absolutely continuous distribution.}
    \item{*}{\code{signature(e1 = "AbscontDistribution", e2 = "numeric")}: multiplication of this absolutely continuous distribution by an object of class \code{"numeric"}}
    \item{/}{\code{signature(e1 = "AbscontDistribution", e2 = "numeric")}: division of this absolutely continuous distribution by an object of class \code{"numeric"}}
    \item{+}{\code{signature(e1 = "AbscontDistribution", e2 = "numeric")}: addition of this absolutely continuous distribution to an object of class \code{"numeric"}.}
    \item{-}{\code{signature(e1 = "AbscontDistribution", e2 = "numeric")}: subtraction of an object of class \code{"numeric"} from this absolutely continuous distribution.}
    \item{*}{\code{signature(e1 = "numeric", e2 = "AbscontDistribution")}: multiplication of this absolutely continuous distribution by an object of class \code{"numeric"}.}
    \item{+}{\code{signature(e1 = "numeric", e2 = "AbscontDistribution")}: addition of this absolutely continuous distribution to an object of class \code{"numeric"}.}
    \item{-}{\code{signature(e1 = "numeric", e2 = "AbscontDistribution")}: subtraction of this absolutely continuous distribution from an object of class \code{"numeric"}.}
    \item{+}{\code{signature(e1 = "AbscontDistribution", e2 = "AbscontDistribution")}: Convolution of two absolutely continuous distributions. The slots p, d and q are approximated by grids.}
    \item{-}{\code{signature(e1 = "AbscontDistribution", e2 = "AbscontDistribution")}: Convolution of two absolutely continuous distributions. The slots p, d and q are approximated by grids.}
    \item{plot}{\code{signature(object = "AbscontDistribution")}: plots density, cumulative distribution and quantile function.}
  }
}

\section{Internal subclass "AffLinAbscontDistribution"}{
To enhance accuracy of several functionals on distributions,
  mainly from package \pkg{distrEx}, from version 1.9 of this package on, 
  there is an internally used (but exported) subclass 
  \code{"AffLinAbscontDistribution"} which has extra slots 
  \code{a}, \code{b} (both of class \code{"numeric"}),  and \code{X0} 
  (of class \code{"AbscontDistribution"}), to capture the fact 
  that the object has the same distribution as \code{a * X0 + b}. This is 
  the class of the return value of methods 
  \describe{
    \item{-}{\code{signature(e1 = "AbscontDistribution")}}
    \item{*}{\code{signature(e1 = "AbscontDistribution", e2 = "numeric")}}
    \item{/}{\code{signature(e1 = "AbscontDistribution", e2 = "numeric")}}
    \item{+}{\code{signature(e1 = "AbscontDistribution", e2 = "numeric")}}
    \item{-}{\code{signature(e1 = "AbscontDistribution", e2 = "numeric")}}
    \item{*}{\code{signature(e1 = "numeric", e2 = "AbscontDistribution")}}
    \item{+}{\code{signature(e1 = "numeric", e2 = "AbscontDistribution")}}
    \item{-}{\code{signature(e1 = "numeric", e2 = "AbscontDistribution")}}
    \item{-}{\code{signature(e1 = "AffLinAbscontDistribution")}}
    \item{*}{\code{signature(e1 = "AffLinAbscontDistribution", e2 = "numeric")}}
    \item{/}{\code{signature(e1 = "AffLinAbscontDistribution", e2 = "numeric")}}
    \item{+}{\code{signature(e1 = "AffLinAbscontDistribution", e2 = "numeric")}}
    \item{-}{\code{signature(e1 = "AffLinAbscontDistribution", e2 = "numeric")}}
    \item{*}{\code{signature(e1 = "numeric", e2 = "AffLinAbscontDistribution")}}
    \item{+}{\code{signature(e1 = "numeric", e2 = "AffLinAbscontDistribution")}}
    \item{-}{\code{signature(e1 = "numeric", e2 = "AffLinAbscontDistribution")}}
  }
  There also is a class union of \code{"AffLinAbscontDistribution"},
  \code{"AffLinDiscreteDistribution"}, \code{"AffLinUnivarLebDecDistribution"}
  and called \code{"AffLinDistribution"}
  which is used for functionals.
}
\section{Internal virtual superclass "AcDcLcDistribution"}{
As many operations should be valid no matter whether the operands
are of class \code{"AbscontDistribution"},
  \code{"DiscreteDistribution"}, or \code{"UnivarLebDecDistribution"},
there is a class union of these classes called \code{"AcDcLcDistribution"};
in partiucalar methods for \code{"*"}, \code{"/"}, 
\code{"^"} (see \link{operators-methods}) and methods
\code{\link{Minimum}}, \code{Maximum}, \code{\link{Truncate}}, and
 \code{\link{Huberize}}, and \code{\link{convpow}} are defined for this 
 class union.   
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
  }


\seealso{
\code{\link{AbscontDistribution}}
\code{\link{Parameter-class}}
\code{\link{UnivariateDistribution-class}}
\code{\link{Beta-class}}
\code{\link{Cauchy-class}}
\code{\link{Chisq-class}}
\code{\link{Exp-class}}
\code{\link{Fd-class}}
\code{\link{Gammad-class}}
\code{\link{Lnorm-class}}
\code{\link{Logis-class}}
\code{\link{Norm-class}}
\code{\link{Td-class}}
\code{\link{Unif-class}}
\code{\link{Weibull-class}}
\code{\link{DiscreteDistribution-class}}
\code{\link{Reals-class}}
\code{\link{RtoDPQ}}

}
\examples{
N <-  Norm() # N is a normal distribution with mean=0 and sd=1.
E <-  Exp() # E is an exponential distribution with rate=1.
A1 <-  E+1 # a new absolutely continuous distributions with exact slots d, p, q
A2 <-  A1*3 # a new absolutely continuous distributions with exact slots d, p, q
A3 <- N*0.9 + E*0.1 # a new absolutely continuous distribution with approximated slots d, p, q
r(A3)(1) # one random number generated from this distribution, e.g. -0.7150937
d(A3)(0) # The (approximated) density for x=0 is 0.43799.
p(A3)(0) # The (approximated) probability that x <= 0 is 0.45620.
q(A3)(.1) # The (approximated) 10 percent quantile is -1.06015.
## in RStudio or Jupytier IRKernel, use q.l(.)(.) instead of q(.)(.)
}
\keyword{distribution}
\concept{absolutely continuous distribution}
\concept{S4 distribution class}
