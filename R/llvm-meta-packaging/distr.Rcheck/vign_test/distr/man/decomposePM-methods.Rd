\name{decomposePM-methods}
\docType{methods}
\alias{decomposePM-methods}
\alias{decomposePM}
\alias{decomposePM,AbscontDistribution-method}
\alias{decomposePM,DiscreteDistribution-method}
\alias{decomposePM,UnivarLebDecDistribution-method}
\title{ Methods for function decomposePM in Package `distr' }
\description{decomposePM-methods}

\usage{
decomposePM(object)
}
\arguments{
  \item{object}{Abscont-/Discrete-/UnivarLebDec-Distribution object}
}
\value{the positive and negative part of the distribution together with
corresponding weights as a list.}

\details{
There are particular return types for the following classes
\describe{
\item{"AbscontDistribution"}{a list with components \code{"neg"} and 
\code{"pos"} for the respective negative and positive part; each of these
parts in its turn is a list with components \code{D} for the distribution
(in this case of class \code{"AbscontDistribution"} again) and \code{w} 
for the weight of the respective part; if the weight of
the negative part is 0, the corresponding distribution is set to 
\code{-abs(Norm())}, and respectively, if the weight of the positive part 
is 0, the corresponding distribution is set to 
\code{abs(Norm())}.}
\item{"DiscreteDistribution"}{a list with components \code{"neg"}, 
\code{"pos"} and \code{"0"} for the respective negative, positive and zero 
part; each of these parts in its turn is a list with components \code{D} for 
the distribution (in this case of class \code{"DiscreteDistribution"} again)
and \code{w} for the weight of the respective part; while the distribution of
the zero part is always \code{Dirac(0)}, if the weight of
the negative part is 0, the corresponding distribution is set to 
\code{Dirac(-1)}, and respectively, if the weight of the positive part 
is 0, the corresponding distribution is set to 
\code{Dirac(1)}.}
\item{"UnivarLebDecDistribution"}{a list with components \code{"neg"}, 
\code{"pos"} and \code{"0"} for the respective negative, positive and zero 
part; each of these parts in its turn is a list with components \code{D} for 
the distribution (in case of components \code{"neg"}, 
\code{"pos"} of class \code{"UnivarLebDecDistribution"} again, while 
the distribution of the zero part is always \code{Dirac(0)})
and \code{w} for the weight of the respective part; it is build up by calling
\code{decomposePM} for \code{acPart(object)} and \code{discretePart(object)}
separately, hence if weights of some parts are zero the corresponding
procedure mentionned for these methods applies.}
}

Method \code{decomposePM} is used by our multiplication, division and exponentiation
(\code{"*"}, \code{"/"} \code{"^"}) - methods.
}
\seealso{\code{\link{AbscontDistribution-class}}, 
\code{\link{DiscreteDistribution-class}},
\code{\link{UnivarLebDecDistribution-class}},
\code{\link{operators-methods}}}
\examples{
decomposePM(Norm())
decomposePM(Binom(2,0.3)-Binom(5,.4))
decomposePM(UnivarLebDecDistribution(Norm(),Binom(2,0.3)-Binom(5,.4), 
            acWeight = 0.3))
}
\keyword{distribution}
\keyword{methods}
\concept{truncation}
