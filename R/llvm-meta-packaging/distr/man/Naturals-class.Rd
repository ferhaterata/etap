\name{Naturals-class}
\docType{class}
\alias{Naturals}
\alias{Naturals-class}
\alias{initialize,Naturals-method}

\title{Class "Naturals" }
\description{ The distribution-classes contain a slot where the sample space is stored. Typically, discrete random
variables take naturals as values. }
\section{Objects from the Class}{
Objects could theoretically be created by calls of the form \code{new("Naturals", dimension, name)}.
Usually an object of this class is not needed on its own. It is generated automatically when a univariate discrete
distribution is instantiated. 
}
\usage{Naturals()}

\section{Slots}{
  \describe{
    \item{\code{dimension}}{Object of class \code{"character"}: the dimension of the space, by default = 1 }
    \item{\code{name}}{Object of class \code{"character"}: the name of the space, by default = "Natural Space"}
  }
}
\section{Extends}{
Class \code{"Reals"}, directly.\cr
Class \code{"EuclideanSpace"}, by class \code{"Reals"}.\cr
Class \code{"rSpace"}, by class \code{"Reals"}.
}

\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "Naturals")}: initialize method }
    \item{liesIn}{\code{signature(object = "Naturals", x = "numeric")}: Does a particular vector only contain naturals? }
}
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}}


\seealso{
\code{\link{Reals-class}}
\code{\link{DiscreteDistribution-class}}
}

\examples{
N <- Naturals()
liesIn(N,1) # TRUE
liesIn(N,c(0,1)) # FALSE
liesIn(N,0.1) # FALSE
}

\concept{naturals}
\concept{space}
\concept{set}
\concept{S4 space class}
\keyword{distribution}
