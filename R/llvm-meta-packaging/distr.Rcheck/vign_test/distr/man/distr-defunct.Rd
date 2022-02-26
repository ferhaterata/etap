\name{distr-defunct}
\alias{distr-defunct}
\alias{GeomParameter-class}
\alias{initialize,GeomParameter-method}

\title{Class "GeomParameter"}
\description{ The parameter of a geometric distribution, used by Geom-class}
\section{Objects from the Class}{
Objects were created by calls of the form \code{new("GeomParameter", prob)}.
Usually an object of this class was not needed on its own, it was generated
automatically when an object of the class Geom
is instantiated.
}
\section{Slots}{
  \describe{
    \item{\code{prob}}{Object of class \code{"numeric"}: the probability of a
                        geometric distribution }
    \item{\code{name}}{Object of class \code{"character"}:
                        a name / comment for the parameters }
  }
}

\section{Extends}{
Class \code{"Parameter"}, directly.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "GeomParameter")}:
                       initialize method }
    \item{prob}{\code{signature(object = "GeomParameter")}:
                 returns the slot \code{prob} of the parameter of the
                 distribution }
    \item{prob<-}{\code{signature(object = "GeomParameter")}:
                  modifies the slot \code{prob} of the parameter of the
                  distribution }
  }
}

\section{Defunct}{
The use of class \code{GeomParameter} is defunct as of version 2.8.0;
it is to be replaced by a corresponding use
of class \code{NbinomParameter} with slot \code{size = 1} which may be
generated, e.g. by
\code{new("NbinomParameter", prob, size = 1,
           name = "Parameter of a Geometric distribution")}
}

\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}
  }

\seealso{
  \code{\link{Defunct}}
}
\keyword{misc}
