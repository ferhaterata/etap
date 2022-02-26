\name{ChisqParameter-class} 
\docType{class}
\alias{ChisqParameter-class}
\alias{initialize,ChisqParameter-method}

\title{Class "ChisqParameter"}
\description{ The parameter of a chi-squared distribution, used by Chisq-class}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("ChisqParameter", ncp, df)}.
Usually an object of this class is not needed on its own, it is generated automatically when an object of the class Chisq
is instantiated. 
}
\section{Slots}{
  \describe{
    \item{\code{ncp}}{Object of class \code{"numeric"}: the ncp of a chi-squared distribution }
    \item{\code{df}}{Object of class \code{"numeric"}: the df of a chi-squared distribution }
    \item{\code{name}}{Object of class \code{"character"}: a name / comment for the parameters }
  }
}
\section{Extends}{
Class \code{"Parameter"}, directly.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "ChisqParameter")}: initialize method }
    \item{df}{\code{signature(object = "ChisqParameter")}: returns the slot \code{df} of the parameter of the distribution }
    \item{df<-}{\code{signature(object = "ChisqParameter")}: modifies the slot \code{df} of the parameter of the distribution }
    \item{ncp}{\code{signature(object = "ChisqParameter")}: returns the slot \code{ncp} of the parameter of the distribution }
    \item{ncp<-}{\code{signature(object = "ChisqParameter")}: modifies the slot \code{ncp} of the parameter of the distribution }
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
  }


\seealso{
\code{\link{Chisq-class}}
\code{\link{Parameter-class}}
}

\examples{
W <- new("ChisqParameter",df=1,ncp=1)
ncp(W) # ncp of this distribution is 1.
ncp(W) <- 2 # ncp of this distribution is now 2.
}
\keyword{distribution}
\concept{parameter}
\concept{Chi square distribution}
\concept{S4 parameter class}
