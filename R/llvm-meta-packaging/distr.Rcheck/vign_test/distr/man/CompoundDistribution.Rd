\name{CompoundDistribution}
\alias{CompoundDistribution}

\title{Generating function for Class "CompoundDistribution"}
\description{Generates an object of class \code{"CompoundDistribution"}.}
\usage{
CompoundDistribution(NumbOfSummandsDistr, SummandsDistr, .withSim = FALSE,
                                 withSimplify = FALSE)
                                }
\arguments{
  \item{NumbOfSummandsDistr}{Object of class \code{"DiscreteDistribution"},
     the frequency distribution; it is checked that support is contained in
     0,1,2,\dots}
  \item{SummandsDistr}{Object of class \code{"UnivDistrListOrDistribution"},
     that is, either of class \code{"UnivarDistrList"} (non i.i.d. case) or
     of class \code{"UnivariateDistribution"} (i.i.d. case); 
     the summand distribution(s).}
  \item{.withSim}{logical; value of the corresponding slot.} 
  \item{withSimplify}{\code{"logical"}: shall the return value be piped through a 
   call to \code{simplifyD}?}
}
\value{Object of class \code{"CompoundDistribution"}, or if 
argument \code{withSimplify} is \code{TRUE} the result of
\code{\link{simplifyD}} applied to the compound distribution,
i.e. an object of class \code{"UnivarLebDecDistribution"}, or if degenerate,
of class \code{"AbscontDistribution"} or \code{"DiscreteDistribution"}.}
%\references{}
\author{Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}}
%\note{}
\seealso{\code{\link{CompoundDistribution-class}},
  \code{\link{simplifyD}}}
\examples{
CP0 <- CompoundDistribution(Pois(), Norm())
CP0
CP1 <- CompoundDistribution(DiscreteDistribution(supp = c(1,5,9,11),
                            prob = dbinom(0:3, size = 3,prob = 0.3)),Norm())
CP1
UL <- UnivarDistrList(Norm(), Binom(10,0.3), Chisq(df=4), Norm(),
                      Binom(10,0.3), Chisq(df=4), Norm(), Binom(10,0.3),
                      Chisq(df=4), Td(5), Td(10))
CP2 <- CompoundDistribution(DiscreteDistribution(supp = c(1,5,9,11),
                      prob = dbinom(0:3, size = 3, prob = 0.3)),UL)
plot(CP2)
}
\keyword{distribution}
\keyword{list}
\concept{compound distribution}
\concept{S4 distribution class}
\concept{generating function}

