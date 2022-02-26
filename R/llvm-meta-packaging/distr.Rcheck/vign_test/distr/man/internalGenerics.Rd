\name{internalGenerics}
\alias{internalGenerics}
\alias{distribution}
\alias{samplesize}
\alias{samplesize<-}
\title{Internal: Common Generics 'distribution' and 'samplesize', 'samplesize<-'}
\description{
  In order to be able to use packages \pkg{distrSim} and \pkg{distrMod}
  resp. \pkg{RobAStBase} independently,
  it is necessary to import the respective generic from a prior package, i.e.,
  \pkg{distr}.
  }
\usage{
distribution(object)
samplesize(object, ...)
x <- samplesize(object, value)
}
\arguments{
  \item{object}{ the first argument to dispatch on in the actual methods. }
  \item{value}{ the value to be assigned. }
  \item{\dots}{ additional arguments for function \code{samplesize}. }
}

\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}}

\keyword{internal}
