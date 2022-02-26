\name{options}
\alias{options}
\alias{newDevice}

\title{
  additional options in package `distr'
}
\description{
  In package \pkg{distr}, we add an extra option \code{"newDevice"};
  it is inspected and manipulated as usual.
}
\details{We do not change the behaviour of \code{options} or \code{getOption};
for the general documentation to these two functions, 
confer \code{\link[base]{options}}, \code{\link[base:options]{getOption}}. Here
we only document added options.}
\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}}

\section{Additionally available options in package 'distr'}{
\describe{
\item{\code{"newDevice"}}{logical; controls behaviour when generating several plots within
one function; if \code{TRUE}, before each call to  call to \code{\link[graphics:frame]{plot.new}},
a call to \code{\link{devNew}} is inserted; if \code{FALSE}, we reproduce the usual behaviour
in \pkg{graphics}, i.e.; we do not call \code{\link{devNew}}. Defaults to \code{FALSE}.}
}
} 
\examples{
getOption("newDevice") 
options("newDevice"=TRUE) 
}
\seealso{\code{\link[base]{options}}, \code{\link[base:options]{getOption}}}
\keyword{environment}
\keyword{iplot}
\keyword{dplot}
\concept{global options}
\concept{options}
