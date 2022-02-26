\name{prob-methods} 
\docType{methods}
\alias{prob-methods}
\alias{prob<--methods}
\alias{prob}
\alias{prob<-}
\alias{prob,BinomParameter-method}
\alias{prob,Binom-method}
\alias{prob,NbinomParameter-method}
\alias{prob,Nbinom-method}
\alias{prob,GeomParameter-method}
\alias{prob,Geom-method}
\alias{prob,DiscreteDistribution-method}
\alias{prob,UnivarLebDecDistribution-method}
\alias{prob<-,BinomParameter-method}
\alias{prob<-,Binom-method}
\alias{prob<-,NbinomParameter-method}
\alias{prob<-,Nbinom-method}
\alias{prob<-,GeomParameter-method}
\alias{prob<-,Geom-method}
\alias{prob<-,DiscreteDistribution-method}
\title{ Methods for Function prob in Package `distr' }
\description{prob-methods}

\section{Methods}{\describe{

\item{prob}{\code{signature(object = "BinomParameter")}: returns the slot \code{prop} of the parameter of the distribution }
\item{prob<-}{\code{signature(object = "BinomParameter")}: modifies the slot \code{prob} of the parameter of the distribution }

\item{prob}{\code{signature(object = "Binom")}: returns the slot \code{prop} of the parameter of the distribution }
\item{prob<-}{\code{signature(object = "Binom")}: modifies the slot \code{prob} of the parameter of the distribution }

\item{prob}{\code{signature(object = "NbinomParameter")}: returns the slot \code{prop} of the parameter of the distribution }
\item{prob<-}{\code{signature(object = "NbinomParameter")}: modifies the slot \code{prob} of the parameter of the distribution }

\item{prob}{\code{signature(object = "Nbinom")}: returns the slot \code{prop} of the parameter of the distribution }
\item{prob<-}{\code{signature(object = "Nbinom")}: modifies the slot \code{prob} of the parameter of the distribution }

\item{prob}{\code{signature(object = "GeomParameter")}: returns the slot \code{prop} of the parameter of the distribution (deprecated from 1.9 on)}
\item{prob<-}{\code{signature(object = "GeomParameter")}: modifies the slot \code{prob} of the parameter of the distribution (deprecated from 1.9 on)}

\item{prob}{\code{signature(object = "Geom")}: returns the slot \code{prop} of the parameter of the distribution }
\item{prob<-}{\code{signature(object = "Geom")}: modifies the slot \code{prob} of the parameter of the distribution }

\item{prob}{\code{signature(object = "DiscreteDistribution")}: returns the 
(named) vector of probabilities for the support points of the distribution. }
\item{prob<-}{\code{signature(object = "DiscreteDistribution")}: 
               generates a new object of class \code{"DiscreteDistribution"} with
               the same support as \code{object} as well as the same 
               \code{.withSim}, \code{.withArith}, \code{.lowerExact}, 
               \code{.logExact} slots. }
\item{prob}{\code{signature(object = "UnivarLebDecDistribution")}: returns a
\eqn{2 \times n}{2 x n} matrix where n is the length of the support of
the discrete part of the distribution; the first row named \code{"cond"} 
gives the vector of  probabilities for the support points of the discrete part
of the distribution (i.e.; conditional on being in the discrete part), the second
row named \code{"abs"} is like the first one but multiplied with \code{discreteWeight}
of the distribution, hence gives the absolute probabilities of the support points;
the columns are named by the support values. }
}}
\keyword{distribution}
\concept{parameter}
\concept{Binomial distribution}
\concept{Negative Binomial distribution}
\concept{Geometric distribution}
\concept{S4 parameter class}
\concept{accessor function}
\concept{replacement function}
