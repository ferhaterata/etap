\name{Distribution-class}
\docType{class}
\alias{Distribution-class}
\alias{.logExact}
\alias{.logExact-methods}
\alias{.logExact,Distribution-method}
\alias{.lowerExact}
\alias{.lowerExact-methods}
\alias{.lowerExact,Distribution-method}
\alias{Symmetry}
\alias{Symmetry-methods}
\alias{Symmetry,Distribution-method}

\title{Class "Distribution"}
\description{ The \code{Distribution-class} is the mother-class of 
class \code{UnivariateDistribution}.}
\section{Objects from the Class}{
  Objects can be created by calls of the form \code{new("Distribution")}.
}

\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"rSpace"}: the space of the image }
    \item{\code{param}}{Object of class \code{"OptionalParameter"}: the parameter }
    \item{\code{r}}{Object of class \code{"function"}: generates random numbers}
    \item{\code{d}}{Object of class \code{"OptionalFunction"}: density function}
    \item{\code{p}}{Object of class \code{"OptionalFunction"}: cumulative 
    distribution function}
    \item{\code{q}}{Object of class \code{"OptionalFunction"}: quantile function}
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

\section{Methods}{
  \describe{
    \item{img}{\code{signature(object = "Distribution")}: returns the space of 
                 the image}
    \item{param}{\code{signature(object = "Distribution")}: returns the 
                 parameter}
    \item{r}{\code{signature(object = "Distribution")}: returns the random 
              number generator }
    \item{d}{\code{signature(object = "Distribution")}: returns the density 
              function }
    \item{p}{\code{signature(object = "Distribution")}: returns the cumulative 
              distribution function }
    \item{q}{\code{signature(object = "Distribution")}: returns the quantile 
                function}
    \item{.logExact}{\code{signature(object = "Distribution")}: returns slot 
      \code{.logExact} if existing; else tries to convert the object to a newer 
      version of its class by \code{\link{conv2NewVersion}} and
      returns the corresponding slot of the converted object.}
    \item{.lowerExact}{\code{signature(object = "Distribution")}: returns slot 
       \code{.lowerExact} if existing; else tries to convert the object to a 
       newer version of its class by \code{\link{conv2NewVersion}} and
     returns the corresponding slot of the converted object.}
    \item{Symmetry:}{returns slot \code{Symmetry} if existing; else
    tries to convert the object to a 
       newer version of its class by \code{\link{conv2NewVersion}} and
     returns the corresponding slot of the converted object.}
  }
}


\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}}


\seealso{
\code{\link{UnivariateDistribution-class}}
\code{\link{Parameter-class}}

}
\keyword{distribution}
\concept{conditional distribution}
\concept{multivariate distribution}
\concept{univariate distribution}
\concept{discrete distribution}
\concept{lattice distribution}
\concept{absolutely continuous distribution}
\concept{S4 distribution class}
