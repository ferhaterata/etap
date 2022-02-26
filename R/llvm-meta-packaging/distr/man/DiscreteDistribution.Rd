\name{DiscreteDistribution}
\alias{DiscreteDistribution}

\title{Generating function "DiscreteDistribution"}
\description{Generates an object of class  \code{"DiscreteDistribution"}}

\usage{
  DiscreteDistribution(supp, prob, .withArith=FALSE, .withSim=FALSE, 
                       .lowerExact = TRUE, .logExact = FALSE,
             .DistrCollapse = getdistrOption("DistrCollapse"),
             .DistrCollapse.Unique.Warn = 
                  getdistrOption("DistrCollapse.Unique.Warn"),
             .DistrResolution = getdistrOption("DistrResolution"),
             Symmetry = NoSymmetry())
}
\arguments{
  \item{supp}{numeric vector which forms the support
    of the discrete distribution. }
  \item{prob}{vector of probability weights for the
    elements of \code{supp}.}
  \item{.withArith}{normally not set by the user, but if determining the entries \code{supp}, \code{prob}
                    distributional arithmetics was involved, you may set this to \code{TRUE}.}
  \item{.withSim}{normally not set by the user, but if determining the entries \code{supp}, \code{prob}
                  simulations were involved, you may set this to \code{TRUE}.}
  \item{.lowerExact}{normally not set by the user: whether the \code{lower.tail=FALSE}
                     part is calculated exactly, avoing a ``\code{1-.}''.}
  \item{.logExact}{normally not set by the user: whether in determining slots \code{d,p,q},
         we make particular use of a logarithmic representation to enhance accuracy.}
\item{.DistrCollapse}{controls whether in generating a new discrete 
     distribution, support points closer together than \code{.DistrResolution} are
     collapsed.}
\item{.DistrCollapse.Unique.Warn}{controls whether there is a warning
      whenever collapsing occurs or when two points are collapsed by a call to
      \code{unique()} (default behaviour if \code{.DistrCollapse} is \code{FALSE})}
\item{.DistrResolution}{minimal spacing between two mass points in a discrete 
                        distribution}
\item{Symmetry}{you may help \R in calculations if you tell it whether
   the distribution is non-symmetric (default) or symmetric with respect
   to a center; in this case use \code{Symmetry=SphericalSymmetry(center)}.}
}
\details{
  If \code{prob} is missing, all elements in \code{supp}
  are equally weighted.\cr
  
  Typical usages are
  \preformatted{
    DiscreteDistribution(supp, prob)
    DiscreteDistribution(supp)
  }
  
}
\value{Object of class \code{"DiscreteDistribution"}}


\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
  }

\note{ Working with a computer, we use a finite interval as support which 
       carries at least mass \code{1-getdistrOption("TruncQuantile")}. \cr
       
       Also, we require that support points have distance at least       
       \code{.DistrResoltion}, if this condition fails,
       upon a suggestion by Jacob van Etten, \email{jacobvanetten@yahoo.com},
       we use the global option \code{.DistrCollapse} to
       decide whether we use collapsing or not. If we do so, we collapse support 
       points if they are too close to each other, taking
       the (left most) median among them as new support point which accumulates
       all the mass of the collapsed points. 
       With \code{.DistrCollapse==FALSE}, we at least collapse
       points according to the result of \code{unique()}, and if after this
       collapsing, the minimal distance is less than \code{.DistrResoltion},
       we throw an error. By \code{.DistrCollapse.Unique.Warn},
       we control, whether we throw a warning upon collapsing or not.       
       }

\seealso{
\code{\link{DiscreteDistribution-class}}
\code{\link{AbscontDistribution-class}}
\code{\link{RtoDPQ.d}}
}
\examples{
# Dirac-measure at 0
D1 <- DiscreteDistribution(supp = 0)
D1
# simple discrete distribution
D2 <- DiscreteDistribution(supp = c(1:5), prob = c(0.1, 0.2, 0.3, 0.2, 0.2))
D2

plot(D2)
}
\keyword{distribution}
\concept{discrete distribution}
\concept{generating function}
