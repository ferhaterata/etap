\name{PoisParameter-class}
\docType{class}
\alias{PoisParameter-class}
\alias{initialize,PoisParameter-method}
\title{Class "PoisParameter"}
\description{ The parameter of a Poisson distribution, used by Pois-class}
\section{Objects from the Class}{
  Objects can be created by calls of the form \code{new("PoisParameter", lambda)}.
  Usually an object of this class is not needed on its own, it is
  generated automatically when an object of the class Pois is prepared. 
}
\section{Slots}{
  \describe{
    \item{\code{lambda}}{Object of class \code{"numeric"}:
      the lambda of a Poisson distribution}
    \item{\code{name}}{Object of class \code{"character"}:
      a name / comment for the parameters}
  }
}
\section{Extends}{
Class \code{"Parameter"}, directly.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "PoisParameter")}:
      initialize method }
    \item{lambda}{\code{signature(object = "PoisParameter")}:
      returns the slot lambda of the parameter of the distribution}
    \item{lambda<-}{\code{signature(object = "PoisParameter")}:
      modifies the slot lambda of the parameter of the distribution}
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
  }

\seealso{
\code{\link{Pois-class}}
\code{\link{Parameter-class}}
}
\examples{
W <- new("PoisParameter",lambda = 1)
lambda(W) # lambda of this distribution is 1.
lambda(W) <- 2 # lambda of this distribution is now 2.
}
\keyword{distribution}
\concept{parameter}
\concept{Poisson distribution}
\concept{S4 parameter class}
