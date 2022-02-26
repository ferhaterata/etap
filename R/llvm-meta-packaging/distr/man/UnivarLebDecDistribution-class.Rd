\name{UnivarLebDecDistribution-class}
\docType{class}
\alias{UnivarLebDecDistribution-class}
\alias{AffLinUnivarLebDecDistribution-class}
\alias{AcDcLcDistribution-class}
\alias{acPart}
\alias{discretePart}
\alias{acPart<-}
\alias{discretePart<-}
\alias{acPart-methods}
\alias{discretePart-methods}
\alias{acPart<--methods}
\alias{discretePart<--methods}
\alias{acPart,UnivarLebDecDistribution-method}
\alias{discretePart,UnivarLebDecDistribution-method}
\alias{acPart<-,UnivarLebDecDistribution-method}
\alias{discretePart<-,UnivarLebDecDistribution-method}
\alias{acWeight}
\alias{discreteWeight}
\alias{acWeight<-}
\alias{discreteWeight<-}
\alias{acWeight-methods}
\alias{discreteWeight-methods}
\alias{acWeight<--methods}
\alias{discreteWeight<--methods}
\alias{acWeight,UnivarLebDecDistribution-method}
\alias{discreteWeight,UnivarLebDecDistribution-method}
\alias{acWeight<-,UnivarLebDecDistribution-method}
\alias{discreteWeight<-,UnivarLebDecDistribution-method}
\alias{p.discrete,UnivarLebDecDistribution-method}
\alias{d.discrete,UnivarLebDecDistribution-method}
\alias{q.discrete,UnivarLebDecDistribution-method}
\alias{r.discrete,UnivarLebDecDistribution-method}
\alias{p.ac,UnivarLebDecDistribution-method}
\alias{d.ac,UnivarLebDecDistribution-method}
\alias{q.ac,UnivarLebDecDistribution-method}
\alias{r.ac,UnivarLebDecDistribution-method}
\alias{p.discrete-methods}
\alias{d.discrete-methods}
\alias{q.discrete-methods}
\alias{r.discrete-methods}
\alias{p.ac-methods}
\alias{d.ac-methods}
\alias{q.ac-methods}
\alias{r.ac-methods}
\alias{p.discrete}
\alias{d.discrete}
\alias{q.discrete}
\alias{r.discrete}
\alias{p.ac}
\alias{d.ac}
\alias{q.ac}
\alias{r.ac}
\alias{coerce,AbscontDistribution,UnivarLebDecDistribution-method}
\alias{coerce,DiscreteDistribution,UnivarLebDecDistribution-method}
\alias{coerce,AffLinUnivarLebDecDistribution,UnivarLebDecDistribution-method}
\alias{abs,UnivarLebDecDistribution-method}
\alias{log,UnivarLebDecDistribution-method}
\alias{log10,UnivarLebDecDistribution-method}
\alias{Math,UnivarLebDecDistribution-method}
\alias{^,AcDcLcDistribution,Dirac-method}
\alias{exp,UnivarLebDecDistribution-method}
\alias{sign,UnivarLebDecDistribution-method}
\alias{sign,AcDcLcDistribution-method}
\alias{sqrt,UnivarLebDecDistribution-method}
\alias{sqrt,AcDcLcDistribution-method}

\title{Class "UnivarLebDecDistribution"}
\description{\code{UnivarLebDecDistribution}-class is a class to formalize
                   a Lebesgue decomposed distribution with a discrete and an
                   absolutely continuous part; it is a subclass to
                   class \code{UnivarMixingDistribution}.}
\section{Objects from the Class}{
Objects can be created by calls of the form
\code{new("UnivarLebDecDistribution", ...)}.
  More frequently they are created via the generating function
  \code{\link{UnivarLebDecDistribution}}.
}
\section{Slots}{
  \describe{
    \item{\code{mixCoeff}}{Object of class \code{"numeric"}: a vector of length
            2 of probabilities for the respective a.c. and discrete part of
            the object}
    \item{\code{mixDistr}}{Object of class \code{"UnivarDistrList"}: a list of
    univariate distributions containing the a.c. and discrete components; must be of
    length 2; the first component must be of class \code{"AbscontDistribution"},
    the second of class \code{"DiscreteDistribution"}.}
    \item{\code{img}}{Object of class \code{"Reals"}: the space of the image of this distribution which has dimension 1
    and the name "Real Space" }
    \item{\code{param}}{Object of class \code{"Parameter"}: the parameter of this distribution, having only the
    slot name "Parameter of a discrete distribution" }
    \item{\code{r}}{Object of class \code{"function"}: generates random numbers}
    \item{\code{d}}{fixed to \code{NULL}}
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
    \item{\code{Symmetry}}{object of class \code{"DistributionSymmetry"};
     used internally to avoid unnecessary calculations.}
    \item{\code{support}}{numeric vector --- the support slot of the discrete part}
    \item{\code{gaps}}{(numeric) matrix or \code{NULL}; --- the gaps slot of 
                         the absolutely continuous part}
  }
}
\section{Extends}{
Class \code{"UnivarMixingDistribution"}, directly;
class \code{"UnivariateDistribution"} by class \code{"UnivarMixingDistribution"}
class \code{"Distribution"} by class \code{"UnivariateDistribution"}.
}
\section{Methods}{
  \describe{
    \item{show}{\code{signature(object = "UnivarLebDecDistribution")}}
    \item{plot}{\code{signature(object = "UnivarLebDecDistribution")}}
    \item{acPart}{\code{signature(object = "UnivarLebDecDistribution")}}
    \item{acPart<-}{\code{signature(object = "UnivarLebDecDistribution")}}
    \item{discretePart}{\code{signature(object = "UnivarLebDecDistribution")}}
    \item{discretePart<-}{\code{signature(object = "UnivarLebDecDistribution")}}
    \item{acWeight}{\code{signature(object = "UnivarLebDecDistribution")}}
    \item{acWeight<-}{\code{signature(object = "UnivarLebDecDistribution")}}
    \item{discreteWeight}{\code{signature(object = "UnivarLebDecDistribution")}}
    \item{discreteWeight<-}{\code{signature(object = "UnivarLebDecDistribution")}}
    \item{p.ac}{\code{signature(object = "UnivarLebDecDistribution")} accessor to 
                slot \code{p} of \code{acPart(object)}, possibly weighted 
                by \code{acWeight(object)}; 
                it has an extra argument \code{CondOrAbs} with default value 
                \code{"cond"} which if it does not partially match 
               (by \code{\link{pmatch}}) \code{"abs"}, returns exactly
               slot \code{p} of \code{acPart(object)} else weighted by 
               \code{acWeight(object)}.}
    \item{d.ac}{\code{signature(object = "UnivarLebDecDistribution")}accessor to 
                slot \code{d} of the absolutely continuous part of
                the distribution, possibly weighted by \code{acWeight(object)}; 
                it has an extra argument \code{CondOrAbs} which acts as the one
                in \code{p.ac}.}
    \item{q.ac}{\code{signature(object = "UnivarLebDecDistribution")} accessor to 
                slot \code{q} of \code{acPart(object)}.}
    \item{r.ac}{\code{signature(object = "UnivarLebDecDistribution")} accessor to 
                slot \code{q} of \code{acPart(object)}.}
    \item{p.discrete}{\code{signature(object = "UnivarLebDecDistribution")} 
                      accessor to slot \code{p} of \code{discretePart(object)}, 
                      possibly weighted by \code{discreteWeight(object)}; 
                      it has an extra argument \code{CondOrAbs} which acts 
                      as the one in \code{p.ac}.}
    \item{d.discrete}{\code{signature(object = "UnivarLebDecDistribution")} 
                      accessor to slot \code{d} of \code{discretePart(object)}, 
                      possibly weighted by \code{discreteWeight(object)}; 
                      it has an extra argument \code{CondOrAbs} which acts as 
                      the one in \code{p.ac}.}
    \item{q.discrete}{\code{signature(object = "UnivarLebDecDistribution")} 
                      accessor to slot \code{q} of \code{discretePart(object)}.}
    \item{r.discrete}{\code{signature(object = "UnivarLebDecDistribution")} 
                      accessor to slot \code{r} of \code{discretePart(object)}.}
    \item{coerce}{\code{signature(from = "AffLinUnivarLebDecDistribution", to = "UnivarLebDecDistribution")}:
      create a \code{"UnivarLebDecDistribution"} object from a \code{"AffLinUnivarLebDecDistribution"} object}
    \item{coerce}{\code{signature(from = "AbscontDistribution", to = "UnivarLebDecDistribution")}:
      create a \code{"UnivarLebDecDistribution"} object from a \code{"AbscontDistribution"} object}
    \item{coerce}{\code{signature(from = "DiscreteDistribution", to = "UnivarLebDecDistribution")}:
      create a \code{"UnivarLebDecDistribution"} object from a \code{"DiscreteDistribution"} object}
    \item{Math}{\code{signature(x = "UnivarLebDecDistribution")}: application of a mathematical function, e.g. \code{sin} or \code{tan} to this discrete distribution
    \itemize{
      \item \code{abs}: \code{signature(x = "UnivarLebDecDistribution")}:  exact image distribution of \code{abs(x)}.
      \item \code{exp}: \code{signature(x = "UnivarLebDecDistribution")}:  exact image distribution of \code{exp(x)}.
      \item \code{sign}: \code{signature(x = "UnivarLebDecDistribution")}:  exact image distribution of \code{sign(x)}.
      \item \code{sign}: \code{signature(x = "AcDcLcDistribution")}:  exact image distribution of \code{sign(x)}.
      \item \code{sqrt}: \code{signature(x = "AcDcLcDistribution")}:  exact image distribution of \code{sqrt(x)}.
      \item \code{log}: \code{signature(x = "UnivarLebDecDistribution")}:  (with optional further argument \code{base}, defaulting to \code{exp(1)}) exact image distribution of \code{log(x)}.
      \item \code{log10}: \code{signature(x = "UnivarLebDecDistribution")}:  exact image distribution of \code{log10(x)}.
      \item \code{sqrt}: \code{signature(x = "UnivarLebDecDistribution")}:  exact 
          image distribution of \code{sqrt(x)}.
      \item \code{sqrt}: \code{signature(x = "AcDcLcDistribution")}:  exact image distribution of \code{sqrt(x)}.
    }}
    \item{-}{\code{signature(e1 = "UnivarLebDecDistribution")}: application of `-' to this distribution}
    \item{*}{\code{signature(e1 = "UnivarLebDecDistribution", e2 = "numeric")}: multiplication of this distribution
    by an object of class `numeric'}
    \item{/}{\code{signature(e1 = "UnivarLebDecDistribution", e2 = "numeric")}: division of this distribution
    by an object of class `numeric'}
    \item{+}{\code{signature(e1 = "UnivarLebDecDistribution", e2 = "numeric")}: addition of this distribution
    to an object of class `numeric'}
    \item{-}{\code{signature(e1 = "UnivarLebDecDistribution", e2 = "numeric")}: subtraction of an object of class `numeric'
    from this distribution }
    \item{*}{\code{signature(e1 = "numeric", e2 = "UnivarLebDecDistribution")}: multiplication of this distribution
    by an object of class `numeric'}
    \item{+}{\code{signature(e1 = "numeric", e2 = "UnivarLebDecDistribution")}: addition of this distribution
    to an object of class `numeric'}
    \item{-}{\code{signature(e1 = "numeric", e2 = "UnivarLebDecDistribution")}: subtraction of this distribution
    from an object of class `numeric'}
    \item{+}{\code{signature(e1 = "UnivarLebDecDistribution", e2 = "UnivarLebDecDistribution")}: Convolution of two Lebesgue
    decomposed distributions. Result is again of class \code{"UnivarLebDecDistribution"}, but if option
    \code{getdistrOption("withSimplify")} is \code{TRUE} it is piped through a call to \code{\link{simplifyD}},
    hence may also be of class \code{AbscontDistribution} or \code{DiscreteDistribution}}.
    \item{-}{\code{signature(e1 = "UnivarLebDecDistribution", e2 = "UnivarLebDecDistribution")}: Convolution of two Lebesgue
    decomposed distributions. The same applies as for the preceding item.}
  }
}
\section{Internal subclass "AffLinUnivarLebDecDistribution"}{
To enhance accuracy of several functionals on distributions,
  mainly from package \pkg{distrEx},  
  there is an internally used (but exported) subclass 
  \code{"AffLinUnivarLebDecDistribution"} which has extra slots 
  \code{a}, \code{b} (both of class \code{"numeric"}),  and \code{X0} 
  (of class \code{"UnivarLebDecDistribution"}), to capture the fact 
  that the object has the same distribution as \code{a * X0 + b}. This is 
  the class of the return value of methods 
  \describe{
    \item{-}{\code{signature(e1 = "UnivarLebDecDistribution")}}
    \item{*}{\code{signature(e1 = "UnivarLebDecDistribution", e2 = "numeric")}}
    \item{/}{\code{signature(e1 = "UnivarLebDecDistribution", e2 = "numeric")}}
    \item{+}{\code{signature(e1 = "UnivarLebDecDistribution", e2 = "numeric")}}
    \item{-}{\code{signature(e1 = "UnivarLebDecDistribution", e2 = "numeric")}}
    \item{*}{\code{signature(e1 = "numeric", e2 = "UnivarLebDecDistribution")}}
    \item{+}{\code{signature(e1 = "numeric", e2 = "UnivarLebDecDistribution")}}
    \item{-}{\code{signature(e1 = "numeric", e2 = "UnivarLebDecDistribution")}}
    \item{-}{\code{signature(e1 = "AffLinUnivarLebDecDistribution")}}
    \item{*}{\code{signature(e1 = "AffLinUnivarLebDecDistribution", e2 = "numeric")}}
    \item{/}{\code{signature(e1 = "AffLinUnivarLebDecDistribution", e2 = "numeric")}}
    \item{+}{\code{signature(e1 = "AffLinUnivarLebDecDistribution", e2 = "numeric")}}
    \item{-}{\code{signature(e1 = "AffLinUnivarLebDecDistribution", e2 = "numeric")}}
    \item{*}{\code{signature(e1 = "numeric", e2 = "AffLinUnivarLebDecDistribution")}}
    \item{+}{\code{signature(e1 = "numeric", e2 = "AffLinUnivarLebDecDistribution")}}
    \item{-}{\code{signature(e1 = "numeric", e2 = "AffLinUnivarLebDecDistribution")}}
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
in particular methods for \code{"*"}, \code{"/"}, 
\code{"^"} (see \link{operators-methods}) and methods
\code{\link{Minimum}}, \code{Maximum}, \code{\link{Truncate}}, and
 \code{\link{Huberize}}, and \code{\link{convpow}} are defined for this 
 class union.   
}
\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}
  }

\seealso{
\code{\link{Parameter-class}}
\code{\link{UnivarMixingDistribution-class}}
\code{\link{DiscreteDistribution-class}}
\code{\link{AbscontDistribution-class}}
\code{\link{simplifyD}}
\code{\link{flat.LCD}}
}
\examples{
wg <- flat.mix(UnivarMixingDistribution(Unif(0,1),Unif(4,5),
               withSimplify=FALSE))
myLC <- UnivarLebDecDistribution(discretePart=Binom(3,.3), acPart = wg,
          discreteWeight=.2)
myLC
p(myLC)(0.3)
r(myLC)(30)
q(myLC)(0.9)
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
acPart(myLC)
plot(myLC)
d.discrete(myLC)(2)
p.ac(myLC)(0)
acWeight(myLC)
plot(acPart(myLC))
plot(discretePart(myLC))
gaps(myLC)
support(myLC)
plot(as(Norm(),"UnivarLebDecDistribution"))
}
\keyword{distribution}
\concept{Lebesgue decomposed distribution}
\concept{absolutely continuous distribution}
\concept{discrete distribution}
\concept{S4 distribution class}
