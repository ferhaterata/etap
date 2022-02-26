\name{solve-methods}
\docType{methods}
\alias{solve-methods}
\alias{solve}
\alias{solve,ANY,ANY-method}
\alias{solve,PosSemDefSymmMatrix,ANY-method}
\alias{solve,PosDefSymmMatrix,ANY-method}
\alias{solve,ANY-method}
\alias{solve,PosSemDefSymmMatrix-method}
\alias{solve,PosDefSymmMatrix-method}
\title{ Methods for Function solve in Package `distr' }
\description{solve-methods using generalized inverses for various types of matrices}

\usage{solve(a,b, ...)
\S4method{solve}{ANY,ANY}(a, b, generalized = 
getdistrOption("use.generalized.inverse.by.default"), tol = 1e-10)
\S4method{solve}{PosSemDefSymmMatrix,ANY}(a, b, generalized =
getdistrOption("use.generalized.inverse.by.default"), tol = 1e-10)
\S4method{solve}{PosDefSymmMatrix,ANY}(a, b, tol = 1e-10)
}
\arguments{
  \item{a}{matrix to be inverted / to be solved for RHS.}
  \item{b}{a numeric or complex vector or matrix giving the right-hand
          side(s) of the linear system.  If missing, \code{b} is taken to be
          an identity matrix and \code{solve} will return the inverse of
          \code{a}.}
  \item{\dots}{ further arguments to be passed to specific methods (see \code{\link[base]{solve}}).}
  \item{generalized}{ logical: should generalized / Moore-Penrose inverses be used? By default uses
  the corresponding global option to be set by \code{\link{distroptions}}.}
  \item{tol}{ the tolerance for detecting linear dependencies in the
          columns of \code{a}.  Default is \code{.Machine$double.eps}.}
}
\section{Methods}{\describe{
\item{solve}{\code{signature(a = "ANY", b = "ANY")}: tries to evaluate \code{solve.default} method from \pkg{base} in classical way;
if this gives an error, this one is returned if \code{generalized} is \code{TRUE}, else it will then
return \eqn{a^-b} where \eqn{a^-} is the pseudo or Moore-Penrose inverse of \eqn{a}.}
\item{solve}{\code{signature(a = "PosSemDefSymmMatrix", b = "ANY")}: evaluates \eqn{a^-b} where \eqn{a^-} is the pseudo or Moore-Penrose
inverse of \eqn{a}.}
\item{solve}{\code{signature(a = "PosDefSymmMatrix", b = "ANY")}: evaluates solve method from \pkg{base} in classical way.}
}}
\details{The method for the Moore-Penrose inverse for 
\code{signature(a = "PosSemDefSymmMatrix", b = "ANY")} uses \code{eigen} to find the eigenvalue 
decomposition of \code{a} and then simply "pseudo-inverts" the corresponding diagonal matrix built from
\code{eigen(a)$values}, while for \code{signature(a = "ANY", b = "ANY")}  it uses the svd 
decomposition of \code{a} and then simply "pseudo-inverts" the corresponding diagonal matrix built from
\code{svd(a)$d}.}
\author{Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}}
\seealso{
\code{\link[base]{solve}} for the default method, \code{\link[base]{eigen}} and \code{\link[base]{svd}} 
for the pseudo inversion}
\keyword{algebra}
\keyword{array}
\concept{pseudo inverse}
\concept{inverse}
\concept{svd}
\concept{eigenvalue decomposition}
