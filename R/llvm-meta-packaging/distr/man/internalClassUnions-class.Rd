\name{InternalClassUnions}
\docType{class}
\alias{InternalClassUnions}
\alias{OptionalNumeric-class}

\title{Class unions in 'distr'}
\description{Class unions in package \pkg{distr} defined for internal 
 purposes; these are \code{OptionalNumeric},}

\section{Objects from the Class}{All of these classes are virtual: 
 No objects may be created from them.}
\details{
These classes are used internally to make available methods or to allow
slots of classes to be filled with varying types. In particular
\itemize{
\item \code{"OptionalNumeric"}: may contain objects of class  \code{"numeric"}
      or \code{"NULL"}; it is used e.g. for slot \code{nuisance} of class
      \code{"ParamFamParameter"}, as it may or may not be present but if so
      it has to be numeric.
}
}

%\section{Methods}{}
%\references{}
\author{Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}}
%\note{}
\seealso{\code{\link[methods:BasicClasses]{numeric-class}},
}
\keyword{classes}
\keyword{internal}
