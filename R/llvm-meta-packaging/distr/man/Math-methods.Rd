\name{Math-methods}
\docType{methods}
\alias{Math-methods}
\alias{log-methods}
\alias{log10-methods}
\alias{lgamma-methods}
\alias{gamma-methods}
\alias{sign-methods}
\alias{Math,AcDcLcDistribution-method}
\alias{Math,AbscontDistribution-method}
\alias{Math,DiscreteDistribution-method}
\alias{abs,AbscontDistribution-method}
\alias{abs,DiscreteDistribution-method}
\alias{exp,AbscontDistribution-method}
\alias{exp,DiscreteDistribution-method}
\alias{log,AbscontDistribution-method}
\alias{log,DiscreteDistribution-method}
\alias{sign,AbscontDistribution-method}
\alias{sign,DiscreteDistribution-method}
\alias{log10,AbscontDistribution-method}
\alias{log10,DiscreteDistribution-method}
\alias{digamma,AbscontDistribution-method}
\alias{digamma,DiscreteDistribution-method}
\alias{lgamma,AbscontDistribution-method}
\alias{lgamma,DiscreteDistribution-method}
\alias{gamma,AbscontDistribution-method}
\alias{gamma,DiscreteDistribution-method}
\title{ Methods for Functions from group `Math' in Package `distr' }
\description{Math-methods provide automatical generation of image distributions
for random variables transformed by functions from group
\code{\link[methods:S4groupGeneric]{Math}}}
\section{Methods}{\describe{
    \item{Math}{\code{signature(x = "AbscontDistribution")}: application of a
      mathematical function from group \code{\link[methods:S4groupGeneric]{Math}}, e.g.
      \code{sin} or \code{exp}  (including
      \code{log, log10, gamma, lgamma, digamma}), to this
      absolutely continouos distribution}
    \item{Math}{\code{signature(x = "DiscreteDistribution")}: application of a
      mathematical function, e.g. sin or exp  (including
      \code{log, log10, gamma, lgamma, digamma}), to this
      discrete distribution}
    \item{Math}{\code{signature(x = "UnivarLebDecDistribution")}: application of a
      mathematical function from group \code{\link[methods:S4groupGeneric]{Math}}, e.g.
      \code{sin} or \code{exp}  (including
      \code{log, log10, gamma, lgamma}), to this
      Lebesgue decomposed distribution}
    \item{Math}{\code{signature(x = "UnivarLebDecDistribution")}: application of a
      mathematical function from group \code{\link[methods:S4groupGeneric]{Math}}, e.g.
      \code{sin} or \code{exp}  (including
      \code{log, log10, gamma, lgamma}), to this
       distribution of class \code{"AcDcLcDistribution"}}
    \item{abs}{\code{signature(x = "AbscontDistribution")}: application of 
      function \code{abs} to this absolutely continouos distribution; 
      (exactly)}
    \item{abs}{\code{signature(x = "DiscreteDistribution")}: application of 
      function \code{abs} to this discrete distribution; 
      (exactly)}
    \item{sign}{\code{signature(x = "AbscontDistribution")}: application of 
      function \code{abs} to this absolutely continouos distribution; 
      (exactly)}
    \item{sign}{\code{signature(x = "DiscreteDistribution")}: application of 
      function \code{abs} to this discrete continouos distribution; 
      (exactly)}
    \item{exp}{\code{signature(x = "AbscontDistribution")}: application of
      function \code{exp} to this absolutely continouos distribution;
      (exactly)}
    \item{exp}{\code{signature(x = "DiscreteDistribution")}: application of
      function \code{exp} to this discrete distribution;
      (exactly)}
    \item{log}{\code{signature(x = "AbscontDistribution")}: application of
      function \code{log} to this absolutely continouos distribution;
      (exactly for R-version \code{>2.5.1})}
    \item{log}{\code{signature(x = "DiscreteDistribution")}: application of
      function \code{log} to this discrete distribution;
      (exactly for R-version \code{>2.5.1})}
}}
\keyword{arith}
\keyword{distribution}
\concept{image distribution}
