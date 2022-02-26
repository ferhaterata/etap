\name{flat.LCD}
\alias{flat.LCD}
\title{Flattening a list of Lebesgue decomposed distributions}
\description{
  flattens a list of Lebesgue decomposed distributions endowed with weights to 
  give one Lebesgue decomposed distribution}
\usage{
flat.LCD(..., mixCoeff = NULL, withgaps = getdistrOption("withgaps"))
}
\arguments{
  \item{\dots}{list of Lebesgue decomposed distributions}
  \item{mixCoeff}{Object of class \code{"numeric"} of the same length
                  as \dots: a vector of probabilities for the mixing components.}
  \item{withgaps}{logical; shall \code{gaps} be detected empirically?}
}
\details{
\code{flat.LCD} flattens a list of Lebesgue decomposed distributions given through \code{\dots},
i.e., it takes all list elements and mixing coefficients and builds up the mixed
distribution (forgetting about the components); the result will be one distribution of 
class \code{UnivarLebDecDistribution}. If \code{mixCoeff} is missing, all list elements 
are equally weighted. It is used internally in our methods for \code{"*"}, \code{"/"},
\code{"^"} (see \link{operators-methods}), 
\code{\link{Minimum}}, and \code{\link{convpow}}, as well in method \code{\link{flat.mix}}.}

\value{ \code{flat.LCD} returns an object of class \code{UnivarLebDecDistribution}.}

\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}}

\seealso{ 
\code{\link{UnivarLebDecDistribution-class}}, 
\code{\link{operators-methods}}} 
\examples{
D1 <- as(Norm(),"UnivarLebDecDistribution")
D2 <- as(Pois(1),"UnivarLebDecDistribution")
D3 <- as(Binom(1,.4),"UnivarLebDecDistribution")
flat.LCD(D1,D2,D3, mixCoeff = c(0.4,0.5,0.1))
}
\keyword{math}
\keyword{distribution}
\keyword{arith}
\concept{Lebesgue decomposed distribution}
\concept{utility}

