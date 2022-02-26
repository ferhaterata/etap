\name{DiscreteDistribution-class}
\docType{class}
\alias{DiscreteDistribution-class}
\alias{AffLinDiscreteDistribution-class}
\alias{initialize,DiscreteDistribution-method}
\alias{initialize,AffLinDiscreteDistribution-method}
\alias{sqrt,DiscreteDistribution-method}
\alias{coerce,DiscreteDistribution,LatticeDistribution-method}
\alias{coerce,AffLinDiscreteDistribution,LatticeDistribution-method}

\title{Class "DiscreteDistribution"}
\description{The \code{DiscreteDistribution}-class is the mother-class of the class \code{LatticeDistribution}.}
\section{Objects from the Class}{
Objects can be created by calls to \code{new("DiscreteDistribution", ...)}, but more
easily is the use of the generating function \code{"DiscreteDistribution"}.
This generating function, from version 1.9 on, has been moved to this package from package \pkg{distrEx}.
}

\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Reals"}: the space of the image of this distribution which has dimension 1
    and the name "Real Space" }
    \item{\code{param}}{Object of class \code{"Parameter"}: the parameter of this distribution, having only the
    slot name "Parameter of a discrete distribution" }
    \item{\code{r}}{Object of class \code{"function"}: generates random numbers}
    \item{\code{d}}{Object of class \code{"function"}: density/probability function}
    \item{\code{p}}{Object of class \code{"function"}: cumulative distribution function}
    \item{\code{q}}{Object of class \code{"function"}: quantile function}
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
    \item{\code{.finSupport}}{logical: used internally to check whether the
     true support is finite; in case \code{img} is one-dimensional, it is
     of length 2 (left and right end).}
    \item{\code{Symmetry}}{object of class \code{"DistributionSymmetry"};
     used internally to avoid unnecessary calculations.}
  }
}
\section{Extends}{
Class \code{"UnivariateDistribution"}, directly.\cr
Class \code{"Distribution"}, by class \code{"UnivariateDistribution"}.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "DiscreteDistribution")}: initialize method }
    \item{coerce}{\code{signature(from = "DiscreteDistribution", 
                   to = "LatticeDistribution")}: coerce method to class \code{"LatticeDistribution"}
                   (checks if support is a lattice)}
    \item{Math}{\code{signature(x = "DiscreteDistribution")}: application of a mathematical function, e.g. \code{sin} or \code{tan} to this discrete distribution
    \itemize{
      \item \code{abs}: \code{signature(x = "DiscreteDistribution")}:  exact image distribution of \code{abs(x)}.
      \item \code{exp}: \code{signature(x = "DiscreteDistribution")}:  exact image distribution of \code{exp(x)}.
      \item \code{sign}: \code{signature(x = "DiscreteDistribution")}:  exact image distribution of \code{sign(x)}.
      \item \code{sqrt}: \code{signature(x = "DiscreteDistribution")}:  exact image distribution of \code{sqrt(x)}.
      \item \code{log}: \code{signature(x = "DiscreteDistribution")}:  (with optional further argument \code{base}, defaulting to \code{exp(1)}) exact image distribution of \code{log(x)}.
      \item \code{log10}: \code{signature(x = "DiscreteDistribution")}:  exact image distribution of \code{log10(x)}.
      \item \code{gamma}: \code{signature(x = "DiscreteDistribution")}:  exact image distribution of \code{gamma(x)}.
      \item \code{lgamma}: \code{signature(x = "DiscreteDistribution")}:  exact image distribution of \code{lgamma(x)}.
      \item \code{digamma}: \code{signature(x = "DiscreteDistribution")}:  exact image distribution of \code{digamma(x)}.
    }}
    \item{-}{\code{signature(e1 = "DiscreteDistribution")}: application of `-' to this discrete distribution}
    \item{*}{\code{signature(e1 = "DiscreteDistribution", e2 = "numeric")}: multiplication of this discrete distribution
    by an object of class `numeric'}
    \item{/}{\code{signature(e1 = "DiscreteDistribution", e2 = "numeric")}: division of this discrete distribution
    by an object of class `numeric'}
    \item{+}{\code{signature(e1 = "DiscreteDistribution", e2 = "numeric")}: addition of this discrete distribution
    to an object of class `numeric'}
    \item{-}{\code{signature(e1 = "DiscreteDistribution", e2 = "numeric")}: subtraction of an object of class `numeric'
    from this discrete distribution }
    \item{*}{\code{signature(e1 = "numeric", e2 = "DiscreteDistribution")}: multiplication of this discrete distribution
    by an object of class `numeric'}
    \item{+}{\code{signature(e1 = "numeric", e2 = "DiscreteDistribution")}: addition of this discrete distribution
    to an object of class `numeric'}
    \item{-}{\code{signature(e1 = "numeric", e2 = "DiscreteDistribution")}: subtraction of this discrete distribution
    from an object of class `numeric'}
    \item{+}{\code{signature(e1 = "DiscreteDistribution", e2 = "DiscreteDistribution")}: Convolution of two discrete
    distributions. The slots p, d and q are approximated on a common grid.}
    \item{-}{\code{signature(e1 = "DiscreteDistribution", e2 = "DiscreteDistribution")}: Convolution of two discrete
    distributions. The slots p, d and q are approximated on a common grid.}
    \item{support}{\code{signature(object = "DiscreteDistribution")}: returns the support}
    \item{p.l}{\code{signature(object = "DiscreteDistribution")}: returns the 
               left continuous cumulative distribution function, i.e.; 
               \eqn{p.l(t) = P(object < t)}{p.l(t) = P(object < t)} }
    \item{q.r}{\code{signature(object = "DiscreteDistribution")}: returns the 
               right-continuous quantile function, i.e.; 
    \eqn{{\rm q.r}(s)=\sup\{t \,\big|\, P({\tt object}\ge t)\leq s\}}{q.r(s)=sup\{t|P(object>=t)<=s\}}}
    \item{plot}{\code{signature(object = "DiscreteDistribution")}: plots density, cumulative distribution and quantile
    function }
  }
}

\section{Internal subclass "AffLinDiscreteDistribution"}{
To enhance accuracy of several functionals on distributions,
  mainly from package \pkg{distrEx}, from version 1.9 of this package on, 
  there is an internally used (but exported) subclass 
  \code{"AffLinDiscreteDistribution"} which has extra slots 
  \code{a}, \code{b} (both of class \code{"numeric"}),  and \code{X0} 
  (of class \code{"DiscreteDistribution"}), to capture the fact 
  that the object has the same distribution as \code{a * X0 + b}. This is 
  the class of the return value of methods 
  \describe{
    \item{-}{\code{signature(e1 = "DiscreteDistribution")}}
    \item{*}{\code{signature(e1 = "DiscreteDistribution", e2 = "numeric")}}
    \item{/}{\code{signature(e1 = "DiscreteDistribution", e2 = "numeric")}}
    \item{+}{\code{signature(e1 = "DiscreteDistribution", e2 = "numeric")}}
    \item{-}{\code{signature(e1 = "DiscreteDistribution", e2 = "numeric")}}
    \item{*}{\code{signature(e1 = "numeric", e2 = "DiscreteDistribution")}}
    \item{+}{\code{signature(e1 = "numeric", e2 = "DiscreteDistribution")}}
    \item{-}{\code{signature(e1 = "numeric", e2 = "DiscreteDistribution")}}
    \item{-}{\code{signature(e1 = "AffLinDiscreteDistribution")}}
    \item{*}{\code{signature(e1 = "AffLinDiscreteDistribution", e2 = "numeric")}}
    \item{/}{\code{signature(e1 = "AffLinDiscreteDistribution", e2 = "numeric")}}
    \item{+}{\code{signature(e1 = "AffLinDiscreteDistribution", e2 = "numeric")}}
    \item{-}{\code{signature(e1 = "AffLinDiscreteDistribution", e2 = "numeric")}}
    \item{*}{\code{signature(e1 = "numeric", e2 = "AffLinDiscreteDistribution")}}
    \item{+}{\code{signature(e1 = "numeric", e2 = "AffLinDiscreteDistribution")}}
    \item{-}{\code{signature(e1 = "numeric", e2 = "AffLinDiscreteDistribution")}}
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

\note{ Working with a computer, we use a finite interval as support which 
       carries at least mass \code{1-getdistrOption("TruncQuantile")}. \cr
       
       Also, we require that support points have distance at least       
       \code{getdistrOption("DistrResoltion")}, if this condition fails,
       upon a suggestion by Jacob van Etten, \email{jacobvanetten@yahoo.com},
       we use the global option \code{getdistrOption("DistrCollapse")} to
       decide whether we use collapsing or not. If we do so, we collapse support 
       points if they are too close to each other, taking
       the (left most) median among them as new support point which accumulates
       all the mass of the collapsed points. 
       With \code{getdistrOption("DistrCollapse")==FALSE}, we at least collapse
       points according to the result of \code{unique()}, and if after this
       collapsing, the minimal distance is less than \code{getdistrOption("DistrResoltion")},
       we throw an error. By \code{getdistrOption("DistrCollapse.Unique.Warn")},
       we control, whether we throw a warning upon collapsing or not.       
       }

\seealso{
\code{\link{Parameter-class}}
\code{\link{UnivariateDistribution-class}}
\code{\link{LatticeDistribution-class}}
\code{\link{AbscontDistribution-class}}
\code{\link{Reals-class}}
\code{\link{RtoDPQ.d}}
}
\examples{
# Dirac-measure at 0
D1 <- DiscreteDistribution(supp = 0)
support(D1)

# simple discrete distribution
D2 <- DiscreteDistribution(supp = c(1:5), prob = c(0.1, 0.2, 0.3, 0.2, 0.2))
plot(D2)
(pp <- p(D2)(support(D2)))
p(D2)(support(D2)-1e-5)
p(D2)(support(D2)+1e-5)
p.l(D2)(support(D2))
p.l(D2)(support(D2)-1e-5)
p.l(D2)(support(D2)+1e-5)
q(D2)(pp)
q(D2)(pp-1e-5)
q(D2)(pp+1e-5)
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
q.r(D2)(pp)
q.r(D2)(pp-1e-5)
q.r(D2)(pp+1e-5)
}
\keyword{distribution}
\concept{discrete distribution}
\concept{lattice distribution}
\concept{support of a distribution}
\concept{S4 distribution class}
