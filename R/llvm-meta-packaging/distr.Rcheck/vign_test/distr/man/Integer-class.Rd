\name{Integer-class}
\docType{class}
\alias{Integer-class}
\alias{coerce,numeric,Integer-method}

\title{Internal Class "Integer"}
\description{For the ease of method dispatch, there is an internal
S4 class \code{Integer}, which is a subclass of \code{numeric} and has a 
straightforward validity method.}
\section{Objects from the Class}{
new("Integer",
}
\section{Slots}{
\describe{
    \item{\code{.Data}}{Object of class \code{"numeric"}}
  }
}
\section{Extends}{
Class \code{"\linkS4class{numeric}"}, from data part.
Class \code{"\linkS4class{vector}"}, by class "numeric", distance 2.
}
\section{Methods}{
\describe{   \item{coerce}{\code{signature(from = "numeric", to = "Integer")}:
      create a \code{"Integer"} object from a \code{"numeric"} vector.}
}}
%\references{ ~put references to the literature/web site here ~ }
\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}
}
%\note{ ~~further notes~~ }
\seealso{
\code{\link{numeric}}, \code{\link{vector}}
}
%\examples{}
\keyword{classes}
\keyword{internal}



