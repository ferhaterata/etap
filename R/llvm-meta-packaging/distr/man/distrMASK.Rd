\name{distrMASK}
\alias{distrMASK}
\alias{MASKING}
\title{Masking of/by other functions in package "distr"}
\description{Provides information on the (intended) masking of
and (non-intended) masking by other other functions in package \pkg{distr}}
\usage{
distrMASK(library = NULL)
}
\arguments{
  \item{library}{a character vector with path names of R libraries, or \code{NULL}.
                 The default value of \code{NULL} corresponds to all libraries
                 currently known.  If the default is used, the loaded packages
                 are searched before the libraries}
    }
\value{no value is returned
}

\author{Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}}
\examples{
distrMASK()
}
\keyword{programming}
\keyword{distribution}
\keyword{documentation}
\concept{masking}
\concept{info file}
