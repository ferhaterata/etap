\name{EmpiricalDistribution}
\alias{EmpiricalDistribution}

\title{Generating function "EmpiricalDistribution"}
\description{Generates an object of class  \code{"DiscreteDistribution"}}

\usage{
  EmpiricalDistribution(data, .withArith=FALSE, .withSim=FALSE, 
                        .lowerExact = TRUE, .logExact = FALSE,
                        .DistrCollapse = getdistrOption("DistrCollapse"),
                        .DistrCollapse.Unique.Warn = 
                             getdistrOption("DistrCollapse.Unique.Warn"),
                        .DistrResolution = getdistrOption("DistrResolution"),
                        Symmetry = NoSymmetry())
}
\arguments{
  \item{data}{numeric vector with data. }
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
  The function is a simple utility function providing a wrapper to the 
  generating function \code{\link{DiscreteDistribution}}.

  Typical usage is
  \preformatted{
    EmpiricalDistribution(data)
  }
  
}
\value{Object of class \code{"DiscreteDistribution"}}


\author{
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
}


\seealso{
\code{\link{DiscreteDistribution}}
\code{\link{DiscreteDistribution-class}}
}
\examples{
x <- rnorm(20)
D1 <- EmpiricalDistribution(data = x)
D1

plot(D1)
}
\keyword{distribution}
\concept{empirical distribution}
\concept{generating function}
