\name{sqrt-methods}
\docType{methods}
\alias{sqrt-methods}
\alias{sqrt}
\alias{sqrt,PosSemDefSymmMatrix-method}
\title{ Methods for Function sqrt in Package `distr' }
\description{sqrt-methods using generalized inverses for p.s.d. matrices}

\usage{
\S4method{sqrt}{PosSemDefSymmMatrix}(x)
}
\arguments{
  \item{x}{a p.s.d. matrix (of class \code{PosSemDefSymmMatrix}}
}
\section{Methods}{\describe{
\item{sqrt}{\code{signature(x = "PosSemDefSymmMatrix")}: produces a symmetric,
 p.s.d. matrix \eqn{y} such that  \eqn{x = y^2}.}
}}
\author{Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}}
\seealso{
\code{\link{solve}}}
\keyword{algebra}
\keyword{array}
\concept{pseudo inverse}
\concept{inverse}
\concept{svd}
\concept{eigenvalue decomposition}
