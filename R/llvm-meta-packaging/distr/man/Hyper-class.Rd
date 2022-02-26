\name{Hyper-class}
\docType{class}
\alias{Hyper-class}
\alias{Hyper}
\alias{initialize,Hyper-method}

\title{Class "Hyper" }
\description{ The hypergeometric distribution is used for sampling \emph{without} 
  replacement. The density of this distribution with parameters
  \code{m}, \code{n} and \code{k} (named \eqn{Np}, \eqn{N-Np}, and
  \eqn{n}, respectively in the reference below) is given by
  \deqn{
    p(x) = \left. {m \choose x}{n \choose k-x} \right/ {m+n \choose k}%
  }{p(x) =      choose(m, x) choose(n, k-x) / choose(m+n, k)}
  for \eqn{x = 0, \ldots, k}{x = 0, ..., k}.
  C.f. \code{\link[stats:Hypergeometric]{rhyper}} 
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{Hyper(m, n, k)}.
This object is a hypergeometric distribution. 
}
\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Naturals"}: The space of the image of this
     distribution has got dimension 1 and the name "Natural Space". }
    \item{\code{param}}{Object of class \code{"HyperParameter"}: the parameter of this distribution (\code{m}, \code{n}, \code{k}),
     declared at its instantiation }
    \item{\code{r}}{Object of class \code{"function"}: generates random numbers (calls function \code{rhyper}) }
    \item{\code{d}}{Object of class \code{"function"}: density function (calls function \code{dhyper}) }
    \item{\code{p}}{Object of class \code{"function"}: cumulative function (calls function \code{phyper}) }
    \item{\code{q}}{Object of class \code{"function"}: inverse of the cumulative function (calls function \code{qhyper}).
    The \eqn{\alpha}{alpha}-quantile is defined as the smallest value \eqn{x} such that 
     \eqn{p(x) \ge \alpha]}{p(x) >= alpha}, where \eqn{p} is the cumulative function. }
    \item{\code{support}:}{Object of class \code{"numeric"}: a (sorted) vector containing the support of the discrete
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
    \item{initialize}{\code{signature(.Object = "Hyper")}: initialize method }
    \item{m}{\code{signature(object = "Hyper")}: returns the slot \code{m} of the parameter of the distribution }
    \item{m<-}{\code{signature(object = "Hyper")}: modifies the slot \code{m} of the parameter of the distribution }
    \item{n}{\code{signature(object = "Hyper")}: returns the slot \code{n} of the parameter of the distribution }
    \item{n<-}{\code{signature(object = "Hyper")}: modifies the slot \code{n} of the parameter of the distribution }
    \item{k}{\code{signature(object = "Hyper")}: returns the slot \code{k} of the parameter of the distribution }
    \item{k<-}{\code{signature(object = "Hyper")}: modifies the slot \code{k} of the parameter of the distribution }
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
  }


\seealso{
\code{\link{HyperParameter-class}}
\code{\link{DiscreteDistribution-class}}
\code{\link{Naturals-class}}
\code{\link[stats:Hypergeometric]{rhyper}}
}
\examples{
H <- Hyper(m=3,n=3,k=3) # H is a hypergeometric distribution with m=3,n=3,k=3.
r(H)(1) # one random number generated from this distribution, e.g. 2
d(H)(1) # Density of this distribution is  0.45 for x=1.
p(H)(1) # Probability that x<1 is 0.5.
q(H)(.1) # x=1 is the smallest value x such that p(H)(x)>=0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
m(H) # m of this distribution is 3.
m(H) <- 2 # m of this distribution is now 2.
}
\keyword{distribution}
\concept{discrete distribution}
\concept{lattice distribution}
\concept{Hypergeometric distribution}
\concept{S4 parameter class}
\concept{generating function}
