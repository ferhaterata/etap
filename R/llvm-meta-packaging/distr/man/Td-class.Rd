\name{Td-class}
\docType{class}
\alias{Td-class}
\alias{Td}
\alias{initialize,Td-method}

\title{Class "Td"}
\description{  The \eqn{t} distribution with \code{df} \eqn{= \nu}{= n} degrees of
  freedom has density
  \deqn{
    f(x) = \frac{\Gamma ((\nu+1)/2)}{\sqrt{\pi \nu} \Gamma (\nu/2)}
    (1 + x^2/\nu)^{-(\nu+1)/2}%
  }{f(x) = Gamma((n+1)/2) / (sqrt(n pi) Gamma(n/2)) (1 + x^2/n)^-((n+1)/2)}
  for all real \eqn{x}.
  It has mean \eqn{0} (for \eqn{\nu > 1}{n > 1}) and
  variance \eqn{\frac{\nu}{\nu-2}}{n/(n-2)} (for \eqn{\nu > 2}{n > 2}).
 C.f. \code{\link[stats:TDist]{rt}}   
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{Td(df)}.
This object is a \eqn{t} distribution.
}
\section{Slots}{
  \describe{
    \item{\code{img}}{Object of class \code{"Reals"}: The domain of this distribution has got dimension 1
    and the name "Real Space". }
    \item{\code{param}}{Object of class \code{"TParameter"}: the parameter of this distribution (df),
     declared at its instantiation }
    \item{\code{r}}{Object of class \code{"function"}: generates random numbers (calls function \code{rt})}
    \item{\code{d}}{Object of class \code{"function"}: density function (calls function \code{dt})}
    \item{\code{p}}{Object of class \code{"function"}: cumulative function (calls function \code{pt})}
    \item{\code{q}}{Object of class \code{"function"}: inverse of the cumulative function (calls function \code{qt})}
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
Class \code{"AbscontDistribution"}, directly.\cr
Class \code{"UnivariateDistribution"}, by class \code{"AbscontDistribution"}.\cr
Class \code{"Distribution"}, by class \code{"AbscontDistribution"}.
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "Td")}: initialize method }
    \item{df}{\code{signature(object = "Td")}: returns the slot df of the parameter of the distribution }
    \item{df<-}{\code{signature(object = "Td")}: modifies the slot df of the parameter of the distribution }
    \item{ncp}{\code{signature(object = "Td")}: returns the slot ncp of the parameter of the distribution }
    \item{ncp<-}{\code{signature(object = "Td")}: modifies the slot ncp of the parameter of the distribution }
  }
}

\author{
  Thomas Stabla \email{statho3@web.de},\cr 
  Florian Camphausen \email{fcampi@gmx.de},\cr
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},\cr 
  Matthias Kohl \email{Matthias.Kohl@stamats.de}}

\note{  The general \emph{non-central} \eqn{t}
  with parameters \eqn{(\nu,\delta)}{(df,Del)} \code{= (df, ncp)}
  is defined as a the distribution of
  \eqn{T_{\nu}(\delta) := \frac{U + \delta}{\chi_{\nu}/\sqrt{\nu}}}{%
      T(df,Del) := (U + Del) / (Chi(df) / sqrt(df)) }
  where \eqn{U} and \eqn{\chi_{\nu}}{Chi(df)}  are independent random
  variables, \eqn{U \sim {\cal N}(0,1)}{U \~ N(0,1)}, and
%%fails  \eqn{{\chi_{\nu}}^2}{(Chi(df))^2}
  \eqn{\chi^2_\nu}{Chi(df)^2}
  is chi-squared, see \code{\link[stats:Chisquare]{rchisq}}.

  The most used applications are power calculations for \eqn{t}-tests:\cr
  Let \eqn{T= \frac{\bar{X} - \mu_0}{S/\sqrt{n}}}{T= (mX - m0) / (S/sqrt(n))}
  where
  \eqn{\bar{X}}{mX} is the \code{\link{mean}} and \eqn{S} the sample standard
  deviation (\code{\link{sd}}) of \eqn{X_1,X_2,\dots,X_n} which are i.i.d.
%%fails \eqn{{\cal N}(\mu,\sigma^2)}{N(mu,sigma^2)}
        \eqn{       N(\mu,\sigma^2)}{N(mu,sigma^2)}.
  Then \eqn{T} is distributed as non-centrally \eqn{t} with
  \code{df}\eqn{= n-1}
  degrees of freedom and \bold{n}on-\bold{c}entrality \bold{p}arameter
  \code{ncp}\eqn{= (\mu - \mu_0) \sqrt{n}/\sigma}{= (mu - m0) * sqrt(n)/sigma}.

}
\seealso{
\code{\link{TParameter-class}}, 
\code{\link{AbscontDistribution-class}}, 
\code{\link{Reals-class}}, 
\code{\link[stats:TDist]{rt}}
}
\section{Ad hoc methods}{
      For R Version \code{<2.3.0} ad hoc methods are provided for slots \code{q}, \code{r} if \code{ncp!=0};
      for R Version \code{>=2.3.0} the methods from package \pkg{stats} are used.
      }

\examples{
T <- Td(df = 1) # T is a t distribution with df = 1.
r(T)(1) # one random number generated from this distribution, e.g. -0.09697573
d(T)(1) # Density of this distribution is 0.1591549 for x = 1.
p(T)(1) # Probability that x < 1 is 0.75.
q(T)(.1) # Probability that x < -3.077684 is 0.1.
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
df(T) # df of this distribution is 1.
df(T) <- 2 # df of this distribution is now 2.
Tn <- Td(df = 1, ncp = 5) 
  # T is a noncentral t distribution with df = 1 and ncp = 5.
d(Tn)(1) ## from R 2.3.0 on ncp no longer ignored...
}
\keyword{distribution}
\concept{absolutely continuous distribution}
\concept{T distribution}
\concept{S4 distribution class}
\concept{generating function}
