\name{BetaParameter-class}
\docType{class}
\alias{BetaParameter-class}
\alias{initialize,BetaParameter-method}
\title{Class "BetaParameter"}
\description{
  The parameter of a beta distribution, used by \code{Beta-class}
}
\section{Objects from the Class}{
  Objects can be created by calls of the form \code{new("BetaParameter", shape1, shape2, ncp)}.
  Usually an object of this class is not needed on its own, it is
  generated   automatically when an object of the class Beta
  is instantiated. 
}
\section{Slots}{
  \describe{
    \item{\code{shape1}}{Object of class \code{"numeric"}: the shape1 of a beta distribution }
    \item{\code{shape2}}{Object of class \code{"numeric"}: the shape2 of a beta distribution }
    \item{\code{ncp}}{Object of class \code{"numeric"}: the noncentrality parameter of a beta distribution }
    \item{\code{name}}{Object of class \code{"character"}: a name / comment for the parameters }
  }
}
\section{Extends}{
Class \code{"Parameter"}, directly.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "BetaParameter")}:
      initialize method}
    \item{shape1}{\code{signature(object = "BetaParameter")}:
      returns the slot shape1 of the parameter of the distribution}
    \item{shape1<-}{\code{signature(object = "BetaParameter")}:
      modifies the slot shape1 of the parameter of the distribution}
    \item{shape2}{\code{signature(object = "BetaParameter")}:
      returns the slot shape2 of the parameter of the distribution}
    \item{shape2<-}{\code{signature(object = "BetaParameter")}:
      modifies the slot shape2 of the parameter of the distribution}
    \item{ncp}{\code{signature(object = "BetaParameter")}: returns the slot \code{ncp} of the parameter of the distribution }
    \item{ncp<-}{\code{signature(object = "BetaParameter")}: modifies the slot \code{ncp} of the parameter of the distribution }
}
}
\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
}
\seealso{
  \code{\link{Beta-class}}
  \code{\link{Parameter-class}}
}
\examples{
W <- new("BetaParameter", shape1 = 1, shape2 = 1, ncp = 0)
shape2(W) # shape2 of this distribution is 1.
shape2(W) <- 2 # shape2 of this distribution is now 2.
}
\keyword{distribution}
\concept{parameter}
\concept{Beta distribution}
\concept{S4 parameter class}
