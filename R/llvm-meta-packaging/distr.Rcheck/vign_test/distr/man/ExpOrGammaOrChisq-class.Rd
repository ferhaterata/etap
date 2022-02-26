\name{ExpOrGammaOrChisq-class}
\docType{class}
\alias{ExpOrGammaOrChisq-class}
\title{Class "ExpOrGammaOrChisq"}
\description{
To have common methods, a class \code{"ExpOrGammaOrChisq"} is introduced
as subclass of class \code{"AbscontDistribution"}  and as superclass of
classes \code{"Chisq"}, \code{"Exp"}, \code{"Gammad"}. It is only used 
internally.
}
 
\section{Objects from the Class}{
This class is virtual, hence cannot be instantiated.
}

\section{Extends}{
Class \code{"AbscontDistribution"}, directly.\cr
Class \code{"UnivariateDistribution"}, by class \code{"AbscontDistribution"}.\cr
Class \code{"Distribution"}, by class \code{"UnivariateDistribution"}.
}


\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}
}
\seealso{
\code{\link{Chisq-class}}
\code{\link{Gammad-class}}
\code{\link{Exp-class}}
}
\examples{
## class only used internally
}
\keyword{internal}
\keyword{distribution}
\concept{absolutely continuous distribution}
\concept{Chi square distribution}
\concept{Exp distribution}
\concept{Gamma distribution}
\concept{S4 class union}
\concept{virtual class}
