\name{LogisParameter-class} 
\docType{class}
\alias{LogisParameter-class}
\alias{initialize,LogisParameter-method}

\title{Class "LogisParameter"}
\description{ The parameter of a logistic distribution, used by \code{Logis}-class}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("LogisParameter", scale, location)}.
Usually an object of this class is not needed on its own, it is generated automatically when an object of the class 
\code{Logis} is instantiated. 
}
\section{Slots}{
  \describe{
    \item{\code{scale}}{Object of class \code{"numeric"}: the scale of a logistic distribution }
    \item{\code{location}}{Object of class \code{"numeric"}: the location of a logistic distribution }
    \item{\code{name}}{Object of class \code{"character"}: a name / comment for the parameters }
  }
}
\section{Extends}{
Class \code{"Parameter"}, directly.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "LogisParameter")}: initialize method }
    \item{location}{\code{signature(object = "LogisParameter")}: returns the slot \code{location} of the parameter of the
    distribution }
    \item{location<-}{\code{signature(object = "LogisParameter")}: modifies the slot \code{location} of the parameter of the
    distribution }
    \item{scale}{\code{signature(object = "LogisParameter")}: returns the slot \code{scale} of the parameter of the distribution }
    \item{scale<-}{\code{signature(object = "LogisParameter")}: modifies the slot \code{scale} of the parameter of the
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
\code{\link{Logis-class}}
\code{\link{Parameter-class}}
}

\examples{
W <- new("LogisParameter",location=0,scale=1)
scale(W) # scale of this distribution is 1.
scale(W) <- 2 # scale of this distribution is now 2.
}
\keyword{distribution}
\concept{parameter}
\concept{Logistic distribution}
\concept{S4 parameter class}
\concept{location scale family}
