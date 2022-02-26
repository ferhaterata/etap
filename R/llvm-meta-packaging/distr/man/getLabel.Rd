\name{getLabel}
\alias{getLabel}
\title{Labels for distribution objects}
\description{
a help function to get reasonable labels for distribution objects}
\usage{
getLabel(x, withnames = TRUE)
}
\arguments{
  \item{x}{ a distribution object}
  \item{withnames}{ logical: are the parameters (if any) of \code{x} to be 
        displayed with names? }
}

\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de}}

\section{Remark}{The need for this helper function (external to our 
        \code{plot} methods) was brought to our attention in a mail 
        by Kouros Owzar \email{owzar001@mc.duke.edu}.}

\seealso{\code{\link[distr]{plot-methods}}} 
\examples{
## example due to Kouros Owzar:
foo<- function(law,n, withnames = TRUE)
  {
    data.frame(muhat=mean(r(law)(n)),n=n,law= getLabel(law,withnames))
  } 
### a function that groups certain informations on 
##  created with distribution objects
do.call("rbind",lapply(list(Exp(1),Norm(0,1),Weibull(1,1)),foo,n=100))
do.call("rbind",lapply(list(Exp(1),Norm(0,1),Weibull(1,1)),foo,n=100,FALSE))
}
\keyword{distribution}
\concept{utility}
