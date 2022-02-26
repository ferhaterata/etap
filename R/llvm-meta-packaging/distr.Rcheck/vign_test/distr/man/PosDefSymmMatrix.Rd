\name{PosDefSymmMatrix}
\alias{PosDefSymmMatrix}
\alias{PosSemDefSymmMatrix}

\title{Generating functions for PosSemDefSymmMatrix-class resp. PosDefSymmMatrix-class}
\description{Generates an object of class \code{"PosSemDefSymmMatrix"} resp. of class \code{"PosDefSymmMatrix"}.}
\usage{PosSemDefSymmMatrix(mat)
       PosDefSymmMatrix(mat)}
\arguments{
  \item{mat}{A numeric positive-[semi-]definite, symmetric 
    matrix with finite entries.}
}
\details{
  If \code{mat} is no matrix, \code{as.matrix} is applied.
}
\value{Object of class \code{"PosSemDefSymmMatrix"} resp. of class \code{"PosDefSymmMatrix"}}
%\references{}
\author{Matthias Kohl \email{Matthias.Kohl@stamats.de},
Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}}
%\note{}
\seealso{\code{\link{PosDefSymmMatrix-class}}}
\examples{
PosSemDefSymmMatrix(1)
PosSemDefSymmMatrix(diag(2))
PosDefSymmMatrix(1)
PosDefSymmMatrix(diag(2))
}
\concept{positive-semi-definite matrix}
\concept{positive-definite matrix}
\concept{symmetric matrix}
\keyword{array}
