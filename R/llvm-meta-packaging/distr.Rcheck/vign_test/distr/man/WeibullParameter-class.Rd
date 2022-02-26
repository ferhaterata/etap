\name{WeibullParameter-class} 
\docType{class}
\alias{WeibullParameter-class}
\alias{initialize,WeibullParameter-method}

\title{Class "WeibullParameter"}
\description{ The parameter of a Weibull distribution, used by \code{Weibull}-class}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("WeibullParameter", shape, scale)}.
Usually an object of this class is not needed on its own, it is generated automatically when an object of the class \code{Weibull}
is instantiated. 
}
\section{Slots}{
  \describe{
    \item{\code{shape}}{Object of class \code{"numeric"}: the shape of a Weibull distribution }
    \item{\code{scale}}{Object of class \code{"numeric"}: the scale of a Weibull distribution }
    \item{\code{name}}{Object of class \code{"character"}: a name / comment for the parameters }
  }
}
\section{Extends}{
Class \code{"Parameter"}, directly.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "WeibullParameter")}: initialize method }
    \item{scale}{\code{signature(object = "WeibullParameter")}: returns the slot \code{scale} of a parameter of a Weibull
    distribution }
    \item{scale<-}{\code{signature(object = "WeibullParameter")}: modifies the slot \code{scale} of a parameter of a Weibull
    distribution }
    \item{shape}{\code{signature(object = "WeibullParameter")}: returns the slot \code{shape} of a parameter of a Weibull
    distribution }
    \item{shape<-}{\code{signature(object = "WeibullParameter")}: modifies the slot \code{shape} of a parameter of a Weibull
    distribution }
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}}

\seealso{
\code{\link{Weibull-class}}
\code{\link{Parameter-class}}
}

\examples{
W <- new("WeibullParameter",shape=1,scale=1)
shape(W) # shape of this distribution is 1.
shape(W) <- 2 # shape of this distribution is now 2.
}
\keyword{distribution}
\concept{parameter}
\concept{Weibull distribution}
\concept{S4 parameter class}
