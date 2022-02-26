\name{sd-methods}
\docType{methods}
\alias{sd-methods}
\alias{sd<--methods}
\alias{sd}
\alias{sd<-}
\alias{sd,NormParameter-method}
\alias{sd,Norm-method}
\alias{sd<-,NormParameter-method}
\alias{sd<-,Norm-method}
\title{ Methods for Function sd in Package `distr' }
\description{sd-methods}
\section{Methods}{\describe{
\item{sd}{\code{signature(x = "Any")}: see \link[stats]{sd}}    
\item{sd}{\code{signature(x = "NormParameter")}: returns the slot sd of the parameter of the distribution }    
\item{sd<-}{\code{signature(object = "NormParameter")}: modifies the slot sd of the parameter of the distribution }
\item{sd}{\code{signature(x = "Norm")}: returns the slot sd of the parameter of the distribution }
\item{sd<-}{\code{signature(object = "Norm")}: modifies the slot sd of the parameter of the distribution }
}}
\seealso{\link[stats]{sd}}
\keyword{methods}
\keyword{distribution}
\concept{parameter}
\concept{Normal distribution}
\concept{Gaussian distribution}
\concept{S4 parameter class}
\concept{location scale family}
\concept{scale parameter}
\concept{accessor function}
\concept{replacement function}
