\name{Minimum-methods}
\docType{methods}
\alias{Minimum-methods}
\alias{Minimum}
\alias{Maximum-methods}
\alias{Maximum}
\alias{Minimum,AbscontDistribution,AbscontDistribution-method}
\alias{Minimum,DiscreteDistribution,DiscreteDistribution-method}
\alias{Minimum,AbscontDistribution,Dirac-method}
\alias{Minimum,AcDcLcDistribution,AcDcLcDistribution-method}
\alias{Minimum,AbscontDistribution,numeric-method}
\alias{Minimum,DiscreteDistribution,numeric-method}
\alias{Minimum,AcDcLcDistribution,numeric-method}
\alias{Maximum,AcDcLcDistribution,AcDcLcDistribution-method}
\alias{Maximum,AcDcLcDistribution,numeric-method}
\title{ Methods for functions Minimum and Maximum in Package `distr' }
\description{Minimum and Maximum-methods}
\usage{
Minimum(e1, e2, ...)
Maximum(e1, e2, ...) 
\S4method{Minimum}{AbscontDistribution,AbscontDistribution}(e1,e2, ...)
\S4method{Minimum}{DiscreteDistribution,DiscreteDistribution}(e1,e2, ...)
\S4method{Minimum}{AbscontDistribution,Dirac}(e1,e2, 
                   withSimplify = getdistrOption("simplifyD"))
\S4method{Minimum}{AcDcLcDistribution,AcDcLcDistribution}(e1,e2, 
                   withSimplify = getdistrOption("simplifyD"))
\S4method{Maximum}{AcDcLcDistribution,AcDcLcDistribution}(e1,e2, 
                   withSimplify = getdistrOption("simplifyD"))
\S4method{Minimum}{AbscontDistribution,numeric}(e1,e2, ...)
\S4method{Minimum}{DiscreteDistribution,numeric}(e1,e2, ...)
\S4method{Minimum}{AcDcLcDistribution,numeric}(e1,e2,
                   withSimplify = getdistrOption("simplifyD"))
\S4method{Maximum}{AcDcLcDistribution,numeric}(e1,e2, 
                   withSimplify = getdistrOption("simplifyD"))
}
\arguments{
  \item{e1}{distribution object}
  \item{e2}{distribution object or numeric}
  \item{\dots}{further arguments (to be able to call various methods  with the same
               arguments}
  \item{withSimplify}{logical; is result to be piped through a call to 
         \code{\link{simplifyD}}?}
}
\value{the corresponding distribution of the minimum / maximum}

\section{Methods}{\describe{
\item{Minimum}{\code{signature(e1 = "AbscontDistribution", e2 = "AbscontDistribution")}: 
returns the distribution of \code{min(X1,X2)}, if \code{X1},\code{X2} are independent
and distributed according to \code{e1} and \code{e2} respectively;
the result is again of class \code{"AbscontDistribution"}}
\item{Minimum}{\code{signature(e1 = "DiscreteDistribution", e2 = "DiscreteDistribution")}: 
returns the distribution of \code{min(X1,X2)}, if \code{X1},\code{X2} are independent
and distributed according to \code{e1} and \code{e2} respectively;
the result is again of class \code{"DiscreteDistribution"}}
\item{Minimum}{\code{signature(e1 = "AbscontDistribution", e2 = "Dirac")}: 
returns the distribution of \code{min(X1,X2)}, if \code{X1},\code{X2} are  
distributed according to \code{e1} and \code{e2} respectively;
the result is of class \code{"UnivarLebDecDistribution"}}
\item{Minimum}{\code{signature(e1 = "AcDcLcDistribution", e2 = "AcDcLcDistribution")}: 
returns the distribution of \code{min(X1,X2)}, if \code{X1},\code{X2} are  
distributed according to \code{e1} and \code{e2} respectively;
the result is of class \code{"UnivarLebDecDistribution"}}
\item{Minimum}{\code{signature(e1 = "AcDcLcDistribution", e2 = "numeric")}: 
if \code{e2} = \eqn{n}, returns the distribution of \code{min(X1,X2,...,Xn)}, if \code{X1},\code{X2}, 
..., \code{Xn} are i.i.d. according to \code{e1};
the result is of class \code{"UnivarLebDecDistribution"}}
\item{Maximum}{\code{signature(e1 = "AcDcLcDistribution", e2 = "AcDcLcDistribution")}: 
returns the distribution of \code{max(X1,X2)}, if \code{X1},\code{X2} are  
distributed according to \code{e1} and \code{e2} respectively;
translates into \code{-Minimum(-e1,-e2)};
the result is of class \code{"UnivarLebDecDistribution"}}
\item{Maximum}{\code{signature(e1 = "AcDcLcDistribution", e2 = "numeric")}: 
if \code{e2} = \eqn{n}, returns the distribution of \code{max(X1,X2,...,Xn)}, if \code{X1},\code{X2}, 
..., \code{Xn} are i.i.d. according to \code{e1}; translates into 
\code{-Minimum(-e1,e2)}; the result is of class \code{"UnivarLebDecDistribution"}}
}}
\seealso{\code{\link{Huberize}}, \code{\link{Truncate}}}
\examples{
plot(Maximum(Unif(0,1), Minimum(Unif(0,1), Unif(0,1))))
plot(Minimum(Exp(4),4))
## a sometimes lengthy example...
\donttest{plot(Minimum(Norm(),Pois()))}
}
\keyword{distribution}
\keyword{methods}
\concept{minimum}
\concept{maximum}
