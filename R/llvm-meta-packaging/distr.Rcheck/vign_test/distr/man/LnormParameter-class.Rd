\name{LnormParameter-class} 
\docType{class}
\alias{LnormParameter-class}
\alias{initialize,LnormParameter-method}

\title{Class "LnormParameter"}
\description{ The parameter of a log normal distribution, used by Lnorm-class}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("LnormParameter", meanlog, sdlog)}.
Usually an object of this class is not needed on its own, it is generated automatically when an object of the class Lnorm
is instantiated. 
}
\section{Slots}{
  \describe{
    \item{\code{meanlog}}{Object of class \code{"numeric"}: the mean of a log normal distribution }
    \item{\code{sdlog}}{Object of class \code{"numeric"}: the sd of a log normal distribution }
    \item{\code{name}}{Object of class \code{"character"}: a name / comment for the parameters }
  }
}
\section{Extends}{
Class \code{"Parameter"}, directly.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "LnormParameter")}: initialize method }
    \item{sdlog}{\code{signature(object = "LnormParameter")}: returns the slot sdlog of the parameter of the distribution }
    \item{sdlog<-}{\code{signature(object = "LnormParameter")}: modifies the slot sdlog of the parameter of the
    distribution }
    \item{meanlog}{\code{signature(object = "LnormParameter")}: returns the slot meanlog of the parameter of the
    distribution}
    \item{meanlog<-}{\code{signature(object = "LnormParameter")}: modifies the slot meanlog of the parameter of the
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
\code{\link{Lnorm-class}}
\code{\link{Parameter-class}}
}

\examples{
W <- new("LnormParameter",sdlog=1,meanlog=0)
meanlog(W) # meanlog of this distribution is 0.
meanlog(W) <- 2 # meanlog of this distribution is now 2.
}
\keyword{distribution}
\concept{parameter}
\concept{Log-Normal distribution}
\concept{S4 parameter class}
