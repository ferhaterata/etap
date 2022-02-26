\name{TParameter-class} 
\docType{class}
\alias{TParameter-class}
\alias{initialize,TParameter-method}

\title{Class "TParameter"}
\description{ The parameter of a t distribution, used by Td-class}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("TParameter", df, ncp)}.
Usually an object of this class is not needed on its own, it is generated automatically when an object of the class
\code{Td} is instantiated. 
}
\section{Slots}{
  \describe{
    \item{\code{df}}{Object of class \code{"numeric"}: the degrees of freedom of a T distribution }
    \item{\code{ncp}}{Object of class \code{"numeric"}: the noncentrality parameter of a T distribution }
    \item{\code{name}}{Object of class \code{"character"}: a name / comment for the parameters }
  }
}
\section{Extends}{
Class \code{"Parameter"}, directly.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "TParameter")}: initialize method }
    \item{df}{\code{signature(object = "TParameter")}: returns the slot \code{df} of the parameter of the distribution }
    \item{df<-}{\code{signature(object = "TParameter")}: modifies the slot \code{df} of the parameter of the distribution }
    \item{ncp}{\code{signature(object = "TParameter")}: returns the slot \code{ncp} of the parameter of the distribution }
    \item{ncp<-}{\code{signature(object = "TParameter")}: modifies the slot \code{ncp} of the parameter of the distribution }
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}}

\seealso{
\code{\link{Td-class}}
\code{\link{Parameter-class}}
}

\examples{
W <- new("TParameter",df=1, ncp = 0)
df(W) # df of this distribution is 1.
df(W) <- 2 # df of this distribution is now 2.
}
\keyword{distribution}
\concept{parameter}
\concept{T distribution}
\concept{S4 parameter class}
