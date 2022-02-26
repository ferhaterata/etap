\name{NbinomParameter-class} 
\docType{class}
\alias{NbinomParameter-class}
\alias{initialize,NbinomParameter-method}

\title{Class "NbinomParameter"}
\description{ The parameter of a negative binomial distribution, used by Nbinom-class}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("NbinomParameter", prob, size)}.
Usually an object of this class is not needed on its own, it is generated automatically when an object of the class Nbinom
is prepared. 
}
\section{Slots}{
  \describe{
    \item{\code{prob}}{Object of class \code{"numeric"}: the probability of a negative binomial distribution }
    \item{\code{size}}{Object of class \code{"numeric"}: the size of a negative binomial distribution }
    \item{\code{name}}{Object of class \code{"character"}: a name / comment for the parameters }
  }
}
\section{Extends}{
Class \code{"Parameter"}, directly.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "NbinomParameter")}: initialize method }
    \item{prob}{\code{signature(object = "NbinomParameter")}: returns the slot \code{prob} of the parameter of the
    distribution }
    \item{prob<-}{\code{signature(object = "NbinomParameter")}: modifies the slot \code{prob} of the parameter of the
    distribution }
    \item{size}{\code{signature(object = "NbinomParameter")}: returns the slot \code{size} of the parameter of the distribution }
    \item{size<-}{\code{signature(object = "NbinomParameter")}: modifies the slot \code{size} of the parameter of the
    distribution }
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}}

\seealso{
\code{\link{Nbinom-class}}
\code{\link{Parameter-class}}
}

\examples{
W <- new("NbinomParameter",prob=0.5,size=1)
size(W) # size of this distribution is 1.
size(W) <- 2 # size of this distribution is now 2.
}
\keyword{distribution}
\concept{parameter}
\concept{Negative Binomial distribution}
\concept{S4 parameter class}
