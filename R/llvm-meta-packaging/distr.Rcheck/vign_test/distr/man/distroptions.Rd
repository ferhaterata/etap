\name{distroptions}
\alias{distroptions}
\alias{getdistrOption}
\alias{DefaultNrGridPoints}
\alias{DistrResolution}
\alias{DistrCollapse}
\alias{TruncQuantile}
\alias{WarningSim}
\alias{WarningArith}
\alias{DefaultNrFFTGridPointsExponent}
\alias{RtoDPQ.e}
\alias{WarningArith}
\alias{WarningSim}
\alias{withSweave}
\alias{warn.makeDNew}
%\alias{simplifyD}
\alias{withgaps}
\alias{use.generalized.inverse.by.default}
\alias{DistributionAggregate.Unique.Warn}


\title{
  functions to change the global variables of the package `distr'
}
\description{
  With \code{distroptions} and \code{getdistrOption} you may inspect and change the global
  variables used by package \pkg{distr}.
}
\usage{
distroptions(...)
getdistrOption(x)
}
\arguments{
  \item{\dots}{ any options can be defined, using name = value or by passing a list of such tagged values. }
  \item{x}{ a character string holding an option name.}
}
\details{Invoking \code{distroptions()} with no arguments returns a list with the current values of the options.  
 To access the value of a single option, one should use \code{getdistrOption("WarningSim")}, e.g., rather than
 \code{distroptions("WarningSim")} which is a \emph{list} of length one.}
\value{
\code{distroptions()} returns a list of the global options of \pkg{distr}. \cr
\code{distroptions("RtoDPQ.e")} returns  the global option \code{RtoDPQ.e} as a list of length 1. \cr
\code{distroptions("RtoDPQ.e" = 3)} sets the value of the global option  \code{RtoDPQ.e} to 3. 
\code{getdistrOption("RtoDPQ.e")} the current value set for option \code{RtoDPQ.e}. 
}
\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}}

\section{Currently available options}{
\describe{
\item{\code{DefaultNrGridPoints}}{default number of grid points in integration, default value: \code{2^12}}
\item{\code{DistrResolution}}{minimal spacing between two mass points in a discrete distribution, default value: \code{1e-6}}
\item{\code{DistrCollapse}}{logical; in discrete distributions, shall support points
with distance smaller than \code{DistrResolution} be collapsed; default value:  \code{TRUE}}
\item{\code{TruncQuantile}}{argument for \code{q}-slot at which to truncate; also, for discrete distributions, 
 support is restricted to [\code{q(TruncQuantile)},\code{q(1-TruncQuantile)}], default value: \code{1e-5}}
\item{\code{DefaultNrFFTGridPointsExponent}}{by default, for e = \code{DefaultNrFFTGridPointsExponent}, 
 FFT uses \eqn{2^e} gridpoints; default value: \code{12}}
\item{\code{RtoDPQ.e}}{by default, for reconstructing the \code{d}-,\code{p}-,\code{q}-slots out of simulations by slot \code{r},
\code{RtoDPQ} resp. \code{RtoDPQ.d} use \eqn{10^e} simulations, where e = \code{RtoDPQ.e}, default value: \code{5}}
\item{\code{WarningSim}}{if \code{WarningSim==TRUE}, \code{print}/\code{show} issue a warning as to the precision of 
\code{d}-,\code{p}-,\code{q}-slots when these are obtained by \code{RtoDPQ} resp. \code{RtoDPQ.d}, default value: \code{TRUE}}
\item{\code{WarningArith}}{if \code{WarningArith==TRUE}, \code{print}/\code{show} issue a warning as to the interpretation of
arithmetics operating on distributions, when the corresponding distribution to be plotted/shown is obtained by such an operation;
keep in mind that arithmetics in fact operate on random variables distributed according to the given distributions and \bold{not}
on corresponding cdf's or densities; default value: \code{TRUE}}
\item{\code{withSweave}}{is code run in Sweave (then no new graphic devices are opened), 
                         default value: \code{FALSE}}
  \item{\code{withgaps}}{controls whether in the return value of arithmetic
  operations the slot \code{gaps} of an the \code{AbscontDistribution} part
  is filled automatically based on empirical evaluations via  \code{setgaps}
   ---default \code{TRUE}}
  \item{\code{simplifyD}}{ controls whether in the return value of arithmetic
  operations there is a call to \code{simplifyD} or not ---default \code{TRUE}}
\item{use.generalized.inverse.by.default}{logical; decides whether by default
(i.e., if argument \code{generalized} of \code{\link{solve}} is not explicitely
set), \code{\link{solve}} is to use generalized inverses if the original 
\code{solve}-method from package \pkg{base} fails; if the option is \code{FALSE}, 
in case of failure, and unless argument \code{generalized} is not explicitely 
set to \code{TRUE}, \code{solve} will throw an error as is 
the \pkg{base}-method behavior. The default value is \code{TRUE}.  
  }
\item{\code{DistrCollapse.Unique.Warn}}{controls whether there is a warning
      whenever collapsing occurs or when two points are collapsed by a call to
      \code{unique()} (default behaviour if \code{DistrCollapse} is \code{FALSE});
      ---default \code{FALSE}}
\item{\code{warn.makeDNew}}{controls whether a warning is issued once in
      internal utility \code{.makeDNew} standard integration with
      \code{integrate} throws an error---default \code{TRUE}}
}
} 
\examples{
distroptions("RtoDPQ.e") # returns the value of RtoDPQ.e, by default = 5
currentDistrOptions <- distroptions()
distroptions(RtoDPQ.e = 6)
distroptions("RtoDPQ.e") 
getdistrOption("RtoDPQ.e") 
distroptions(c("WarningSim","WarningArith"))   
getdistrOption("WarningSim")   
distroptions("WarningSim" = FALSE)   
         # switches off warnings as to (In)accuracy due to simulations
distroptions("WarningArith" = FALSE) 
         # switches off warnings as to arithmetics
distroptions(currentDistrOptions)
}
\seealso{\code{\link[base]{options}}, \code{\link[base:options]{getOption}}}
\keyword{distribution}
\concept{global options}
\concept{options}
