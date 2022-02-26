\name{liesInSupport}
\alias{liesInSupport}
\alias{liesInSupport-methods}
\alias{liesInSupport,UnivarLebDecDistribution,numeric-method}
\alias{liesInSupport,UnivarMixingDistribution,numeric-method}
\alias{liesInSupport,LatticeDistribution,numeric-method}
\alias{liesInSupport,DiscreteDistribution,numeric-method}
\alias{liesInSupport,Distribution,matrix-method}
\alias{liesInSupport,AbscontDistribution,numeric-method}
\alias{liesInSupport,ExpOrGammaOrChisq,numeric-method}
\alias{liesInSupport,Lnorm,numeric-method}
\alias{liesInSupport,Fd,numeric-method}
\alias{liesInSupport,Norm,numeric-method}
\alias{liesInSupport,DExp,numeric-method}
\alias{liesInSupport,Cauchy,numeric-method}
\alias{liesInSupport,Td,numeric-method}
\alias{liesInSupport,Logis,numeric-method}
\alias{liesInSupport,Weibull,numeric-method}
\alias{liesInSupport,Unif,numeric-method}
\alias{liesInSupport,Beta,numeric-method}


\title{Generic Function for Testing the Support of a Distribution }
\description{
  The function tests if \code{x} lies in the support of the
  distribution \code{object}.
}
\usage{
liesInSupport(object, x, ...)
\S4method{liesInSupport}{UnivarLebDecDistribution,numeric}(object,x, checkFin = FALSE)
\S4method{liesInSupport}{UnivarMixingDistribution,numeric}(object,x, checkFin = FALSE)
\S4method{liesInSupport}{LatticeDistribution,numeric}(object,x, checkFin = FALSE)
\S4method{liesInSupport}{DiscreteDistribution,numeric}(object,x, checkFin = FALSE)
\S4method{liesInSupport}{AbscontDistribution,numeric}(object,x, checkFin = FALSE)
\S4method{liesInSupport}{Distribution,matrix}(object,x, checkFin = FALSE)
\S4method{liesInSupport}{ExpOrGammaOrChisq,numeric}(object,x, checkFin = TRUE)
\S4method{liesInSupport}{Lnorm,numeric}(object,x, checkFin = TRUE)
\S4method{liesInSupport}{Fd,numeric}(object,x, checkFin = TRUE)
\S4method{liesInSupport}{Norm,numeric}(object,x, checkFin = TRUE)
\S4method{liesInSupport}{DExp,numeric}(object,x, checkFin = TRUE)
\S4method{liesInSupport}{Cauchy,numeric}(object,x, checkFin = TRUE)
\S4method{liesInSupport}{Td,numeric}(object,x, checkFin = TRUE)
\S4method{liesInSupport}{Logis,numeric}(object,x, checkFin = TRUE)
\S4method{liesInSupport}{Weibull,numeric}(object,x, checkFin = TRUE)
\S4method{liesInSupport}{Unif,numeric}(object,x, checkFin = TRUE)
\S4method{liesInSupport}{Beta,numeric}(object,x, checkFin = TRUE)
}
\arguments{
  \item{object}{ object of class \code{"Distribution"} }
  \item{x}{ numeric vector or matrix }
  \item{checkFin}{ logical: in case \code{FALSE}, we simply check whether
  \code{x} lies in the \emph{numerical} (i.e., possibly cut
  to relevant quantile range) support; in case \code{TRUE} we try to
  check this by more exact techniques (e.g. in case of lattice distributions)
  and by using slot \code{.finSupport} / the return values of \code{q.l(object)}
  in \code{0} and \code{1}. This is only used on discrete (parts of)
  distributions).}
  \item{\dots}{ used for specific arguments to particular methods. }
}
%\details{}
\value{logical vector}
\section{Methods}{
\describe{
  \item{object = "DiscreteDistribution", x = "numeric":}{ 
    We return a logical vector of the same length as \code{x} with \code{TRUE}
    when \code{x} lies in the support of \code{object}.
    As support we use the value of \code{support(object)}, so this
    is possibly cut to relevant quantile ranges.
    In case \code{checkFin} is \code{TRUE}, in addition, we flag those coordinates
    to \code{TRUE} where \code{x < min(support(object))} if
    \code{is.na(object@.finSupport[1])} or \code{object@.finSupport[1]==FALSE}
    or \code{q.l(object)(0)==-Inf}, and similarly, where
    \code{x > max(support(object))} if \code{is.na(object@.finSupport[2])}
    or \code{object@.finSupport[2]==FALSE} or \code{q.l(object)(1)==Inf}.
    In addition we flag those coordinates to \code{TRUE} where
    \code{q.l(object)(0)<=x<min(support(object))} if
    \code{object@.finSupport[1]==TRUE} and, similarly, where
    \code{q.l(object)(1)>=x>max(support(object))} if
    \code{object@.finSupport[2]==TRUE}.
    }

  \item{object = "Distribution", x = "matrix":}{
    Argument \code{x} is cast to vector and then the respective
    \code{liesInSupport} method for vectors is called. The method throws an
    arror when the dispatch mechanism does not find a suitable, applicable
    respective vector-method.
    }

  \item{object = "AbscontDistribution", x = "numeric":}{
    We return a logical vector of the same length as \code{x} with \code{TRUE}
    where \code{q.l(object)(0)<=x<=q.l(object)(1)} (and replace the boundary
    values by \code{q.l(object)(10*.Machine$double.eps)} resp.
    \code{q.l(object)(1-10*.Machine$double.eps)} once the return values
    for \code{0} or \code{1} return are \code{NaN}.
  }

  \item{object = "LatticeDistribution", x = "numeric":}{
    We return a logical vector of the same length as \code{x} with \code{TRUE}
    when \code{x} lies in the support of \code{object}.
    As support we use the value of \code{support(object)}, so this
    is possibly cut to relevant quantile ranges.
    In case \code{checkFin} is \code{TRUE}, we instead use the lattice
    information: We check whether all values
    \code{(x-pivot(lattice(object))/width(lattice(object))} are non-negative
    integers and are non larger than \code{Length(lattice(object))-1}.
    In addition, we flag those coordinates to \code{TRUE} where
    \code{x < min(support(object))} if
    \code{is.na(object@.finSupport[1])} or \code{object@.finSupport[1]==FALSE},
    and similarly, where \code{x > max(support(object))} if
    \code{is.na(object@.finSupport[2])}
    or \code{object@.finSupport[2]==FALSE}.
    }

  \item{object = "UnivarLebDecDistribution", x = "numeric":}{
    We split up \code{object} into discrete and absolutely continuous
    part and for each of them apply \code{liesInSupport} separately;
    the two return values are combined by a coponentwise logical \code{|}.
    }

  \item{object = "UnivarMixingDistribution", x = "numeric":}{
    We first cast \code{object} to \code{UnivarLebDecDistribution}
    by \code{flat.mix} and then apply the respective method.
    }
}}
%
%\references{}
\author{Matthias Kohl \email{Matthias.Kohl@stamats.de} and
Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}}
%\note{}
\seealso{\code{\link{Distribution-class}}}
\examples{
liesInSupport(Exp(1), rnorm(10))

# note
x <- rpois(10, lambda = 10)
liesInSupport(Pois(1), x)
# better
liesInSupport(Pois(1), x, checkFin = TRUE)
liesInSupport(Pois(1), 1000*x, checkFin = TRUE)
liesInSupport(-10*Pois(1), -10*x+1, checkFin = TRUE)

xs = c(1000*x,runif(10))
D <- UnivarMixingDistribution(Pois(1),Unif())
liesInSupport(D, xs)

}
\keyword{distribution}
\keyword{methods}
\concept{space}
\concept{S4 space class}
\concept{support}
