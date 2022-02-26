\name{Parameter-class}
\docType{class}
\alias{Parameter-class}
\title{Class "Parameter"}
\description{
  Parameter is the mother-class of all Parameter classes.
}
\section{Objects from the Class}{
  Objects can be created by calls of the form \code{new("Parameter")}.
}
\section{Slots}{
  \describe{
    \item{\code{name}}{Object of class \code{"character"}:
      a name / comment for the parameters}
  }
}
\section{Methods}{
  \describe{
    \item{name}{\code{signature(object = "Parameter")}:
      returns the name of the parameter}
    \item{name<-}{\code{signature(object = "Parameter")}:
      modifies the name of the parameter}
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
  }

\seealso{
\code{\link{Distribution-class}}
}
\keyword{methods}
\keyword{distribution}
\concept{parameter}
\concept{S4 parameter class}
