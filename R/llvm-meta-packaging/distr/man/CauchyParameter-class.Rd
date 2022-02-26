\name{CauchyParameter-class}        
\docType{class}
\alias{CauchyParameter-class}
\alias{initialize,CauchyParameter-method}

\title{Class "CauchyParameter"}
\description{ The parameter of a Cauchy distribution, used by Cauchy-class}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("CauchyParameter", location, scale)}.
Usually an object of this class is not needed on its own, it is generated automatically when an object of the class Cauchy is instantiated. 
}
\section{Slots}{
  \describe{
    \item{\code{location}:}{Object of class \code{"numeric"}: the location of a Cauchy distribution }
    \item{\code{scale}}{Object of class \code{"numeric"}: the scale of a Cauchy distribution }
    \item{\code{name}}{Object of class \code{"character"}: a name / comment for the parameters }
  }
}
\section{Extends}{
Class \code{"Parameter"}, directly.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "CauchyParameter")}: initialize method }
    \item{scale}{\code{signature(object = "CauchyParameter")}: returns the slot \code{scale} of the parameter of the distribution}
    \item{scale<-}{\code{signature(object = "CauchyParameter")}: modifies the slot \code{scale} of the parameter of the
    distribution }
    \item{location}{\code{signature(object = "CauchyParameter")}: returns the slot \code{location} of the parameter of the
    distribution }
    \item{location<-}{\code{signature(object = "CauchyParameter")}: modifies the slot \code{location} of the parameter of the
    distribution }
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
  }


\seealso{
\code{\link{Cauchy-class}}
\code{\link{Parameter-class}}
}

\examples{
W <- new("CauchyParameter",location=1,scale=1)
location(W) # location of this distribution is 1.
location(W) <- 2 # location of this distribution is now 2.
}
\keyword{distribution}
\concept{parameter}
\concept{location scale family}
\concept{Cauchy distribution}
\concept{S4 parameter class}
