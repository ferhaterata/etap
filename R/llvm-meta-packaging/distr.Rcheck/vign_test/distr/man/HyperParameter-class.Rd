\name{HyperParameter-class} 
\docType{class}
\alias{HyperParameter-class}
\alias{initialize,HyperParameter-method}

\title{Class "HyperParameter"}
\description{ The parameter of a hypergeometric distribution, used by \code{Hyper}-class}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("HyperParameter", k, m, n)}.
Usually an object of this class is not needed on its own, it is generated automatically when an object of the class \code{Hyper}
is instantiated. 
}
\section{Slots}{
  \describe{
    \item{\code{k}}{Object of class \code{"numeric"}: k of a hypergeometric distribution }
    \item{\code{m}}{Object of class \code{"numeric"}: m of a hypergeometric distribution }
    \item{\code{n}}{Object of class \code{"numeric"}: n of a hypergeometric distribution }
    \item{\code{name}}{Object of class \code{"character"}: a name / comment for the parameters }
  }
}
\section{Extends}{
Class \code{"Parameter"}, directly.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "HyperParameter")}: initialize method }
    \item{k}{\code{signature(object = "HyperParameter")}: returns the slot \code{k} of the parameter of the distribution }
    \item{k<-}{\code{signature(object = "HyperParameter")}: modifies the slot \code{k} of the parameter of the distribution }
    \item{m}{\code{signature(object = "HyperParameter")}: returns the slot \code{m} of the parameter of the distribution }
    \item{m<-}{\code{signature(object = "HyperParameter")}: modifies the slot \code{m} of the parameter of the distribution }
    \item{n}{\code{signature(object = "HyperParameter")}: returns the slot \code{n} of the parameter of the distribution }
    \item{n<-}{\code{signature(object = "HyperParameter")}: modifies the slot \code{n} of the parameter of the distribution }
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
  }


\seealso{
\code{\link{Hyper-class}}
\code{\link{Parameter-class}}
}

\examples{
W <- new("HyperParameter",k=3, m=3, n=3)
m(W) # m of this distribution is 3.
m(W) <- 2 # m of this distribution is now 2.
}
\keyword{distribution}
\concept{parameter}
\concept{Hypergeometric distribution}
\concept{S4 parameter class}
