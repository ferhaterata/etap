\name{scale-methods}
\docType{methods}
\alias{scale-methods}
\alias{scale<--methods}
\alias{scale}
\alias{scale<-}
\alias{scale,GammaParameter-method}
\alias{scale,Gammad-method}
\alias{scale,Chisq-method}
\alias{scale,LogisParameter-method}
\alias{scale,Logis-method}
\alias{scale,WeibullParameter-method}
\alias{scale,Weibull-method}
\alias{scale,CauchyParameter-method}
\alias{scale,Cauchy-method}
\alias{scale<-,GammaParameter-method}
\alias{scale<-,Gammad-method}
\alias{scale<-,LogisParameter-method}
\alias{scale<-,Logis-method}
\alias{scale<-,WeibullParameter-method}
\alias{scale<-,Weibull-method}
\alias{scale<-,CauchyParameter-method}
\alias{scale<-,Cauchy-method}
\title{ Methods for Function scale in Package `distr' }
\description{scale-methods}

\section{Methods}{\describe{

\item{scale}{\code{signature(object = "GammaParameter")}: returns the slot \code{scale} of the parameter of the distribution }
\item{scale<-}{\code{signature(object = "GammaParameter")}: modifies the slot \code{scale} of the parameter of the distribution }

\item{scale}{\code{signature(object = "Gammad")}: returns the slot \code{scale} of the parameter of the distribution }
\item{scale<-}{\code{signature(object = "Gammad")}: modifies the slot \code{scale} of the parameter of the distribution }

\item{scale}{\code{signature(object = "LogisParameter")}: returns the slot \code{scale} of the parameter of the distribution }
\item{scale<-}{\code{signature(object = "LogisParameter")}: modifies the slot \code{scale} of the parameter of the distribution }

\item{scale}{\code{signature(object = "Logis")}: returns the slot \code{scale} of the parameter of the distribution }
\item{scale<-}{\code{signature(object = "Logis")}: modifies the slot \code{scale} of the parameter of the distribution }

\item{scale}{\code{signature(object = "WeibullParameter")}: returns the slot \code{scale} of the parameter of the distribution }
\item{scale<-}{\code{signature(object = "WeibullParameter")}: modifies the slot \code{scale} of the parameter of the distribution }

\item{scale}{\code{signature(object = "Weibull")}: returns the slot \code{scale} of the parameter of the distribution }
\item{scale<-}{\code{signature(object = "Weibull")}: modifies the slot \code{scale} of the parameter of the distribution }

\item{scale}{\code{signature(object = "CauchyParameter")}: returns the slot \code{scale} of the parameter of the distribution }
\item{scale<-}{\code{signature(object = "CauchyParameter")}: modifies the slot \code{scale} of the parameter of the distribution }

\item{scale}{\code{signature(object = "Cauchy")}: returns the slot \code{scale} of the parameter of the distribution }
\item{scale<-}{\code{signature(object = "Cauchy")}: modifies the slot \code{scale} of the parameter of the distribution }

\item{scale}{\code{signature(object = "Chisq")}:  if \code{ncp(object)} is 0, a Chi-squared distribution is also a Gamma distribution;
     in this case, \code{scale} returns 2 else an error;}

}}
\keyword{methods}
\keyword{distribution}
\concept{parameter}
\concept{Gamma distribution}
\concept{Logistic distribution}
\concept{Weibull distribution}
\concept{Cauchy distribution}
\concept{Chi Square distribution}
\concept{S4 parameter class}
\concept{location scale family}
\concept{scale parameter}
\concept{accessor function}
\concept{replacement function}
