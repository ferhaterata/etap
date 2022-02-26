\name{UnifParameter-class} 
\docType{class}
\alias{UnifParameter-class}
\alias{initialize,UnifParameter-method}

\title{Class "UnifParameter"}
\description{ The parameter of a uniform distribution, used by Unif-class}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("UnifParameter", Max, Min)}.
Usually an object of this class is not needed on its own, it is generated automatically when an object of the class 
\code{Unif} is instantiated. 
}
\section{Slots}{
  \describe{
    \item{\code{Max}}{Object of class \code{"numeric"}: the Max of a uniform distribution }
    \item{\code{Min}}{Object of class \code{"numeric"}: the Min of a uniform distribution }
    \item{\code{name}}{Object of class \code{"character"}: a name / comment for the parameters }
  }
}
\section{Extends}{
Class \code{"Parameter"}, directly.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "UnifParameter")}: initialize method }
    \item{Min}{\code{signature(object = "UnifParameter")}: returns the slot \code{Min} of the parameter of the distribution }
    \item{Min<-}{\code{signature(object = "UnifParameter")}: modifies the slot \code{Min} of the parameter of the distribution }
    \item{Max}{\code{signature(object = "UnifParameter")}: returns the slot \code{Max} of the parameter of the distribution }
    \item{Max<-}{\code{signature(object = "UnifParameter")}: modifies the slot \code{Max} of the parameter of the distribution }
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}}

\seealso{
\code{\link{Unif-class}}
\code{\link{Parameter-class}}
}

\examples{
W <- new("UnifParameter",Min=0,Max=1)
Max(W) # Max of this distribution is 1.
Max(W) <- 2 # Max of this distribution is now 2.
}
\keyword{distribution}
\concept{parameter}
\concept{Uniform distribution}
\concept{S4 parameter class}
