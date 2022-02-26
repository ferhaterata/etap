\name{Reals-class}
\docType{class}
\alias{Reals}
\alias{Reals-class}
\alias{initialize,Reals-method}

\title{Class "Reals" }
\description{ Particular case of a one-dimensional Euclidean Space }
\section{Objects from the Class}{
Objects could theoretically be created by calls of the form \code{new("Reals", dimension, name)}.
Usually an object of this class is not needed on its own. It is generated automatically when a univariate absolutly
continuous distribution is instantiated. 
}
\section{Slots}{
  \describe{
    \item{\code{dimension}}{Object of class \code{"character"}: the dimension of the space, by default = 1 }
    \item{\code{name}}{Object of class \code{"character"}: the name of the space, by default = "Real Space"}
  }
}
\usage{Reals()}

\section{Extends}{
Class \code{"EuclideanSpace"}, directly.\cr
Class \code{"rSpace"}, by class \code{"EuclideanSpace"}.
}

\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "Reals")}: initialize method }
}
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
  }


\seealso{
\code{\link{EuclideanSpace-class}}
\code{\link{Naturals-class}}
\code{\link{AbscontDistribution-class}}
}

\examples{
R <- Reals()
liesIn(R,c(0,0)) # FALSE
}


\keyword{distribution}
\concept{space}
\concept{set}
\concept{S4 space class}
