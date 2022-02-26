\name{makeAbscontDistribution}
\alias{makeAbscontDistribution}

\title{"makeAbscontDistribution"}
\description{Transforms an object of \code{"UnivariateDistribution"} to 
             an object of class \code{"makeAbscontDistribution"}.}
\usage{makeAbscontDistribution(object, gaps = NULL,
                       param = NULL, img = NULL,
                   withgaps = getdistrOption("withgaps"),
                   ngrid = getdistrOption("DefaultNrGridPoints"),
                   ep = getdistrOption("TruncQuantile"))}
\arguments{
  \item{object}{Objects of class \code{"UnivariateDistribution"} (or subclasses)}
  \item{gaps}{slot gaps (of class \code{"matrix"} with two columns) to be filled 
              (i.e. \code{t(gaps)} must be ordered if read as vector)} 
  \item{param}{parameter (of class \code{"OptionalParameter"})} 
  \item{img}{image range of the distribution (of class \code{"rSpace"})} 
  \item{withgaps}{logical; shall gaps be reconstructed empirically?}
  \item{ngrid}{number of gridpoints}
  \item{ep}{tolerance epsilon}
}
\details{takes slot \code{p} of \code{object} and then generates an
\code{"AbscontDistribution"} object using generating function
\code{\link{AbscontDistribution}}.}
%\references{}
\author{Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}}
%\note{}
\examples{
  Hu <- Huberize(Norm(), -2,1)
  Hu
  plot(Hu)
  Hu0 <- makeAbscontDistribution(Hu)
  Hu0
  plot(Hu0)
}
\keyword{distribution}
\concept{S4 distribution class}

