\name{FParameter-class}
\docType{class}
\alias{FParameter-class}
\alias{initialize,FParameter-method}
\title{Class "FParameter"}
\description{ The parameter of a F distribution, used by Fd-class}
\section{Objects from the Class}{
  Objects can be created by calls of the form \code{new("FParameter", df1, df2, ncp)}.
  Usually an object of this class is not needed on its own, it is
  generated automatically when an object of the class Fd is instantiated. 
}
\section{Slots}{
  \describe{
    \item{\code{df1}}{Object of class \code{"numeric"}: the degrees of freedom of the nominator of an F distribution}
    \item{\code{df2}}{Object of class \code{"numeric"}: the degrees of freedom of the denominator of an F distribution}
    \item{\code{ncp}}{Object of class \code{"numeric"}: the noncentrality parameter of an F distribution }
    \item{\code{name}}{Object of class \code{"character"}: a name / comment for the parameters}
  }
}
\section{Extends}{
Class \code{"Parameter"}, directly.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "FParameter")}: initialize method }
    \item{df1}{\code{signature(object = "FParameter")}:
      returns the slot df1 of the parameter of the distribution}
    \item{df1<-}{\code{signature(object = "FParameter")}:
      modifies the slot df1 of the parameter of the distribution}
    \item{df2}{\code{signature(object = "FParameter")}:
      returns the slot df2 of the parameter of the distribution}
    \item{df2<-}{\code{signature(object = "FParameter")}:
      modifies the slot df2 of the parameter of the distribution}
    \item{ncp}{\code{signature(object = "FParameter")}: 
      returns the slot \code{ncp} of the parameter of the distribution }
    \item{ncp<-}{\code{signature(object = "FParameter")}: 
      modifies the slot \code{ncp} of the parameter of the distribution }
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
}
\seealso{
\code{\link{Fd-class}}
\code{\link{Parameter-class}}
}
\examples{
W <- new("FParameter", df1 = 1, df2 = 1, ncp = 0)
df2(W) # df2 of this distribution is 1.
df2(W) <- 2 # df2 of this distribution is now 2.
}
\keyword{distribution}
\concept{parameter}
\concept{F distribution}
\concept{S4 parameter class}
