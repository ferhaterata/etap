\name{AbscontDistribution}
\alias{AbscontDistribution}

\title{Generating function "AbscontDistribution"}
\description{Generates an object of class  \code{"AbscontDistribution"}}

\usage{
AbscontDistribution(r = NULL, d = NULL, p = NULL, q = NULL,
                   gaps = NULL, param = NULL, img = new("Reals"),
                   .withSim = FALSE, .withArith = FALSE,
                    .lowerExact = FALSE, .logExact = FALSE,
                   withgaps = getdistrOption("withgaps"),
                   low1 = NULL, up1 = NULL, low = -Inf, up =Inf,
                   withStand = FALSE,
                   ngrid = getdistrOption("DefaultNrGridPoints"),
                   ep = getdistrOption("TruncQuantile"),
                   e = getdistrOption("RtoDPQ.e"),
                   Symmetry = NoSymmetry())
}
\arguments{
  \item{r}{slot \code{r} to be filled} 
  \item{d}{slot \code{d} to be filled} 
  \item{p}{slot \code{p} to be filled} 
  \item{q}{slot \code{q} to be filled} 
  \item{gaps}{slot gaps (of class \code{"matrix"} with two columns) to be filled 
              (i.e. \code{t(gaps)} must be ordered if read as vector)} 
  \item{param}{parameter (of class \code{"OptionalParameter"})} 
  \item{img}{image range of the distribution (of class \code{"rSpace"})} 
  \item{low1}{lower bound (to be the lower TruncQuantile-quantile of the distribution)} 
  \item{up1}{upper bound (to be the upper TruncQuantile-quantile of the distribution)} 
  \item{low}{lower bound (to be the 100-percent-quantile of the distribution)}   
  \item{up}{upper bound (to be the 100-percent-quantile of the distribution)}  
  \item{withStand}{logical: shall we standardize argument function \code{d}
  to integrate to 1 --- default is no resp. \code{FALSE}}  
  \item{ngrid}{number of gridpoints}
  \item{ep}{tolerance epsilon}
  \item{e}{exponent to base 10 to be used for simulations}
  \item{withgaps}{logical; shall gaps be reconstructed empirically?}
  \item{.withArith}{normally not set by the user, but if determining the entries \code{supp}, \code{prob}
                    distributional arithmetics was involved, you may set this to \code{TRUE}.}
  \item{.withSim}{normally not set by the user, but if determining the entries \code{supp}, \code{prob}
                  simulations were involved, you may set this to \code{TRUE}.}
  \item{.lowerExact}{normally not set by the user: whether the \code{lower.tail=FALSE}
                     part is calculated exactly, avoing a ``\code{1-.}''.}
  \item{.logExact}{normally not set by the user: whether in determining slots \code{d,p,q},
         we make particular use of a logarithmic representation to enhance accuracy.}
  \item{Symmetry}{you may help \R in calculations if you tell it whether
    the distribution is non-symmetric (default) or symmetric with respect
    to a center; in this case use \code{Symmetry=SphericalSymmetry(center)}.}
}
\details{
  Typical usages are
  \preformatted{
  AbscontDistribution(r)
  AbscontDistribution(r = NULL, d)
  AbscontDistribution(r = NULL, d = NULL, p)
  AbscontDistribution(r = NULL, d = NULL, p = NULL, d)
  AbscontDistribution(r, d, p, q)
  }


Minimally, only one of the slots \code{r}, \code{d}, \code{p} or \code{q} needs to be given as argument.
The other non-given slots are then reconstructed according to the following scheme:

\tabular{ccccl}{
r\tab d\tab p\tab q\tab proceding\cr
-\tab -\tab -\tab -\tab excluded\cr
-\tab +\tab -\tab -\tab p by \code{.D2P}, q by \code{.P2Q}, r by \code{q(runif(n))}\cr
-\tab -\tab +\tab -\tab d by \code{.P2D}, q by \code{.P2Q}, r by \code{q(runif(n))}\cr
-\tab +\tab +\tab -\tab q by \code{.P2Q}, r by \code{q(runif(n))}\cr
-\tab -\tab -\tab +\tab p by \code{.Q2P}, d by \code{.P2D}, r by \code{q(runif(n))}\cr
-\tab +\tab -\tab +\tab p by \code{.Q2P}, r by \code{q(runif(n))}\cr
-\tab -\tab +\tab +\tab d by \code{.P2D}, r by \code{q(runif(n))}\cr
-\tab +\tab +\tab +\tab r by \code{q(runif(n))}\cr
+\tab -\tab -\tab -\tab call to \code{\link{RtoDPQ}}\cr
+\tab +\tab -\tab -\tab p by \code{.D2P}, q by \code{.P2Q}\cr
+\tab -\tab +\tab -\tab d by \code{.P2D}, q by \code{.P2Q}\cr
+\tab +\tab +\tab -\tab q by \code{.P2Q}\cr
+\tab -\tab -\tab +\tab p by \code{.Q2P}, d by \code{.P2D}\cr
+\tab +\tab -\tab +\tab p by \code{.Q2P}\cr
+\tab -\tab +\tab +\tab d by \code{.P2D}\cr
+\tab +\tab +\tab +\tab nothing\cr}

For this purpose, one may alternatively give arguments \code{low1} and \code{up1} (\code{NULL} each by default,
and determined through slot \code{q}, resp. \code{p}, resp. \code{d}, resp. \code{r} in this order
according to availability),
for the (finite) range of values in the support of this distribution, 
as well as the possibly infinite theoretical range given by
arguments \code{low} and \code{up} with default values \code{-Inf}, \code{Inf}, respectively.
Of course all other slots may be specified as arguments.}


\value{Object of class \code{"AbscontDistribution"}}


\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}
  }


\seealso{
\code{\link{AbscontDistribution-class}},
\code{\link{DiscreteDistribution-class}}, 
\code{\link{RtoDPQ}}
}
\examples{
plot(Norm())
plot(AbscontDistribution(r = rnorm))
plot(AbscontDistribution(d = dnorm))
plot(AbscontDistribution(p = pnorm))
plot(AbscontDistribution(q = qnorm))
plot(Ac <- AbscontDistribution(d = function(x, log = FALSE){
                                   d <- exp(-abs(x^3))
                                   ## unstandardized!!
                                   if(log) d <- log(d)
                                   return(d)}, 
                         withStand = TRUE))
}
\keyword{distribution}
\concept{absolutely continuous distribution}
\concept{generating function}
