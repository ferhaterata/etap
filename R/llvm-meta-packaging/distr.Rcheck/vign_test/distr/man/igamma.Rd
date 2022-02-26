\name{igamma}
\alias{igamma}

\title{Inverse of the digamma function}
\description{
  Function \code{igamma} is a numerical inverse of \code{digamma}.
}
\usage{
igamma(v)
}
\arguments{
  \item{v}{ a numeric in the range [-100000,18] }
  }
\details{
\code{igamma} is vectorized;  it is won
  by spline inversion of a grid; it works well for range 
  [digamma(1e-5);digamma(1e8)] or [-100000,18].
}
\value{\code{igamma(x)} is a value \code{u} such that \code{digamma(u} is approximately \code{x}.}
\author{Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}}
%\note{}
\seealso{\code{digamma}}
\examples{
igamma(digamma(c(1e-4,1,20,1e8)))
}
\keyword{math}

