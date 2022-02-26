\name{Fd-class} 
\docType{class}
\alias{Fd-class}
\alias{Fd}
\alias{initialize,Fd-method}

\title{Class "Fd"}
\description{   The F distribution with \code{df1 =} \eqn{n_1}{n1}, by default \code{= 1}, 
  and \code{df2 =} \eqn{n_2}{n2}, by default \code{= 1}, degrees of freedom has density
  \deqn{
    d(x) = \frac{\Gamma(n_1/2 + n_2/2)}{\Gamma(n_1/2)\Gamma(n_2/2)}
    \left(\frac{n_1}{n_2}\right)^{n_1/2} x^{n_1/2 -1}
    \left(1 + \frac{n_1 x}{n_2}\right)^{-(n_1 + n_2) / 2}%
  }{d(x) = Gamma((n1 + n2)/2) / (Gamma(n1/2) Gamma(n2/2))
    (n1/n2)^(n1/2) x^(n1/2 - 1)
    (1 + (n1/n2) x)^-(n1 + n2)/2}
  for \eqn{x > 0}.

  C.f. \code{\link[stats:Fdist]{rf}}
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{Fd(df1, df2)}.
This object is a F distribution.
}
\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Reals"}: The space of the image of this distribution has got dimension 1 and the name "Real Space". }
    \item{\code{param}}{Object of class \code{"FParameter"}: the parameter of this distribution (df1 and df2), declared at its instantiation }
    \item{\code{r}}{Object of class \code{"function"}: generates random numbers (calls function rf)}
    \item{\code{d}}{Object of class \code{"function"}: density function (calls function df)}
    \item{\code{p}}{Object of class \code{"function"}: cumulative function (calls function pf)}
    \item{\code{q}}{Object of class \code{"function"}: inverse of the cumulative function (calls function qf)}
    \item{\code{.withArith}}{logical: used internally to issue warnings as to 
            interpretation of arithmetics}
    \item{\code{.withSim}}{logical: used internally to issue warnings as to 
          accuracy}
    \item{\code{.logExact}}{logical: used internally to flag the case where 
    there are explicit formulae for the log version of density, cdf, and 
    quantile function}
    \item{\code{.lowerExact}}{logical: used internally to flag the case where 
    there are explicit formulae for the lower tail version of cdf and quantile 
    function}
    \item{\code{Symmetry}}{object of class \code{"DistributionSymmetry"};
     used internally to avoid unnecessary calculations.}
  }
}
\section{Extends}{
Class \code{"AbscontDistribution"}, directly. \cr
Class \code{"UnivariateDistribution"}, by class \code{"AbscontDistribution"}. \cr
Class \code{"Distribution"}, by class \code{"AbscontDistribution"}.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "Fd")}: initialize method }
    \item{df1}{\code{signature(object = "Fd")}: returns the slot \code{df1} of the parameter of the distribution }
    \item{df1<-}{\code{signature(object = "Fd")}: modifies the slot \code{df1} of the parameter of the distribution }
    \item{df2}{\code{signature(object = "Fd")}: returns the slot \code{df2} of the parameter of the distribution }
    \item{df2<-}{\code{signature(object = "Fd")}: modifies the slot \code{df2} of the parameter of the distribution }
  }
}

\author{Thomas Stabla \email{statho3@web.de},\cr 
        Florian Camphausen \email{fcampi@gmx.de},\cr
        Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
        Matthias Kohl \email{Matthias.Kohl@stamats.de}}

\note{It is the distribution of the ratio of the mean squares of n1 and n2 independent standard normals, and hence of the
ratio of two independent chi-squared variates each divided by its degrees of freedom. Since the ratio of a normal and the
root mean-square of m independent normals has a Student's \eqn{t_m} distribution, the square of a \eqn{t_m} variate has a F
distribution on 1 and m degrees of freedom. 

The non-central F distribution is again the ratio of mean squares of independent normals of unit variance, but those in the
numerator are allowed to have non-zero means and ncp is the sum of squares of the means. 
}

\section{Ad hoc methods}{\itemize{
\item An ad hoc method is provided for slot \code{d} if \code{ncp!=0}.
\item For R Version \code{<2.3.0} ad hoc methods are provided for slots \code{q}, \code{r} if \code{ncp!=0};
      for R Version \code{>=2.3.0} the methods from package \pkg{stats} are used.
      }}

\seealso{
\code{\link{FParameter-class}}
\code{\link{AbscontDistribution-class}}
\code{\link{Reals-class}}
\code{\link[stats:Fdist]{rf}}
}
\examples{
F <- Fd(df1 = 1, df2 = 1) # F is a F distribution with df=1 and df2=1.
r(F)(1) # one random number generated from this distribution, e.g. 29.37863
d(F)(1) # Density of this distribution is 0.1591549 for x=1 .
p(F)(1) # Probability that x<1 is 0.5.
q(F)(.1) # Probability that x<0.02508563 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
df1(F) # df1 of this distribution is 1.
df1(F) <- 2 # df1 of this distribution is now 2.
Fn <- Fd(df1 = 1, df2 = 1, ncp = 0.5) 
  # Fn is a F distribution with df=1, df2=1 and ncp =0.5.
d(Fn)(1) ## from R 2.3.0 on ncp no longer ignored...
}
\keyword{distribution}
\concept{F distribution}
\concept{absolutely continuous distribution}
\concept{S4 distribution class}
\concept{generating function}
