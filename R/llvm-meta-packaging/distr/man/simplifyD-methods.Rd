\name{simplifyD-methods}
\docType{methods}
\alias{simplifyD-methods}
\alias{simplifyD}
\alias{simplifyD,AbscontDistribution-method}
\alias{simplifyD,DiscreteDistribution-method}
\alias{simplifyD,UnivarLebDecDistribution-method}
\alias{simplifyD,UnivarMixingDistribution-method}
\title{Methods for function simplifyD in Package `distr' }
\description{simplifyD-methods}
\usage{
simplifyD(object)
}

\arguments{
  \item{object}{distribution object}
}
\value{the corresponding, possibly simplified distribution}
\section{Methods}{\describe{
\item{simplifyD}{\code{signature(object = "AbscontDistribution")}: 
returns \code{object} unchanged}
\item{simplifyD}{\code{signature(object = "DiscreteDistribution")}: 
returns \code{object} unchanged}
\item{simplifyD}{\code{signature(object = "UnivarLebDecDistribution")}: 
checks whether \code{acWeight} or \code{discreteWeight} is approximately
(i.e.; up to \code{getdistrOption("TruncQuantile")}) zero and if so,
accordingly returns \code{discretePart(object)} or \code{acPart(object)},
respectively.}
\item{simplifyD}{\code{signature(object = "UnivarMixingDistribution")}: 
returns the flattened version of \code{object} (using \code{\link{flat.mix}}).
before doing so, it checks whether any component carries weight  approximately
(i.e.; up to \code{getdistrOption("TruncQuantile")}) one (in slot \code{mixCoeff}) 
and if so, returns this component; else, if not all weights are below
\code{getdistrOption("TruncQuantile")}), it filters out those components
with weight less than \code{getdistrOption("TruncQuantile")}).
}}}
\details{generating functions \code{\link{UnivarMixingDistribution}}
\code{\link{Minimum}}, \code{Maximum}, \code{\link{Truncate}}, and
\code{\link{Huberize}} have an argument  \code{withSimplify} which
decides whether the respective result is filtered by/piped through a 
call to \code{simplifyD}.
By default this argument is set to the distr-option 
\code{getdistrOption("simplifyD"} (for the inspection and modification of such
global options see \code{\link{distroptions}}). Depending on whether or not this 
option is \code{TRUE}, also arithmetic operations \code{"+"}, \code{"*"}, \code{"/"},
\code{"^"} and group \code{Math} give results filtered by/piped through a call 
to \code{simplifyD}.}

\seealso{\code{\link{Huberize}}, \code{\link{Minimum}}}
\examples{
set.seed(123)
Mix1 <- UnivarMixingDistribution(Norm(),Binom(2,.3),
  UnivarLebDecDistribution(acPart = Chisq(df = 2), discretePart = Nbinom(3,.09),
                           acWeight = 0.3),
  Norm()-Chisq(df=3), mixCoeff=c(0,0,0.2,0.8), withSimplify = FALSE)
Mix2 <- UnivarMixingDistribution(Norm(),Mix1, DExp(2),
        mixCoeff = c(0,0.2,0.8), withSimplify = FALSE)
Mix2        
simplifyD(Mix2)
}
\keyword{distribution}
\keyword{methods}
\concept{truncation}
