\name{shape-methods}
\docType{methods}
\alias{shape-methods}
\alias{shape<--methods}
\alias{shape}
\alias{shape<-}
\alias{shape,GammaParameter-method}
\alias{shape,Gammad-method}
\alias{shape,Chisq-method}
\alias{shape,Exp-method}
\alias{shape,WeibullParameter-method}
\alias{shape,Weibull-method}
\alias{shape<-,GammaParameter-method}
\alias{shape<-,Gammad-method}
\alias{shape<-,WeibullParameter-method}
\alias{shape<-,Weibull-method}
\title{ Methods for Function shape in Package `distr' }
\description{shape-methods}

\section{Methods}{\describe{

\item{shape}{\code{signature(object  = "GammaParameter")}: returns the slot \code{shape} of a parameter of a Gamma distribution }
\item{shape<-}{\code{signature(object = "GammaParameter")}: modifies the slot \code{shape} of a parameter of a Gamma distribution }

\item{shape}{\code{signature(object = "Gammad")}: returns the slot \code{shape} of the parameter slot of a Gamma distribution }
\item{shape<-}{\code{signature(object = "Gammad")}: modifies the slot shape of the parameter slot of a Gamma distribution }

\item{shape}{\code{signature(object  = "WeibullParameter")}: returns the slot \code{shape} of a parameter of a Weibull distribution }
\item{shape<-}{\code{signature(object = "WeibullParameter")}: modifies the slot \code{shape} of a parameter of a Weibull distribution }

\item{shape}{\code{signature(object  = "Weibull")}: returns the slot \code{shape} of the parameter slot of the distribution }
\item{shape<-}{\code{signature(object = "Weibull")}: modifies the slot \code{shape} of the parameter slot of the distribution }

\item{shape}{\code{signature(object = "Chisq")}: if \code{ncp(object)} is 0, a Chi-squared distribution is also a Gamma distribution;
     in this case, \code{shape} returns \code{df(object)/2} else an error;}

\item{shape}{\code{signature(object  = "Exp")}: returns the slot \code{shape} of the parameter slot of the Exp distribution  (=1)}
}}
\keyword{distribution}
\keyword{methods}
\concept{shape}
\concept{parameter}
\concept{Gamma distribution}
\concept{Chi square distribution}
\concept{Exp distribution}
\concept{Weibull distribution}
\concept{accessor function}
\concept{replacement function}
