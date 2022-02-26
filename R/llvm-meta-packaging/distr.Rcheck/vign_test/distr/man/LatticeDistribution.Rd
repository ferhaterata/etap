\name{LatticeDistribution}
\alias{LatticeDistribution}

\title{Class "LatticeDistribution"}
\description{The \code{LatticeDistribution}-class is the mother-class of the
classes \code{Binom}, \code{Dirac}, \code{Geom}, \code{Hyper}, \code{Nbinom} and
\code{Poisson}. It formalizes a distribution on a regular affine
linear lattice.}
\section{Objects from the Class}{
The usual way to generate objects of class \code{LatticeDistribution} is to call
the generating function \code{LatticeDistribution()}  (see details). \cr
Somewhat more flexible, but also proner to inconsistencies is a call to
\code{new("LatticeDistribution")}, where you may explicitly specify random
number generator, (counting) density, cumulative distribution and quantile
functions. For conveniance, in this call to \code{new("LatticeDistribution")},
an additional possibility is to only specify the random number generator. The
function \code{RtoDPQ.d} then approximates the three remaining slots \code{d},
\code{p} and \code{q} by random sampling.
}

\usage{
  LatticeDistribution(lattice = NULL, supp = NULL, prob = NULL,
                       .withArith = FALSE, .withSim = FALSE,
                       DiscreteDistribution = NULL, check = TRUE,
                       Symmetry = NoSymmetry())
}
\arguments{
  \item{DiscreteDistribution}{an object of class \code{DiscreteDistribution}
  or \code{AffLinDiscreteDistribution} to be
  coerced to \code{LatticeDistribution} or \code{AffLinLatticeDistribution},
  respectively}
  \item{lattice}{lattice (of class \code{Lattice}) which determines the support
                 of the discrete distribution. }
  \item{supp}{ numeric vector which forms the support
    of the discrete distribution. }
  \item{prob}{ vector of probability weights for the
    elements of \code{supp}.}
  \item{.withArith}{normally not set by the user, but if determining the entries
                    \code{supp}, \code{prob} distributional arithmetics was
                    involved, you may set this to \code{TRUE}.}
  \item{.withSim}{normally not set by the user, but if determining the entries
                  \code{supp}, \code{prob} simulations were involved, you may
                  set this to \code{TRUE}.}
  \item{check}{ logical: if \code{TRUE}, \code{LatticeDistribution()} throws an
               error if argument \code{lattice} and other arguments are
               inconsistent or if there is no way to automatically generate
               a \code{lattice} argument. If \code{check == FALSE},
               \code{LatticeDistribution()}
               returns an object of \code{DiscreteDistribution}, ignoring
               argument \code{lattice}}
  \item{Symmetry}{you may help \R in calculations if you tell it whether
    the distribution is non-symmetric (default) or symmetric with respect
    to a center; in this case use \code{Symmetry=SphericalSymmetry(center)}.}
}
\details{
  Typical usages are
  \preformatted{
  LatticeDistribution(DiscreteDistribution)
  LatticeDistribution(lattice, DiscreteDistribution)
  LatticeDistribution(lattice, supp, prob, .withArith, .withSim, check = FALSE)
  LatticeDistribution(lattice, supp, prob)
  LatticeDistribution(supp)
  }


  For the generating function \code{LatticeDistribution()}, the arguments
  are processed in the following order:\cr
%
  Arguments \code{.withSim} and \code{.withArith} are used in any case.\cr
%
  If there is an argument \code{DiscreteDistribution} (of the respective class),
  all its slots (except for \code{.withSim} and \code{.withArith})
  will be used for filling the slots of the object of class
  \code{LatticeDistribution()}/\code{AffLinLatticeDistribution()}.
  If in addition, there is an argument \code{lattice} of class \code{Lattice},
  it will be checked for consistency
  with argument \code{DiscreteDistribution} and if oK will be used for slot
  lattice of the object of class
  \code{LatticeDistribution()}/\code{AffLinLatticeDistribution()}. In case
  there is no \code{lattice} argument, slot \code{lattice} will be constructed
  from slot \code{support} from argument \code{DiscreteDistribution}.\cr
%
  If there is no argument \code{DiscreteDistribution}, but there are arguments
  \code{supp} and \code{lattice} (the latter of class \code{Lattice}) then
  these are checked for consistency and if oK, generating function
  \code{DiscreteDistribution()} is called with arguments \code{supp},
  \code{prob}, \code{.withArith}, and \code{.withSim} to produce an object
  of class \code{DiscreteDistribution} the slots of which will be used for the
  filling the slots of the object of class
  \code{LatticeDistribution()}/\code{AffLinLatticeDistribution()}.
  If in this case, argument \code{prob} is not given explicitely, all elements
  in \code{supp} are equally weighted.
  \cr
%
  If there is no argument \code{DiscreteDistribution}, but there is an argument
  \code{lattice} of class \code{Lattice} (but no argument \code{slot}) then
 if \code{Length(lattice)} is finite, a corresponding support vector \code{supp}
  is generated from argument \code{lattice} and generating function
  \code{DiscreteDistribution()} is called with arguments \code{supp},
  \code{prob}, \code{.withArith}, and \code{.withSim} to produce an object
  of class \code{DiscreteDistribution} the slots of which will be used for the
  filling the slots of the object of class \code{LatticeDistribution()}.
  If in the same situation \code{Length(lattice)} is not finite, a finite length
  for the support vector is extracted from argument \code{prob} and after
  generating \code{supp} one procedes as in the finite \code{Length(lattice)}
  case. \cr
%
  If there is no argument \code{DiscreteDistribution} and no argument
  \code{lattice} of class \code{Lattice} but an argument \code{supp} then
  it will be checked if \code{supp} makes for a lattice, and if so,
  \code{DiscreteDistribution()} is called with arguments \code{supp},
  \code{prob}, \code{.withArith}, and \code{.withSim} to produce an object
  of class \code{DiscreteDistribution} the slots of which will be used for the
  filling the slots of the object of class \code{LatticeDistribution()}. The
  corresponding \code{lattice}-slot will be filled with information from
  argument \code{supp}.  \cr
  %
  The price for this flexibility of arguments, \code{LatticeDistribution()} may
  be called with, is that you should call \code{LatticeDistribution()} with
  \emph{named arguments} only.\cr
%
  Note that internally we suppress lattice points from the support where
  the probability is 0.
}


\author{Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}}

\note{ Working with a computer, we use a finite interval as support which
carries at least mass \code{1-getdistrOption("TruncQuantile")}. }

\seealso{
\code{\link{Parameter-class}}
\code{\link{Lattice-class}}
\code{\link{LatticeDistribution-class}}
\code{\link{Reals-class}}
\code{\link{RtoDPQ.d}}
}
\examples{
  LatticeDistribution(DiscreteDistribution = DiscreteDistribution(supp =
                       c(4,3,2), prob=c(0.3,0.1,0.6)))
  LatticeDistribution(supp = c(4,3,2))
}
\keyword{distribution}
\concept{lattice distribution}
\concept{lattice of a distribution}
\concept{S4 distribution class}
\concept{generating function}
