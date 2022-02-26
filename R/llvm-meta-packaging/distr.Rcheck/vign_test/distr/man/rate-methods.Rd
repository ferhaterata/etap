\name{rate-methods}
\docType{methods}
\alias{rate-methods}
\alias{rate<--methods}
\alias{rate}
\alias{rate<-}
\alias{rate,ExpParameter-method}
\alias{rate,Exp-method}
\alias{rate,DExp-method}
\alias{rate<-,ExpParameter-method}
\alias{rate<-,Exp-method}
\alias{rate<-,DExp-method}
\title{ Methods for Function rate in Package `distr' }
\description{rate-methods}

\section{Methods}{\describe{

\item{rate}{\code{signature(object = "ExpParameter")}: returns the slot \code{rate} of the parameter of the distribution }
\item{rate<-}{\code{signature(object = "ExpParameter")}: modifies the slot \code{rate} of the parameter of the distribution }

\item{rate}{\code{signature(object = "Exp")}: returns the slot \code{rate} of the parameter of the distribution }
\item{rate<-}{\code{signature(object = "Exp")}: modifies the slot \code{rate} of the parameter of the distribution }

\item{rate}{\code{signature(object = "DExp")}: returns the slot \code{rate} of the parameter of the distribution }
\item{rate<-}{\code{signature(object = "DExp")}: modifies the slot \code{rate} of the parameter of the distribution }

}}
\keyword{methods}
\keyword{distribution}
\concept{parameter}
\concept{Double Exponential distribution}
\concept{Exponential distribution}
\concept{Laplace distribution}
\concept{S4 parameter class}
\concept{accessor function}
\concept{replacement function}
