\name{lambda-methods}
\docType{methods}
\alias{lambda-methods}
\alias{lambda<--methods}
\alias{lambda}
\alias{lambda<-}
\alias{lambda,PoisParameter-method}
\alias{lambda,Pois-method}
\alias{lambda<-,PoisParameter-method}
\alias{lambda<-,Pois-method}
\title{ Methods for Function lambda  in Package `distr'}
\description{lambda-methods}

\section{Methods}{\describe{

\item{lambda}{\code{signature(object = "PoisParameter")}: returns the slot \code{lambda} of the parameter of the distribution }
\item{lambda<-}{\code{signature(object = "PoisParameter")}: modifies the slot \code{lambda} of the parameter of the distribution }

\item{lambda}{\code{signature(object  = "Pois")}: returns the slot \code{lambda} of the parameter of the distribution }
\item{lambda<-}{\code{signature(object = "Pois")}: modifies the slot \code{lambda} of the parameter of the distribution }

}}
\keyword{methods}
\keyword{distribution}
\concept{parameter}
\concept{Poisson distribution}
\concept{S4 parameter class}
\concept{accessor function}
\concept{replacement function}
