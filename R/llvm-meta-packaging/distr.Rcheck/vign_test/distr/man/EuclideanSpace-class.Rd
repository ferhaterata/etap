\name{EuclideanSpace-class}
\docType{class}
\alias{EuclideanSpace}
\alias{EuclideanSpace-class}
\alias{initialize,EuclideanSpace-method}

\title{Class "EuclideanSpace" }
\description{ The distribution-classes contain a slot where the sample space is stored. One typical sample space is the
Euclidean Space in dimension k. }
\section{Objects from the Class}{
Objects could theoretically be created by calls of the form \code{new("EuclideanSpace", dimension, name)}.
Usually an object of this class is not needed on its own. \code{EuclideanSpace} is the mother-class of the class 
\code{Reals}, which is generated automatically when a univariate absolutly continuous distribution is instantiated. 
}
\section{Slots}{
  \describe{
    \item{\code{dimension}}{Object of class \code{"numeric"}: the dimension of the space, by default = 1 }
    \item{\code{name}}{Object of class \code{"character"}: the name of the space, by default = "Euclidean Space"}
  }
}
\section{Extends}{
Class \code{"rSpace"}, directly.
}

\usage{
EuclideanSpace(dimension = 1)
}
\arguments{
  \item{dimension}{ positive integer: dimension of 
  the Euclidean space (default \code{=1})}
}

\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "EuclideanSpace")}: initialize method }
    \item{liesIn}{\code{signature(object = "EuclideanSpace", x = "numeric")}: Does a particular vector lie in this space or
    not?
 }
    \item{dimension}{\code{signature(object = "EuclideanSpace")}: returns the dimension of the space }
    \item{dimension<-}{\code{signature(object = "EuclideanSpace")}: modifies the dimension of the space }
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
  }


\seealso{
\code{\link{rSpace-class}}
\code{\link{Reals-class}}
\code{\link{Distribution-class}}
\code{\link{liesIn-methods}}
}

\examples{
E <- EuclideanSpace(dimension = 2) 
dimension(E) # The dimension of this space is 2.
dimension(E) <- 3 # The dimension of this space is now 3.
liesIn(E,c(0,0,0)) # TRUE
liesIn(E,c(0,0)) # FALSE
}


\concept{space}
\concept{set}
\concept{S4 space class}
\keyword{distribution}
