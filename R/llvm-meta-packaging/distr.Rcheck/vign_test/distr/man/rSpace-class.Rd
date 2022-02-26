\name{rSpace-class}
\docType{class}
\alias{rSpace-class}

\title{Class "rSpace" }
\description{ The distribution-classes contain a slot where the sample space is stored. Typically, discrete random variables
take naturals as values. rSpace is the mother-class of the class EuclideanSpace. }
\section{Objects from the Class}{A virtual Class: No objects may be created from it.}
\section{Slots}{
  \describe{
    \item{\code{name}}{Object of class \code{"character"}: the name of the space }
  }
}
\section{Methods}{
  \describe{
    \item{name}{\code{signature(object = "rSpace")}: returns the name of the space }
    \item{name<-}{\code{signature(object = "rSpace")}: changes the name of the space }
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}}


\seealso{
\code{\link{Lattice-class}}
\code{\link{Naturals-class}}
\code{\link{EuclideanSpace-class}}
\code{\link{Distribution-class}}
}
\concept{space}
\concept{set}
\concept{S4 space class}
\keyword{distribution}
