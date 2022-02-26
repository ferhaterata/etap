\name{convpow-methods}
\docType{methods}
\alias{convpow}
\alias{convpow-methods}
\alias{convpow,AcDcLcDistribution-method}
\alias{convpow,AbscontDistribution-method}
\alias{convpow,LatticeDistribution-method}
\alias{convpow,DiscreteDistribution-method}
\alias{convpow,AcDcLcDistribution-method}
\alias{convpow,Norm-method}
\alias{convpow,Binom-method}
\alias{convpow,Nbinom-method}
\alias{convpow,ExpOrGammaOrChisq-method}
\alias{convpow,Cauchy-method}
\alias{convpow,Pois-method}
\alias{convpow,Dirac-method}

\title{Distribution of the sum of univariate i.i.d r.v's}
\description{
  Method \code{convpow} determines the distribution of the sum of N univariate
  i.i.d r.v's by means of DFT}


\usage{
  convpow(D1,...)
  \S4method{convpow}{AbscontDistribution}(D1,N)
  \S4method{convpow}{LatticeDistribution}(D1,N, 
                     ep = getdistrOption("TruncQuantile"))
  \S4method{convpow}{DiscreteDistribution}(D1,N)
  \S4method{convpow}{AcDcLcDistribution}(D1,N, 
                     ep = getdistrOption("TruncQuantile"))
}

\arguments{
  \item{D1}{an object of (a sub)class (of) \code{"AbscontDistribution"} or  
            \code{"LatticeDistribution"} or of \code{"UnivarLebDecDistribution"}}
  \item{\dots}{not yet used; meanwhile takes up N }
  \item{N}{ an integer or 0 (for 0 returns Dirac(0), for 1 D1)}
  \item{ep}{ numeric of length 1 in (0,1) ---
             for \code{"LatticeDistribution"}: support points will be 
             cancelled if their probability is less than \code{ep};
             for \code{"UnivarLebDecDistribution"}: if \code{(acWeight(object)<ep)} 
             we work with the discrete parts only, and, similarly, if
             \code{(discreteWeight(object)<ep)} we with the absolutely continuous 
             parts only.}
  }
\details{
  in the methods implemented a second argument \code{N} is obligatory;
  the general methods use a general purpose convolution algorithm for 
  distributions by means of D/FFT. In case of an argument of class 
  \code{"UnivarLebDecDistribution"}, the result will in generally be
   again of class \code{"UnivarLebDecDistribution"}. However, if \code{acWeight(D1)}
   is positive, \code{discreteWeight(convpow(D1,N))} will decay exponentially
   in \code{N}, hence from some (small) \eqn{N_0} on, the result will be of
   class \code{"AbscontDistribution"}. This is used algorithmically, too, as 
   then only the a.c. part needs to be convolved.
   In case of an argument \code{D1} of class \code{"DiscreteDistribution"},
   for \code{N} equal to 0,1 we return the obvious solutions, and for \code{N==2} 
   the return value is \code{D1+D1}. For \code{N>2}, we split up \code{N} into
   \code{N=N1+N2}, \code{N1=floor(N/2)} and recursively return
   \code{convpow(D1,N1)+convpow(D1,N2)}.
   }

\value{Object of class \code{"AbscontDistribution"}, \code{"DiscreteDistribution"},
       \code{"LatticeDistribution"} resp. \code{"AcDcLcDistribution"}}

\section{further S4-Methods}{
  There are particular methods for the following classes, using explicit 
  convolution formulae:
  \describe{
    \item{\code{signature(D1="Norm")}}{returns class \code{"Norm"}}
    \item{\code{signature(D1="Nbinom")}}{returns class \code{"Nbinom"}}
    \item{\code{signature(D1="Binom")}}{returns class \code{"Binom"}}
    \item{\code{signature(D1="Cauchy")}}{returns class \code{"Cauchy"}}
    \item{\code{signature(D1="ExpOrGammaOrChisq")}}{returns class 
         \code{"Gammad"} ---if \code{D1} may be coerced to \code{Gammad}}
    \item{\code{signature(D1="Pois")}}{returns class \code{"Pois"}}
    \item{\code{signature(D1="Dirac")}}{returns class \code{"Dirac"}}
  }
}

\author{Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}\cr
Matthias Kohl \email{matthias.kohl@stamats.de}
Thomas Stabla \email{statho3@web.de}
}
%\note{}
\seealso{\code{\link{operators}}, \code{distrARITH()}}

\examples{
convpow(Exp()+Pois(),4)
}

\references{
Kohl, M., Ruckdeschel, P., (2014):
   General purpose convolution algorithm for distributions 
  in S4-Classes by means of FFT. \emph{J. Statist. Softw.}
  \bold{59}(4): 1-25.
}

\concept{convolution for distributions}
\concept{arithmetics for distributions}
\concept{info file}
\concept{FFT}
\concept{DFT}
\keyword{distribution}

