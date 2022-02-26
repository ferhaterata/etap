\name{GammaParameter-class}
\docType{class}
\alias{GammaParameter-class}
\alias{initialize,GammaParameter-method} 

\title{Class "GammaParameter"}
\description{ The parameter of a gamma distribution, used by \code{Gammad}-class}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("GammaParameter", shape, scale)}.
Usually an object of this class is not needed on its own, it is generated automatically when an object of the class \code{Gammad}
is instantiated. 
}
\section{Slots}{
  \describe{
    \item{\code{shape}}{Object of class \code{"numeric"}: the shape of a Gamma distribution }
    \item{\code{scale}}{Object of class \code{"numeric"}: the scale of a Gamma distribution }
    \item{\code{name}}{Object of class \code{"character"}: a name / comment for the parameters }
  }
}
\section{Extends}{
Class \code{"Parameter"}, directly.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "GammaParameter")}: initialize method }
    \item{scale}{\code{signature(object = "GammaParameter")}: returns the slot \code{scale} of a parameter of a Gamma distribution }
    \item{scale<-}{\code{signature(object = "GammaParameter")}: modifies the slot \code{scale} of a parameter of a Gamma
    distribution }
    \item{shape}{\code{signature(object = "GammaParameter")}: returns the slot \code{shape} of a parameter of a Gamma distribution }
    \item{shape<-}{\code{signature(object = "GammaParameter")}: modifies the slot \code{shape} of a parameter of a Gamma
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
\code{\link{Gammad-class}}
\code{\link{Parameter-class}}
}

\examples{
W <- new("GammaParameter",scale=1,shape=1)
shape(W) # shape of this distribution is 1.
shape(W) <- 2 # shape of this distribution is now 2.
}
\keyword{distribution}
\concept{parameter}
\concept{Gamma distribution}
\concept{S4 parameter class}
