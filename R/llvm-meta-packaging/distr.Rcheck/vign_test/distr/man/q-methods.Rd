\name{q-methods}
\docType{methods}
\alias{q-methods}
\alias{q}
\alias{q,Distribution-method}
\alias{q.l-methods}
\alias{q.l}
\alias{q.l,Distribution-method}
\title{Methods for Function q in Package `distr'}
\description{q-methods}

\section{Methods}{\describe{
\item{q}{\code{signature(save  = "Distribution")}: returns the
(left-continuous) quantile function, i.e.;
\eqn{{\rm q}(s)=\inf\{t \,\big|\, P({\tt object}\leq t)\geq s\}}{q(s)=inf\{t|P(object<=t)>=s\}}}
\item{q.l}{\code{signature(object  = "Distribution")}: 
from distr-2.6 onwards, we provide this as a synonym for 
method \code{q}; this synonym more explicitely states that we are dealing with
the left-continuous variant of a quantile function. It is useful in particular 
when used from the console in RStudio, as RStudio catches calls to 
\code{q()} and treats them separately from usual R evaluation.  
The developers of RStudio have been asked to fix this and comply with standard 
R evaluation which explicitely allows overloading \code{q()} as we do it in this 
package, but so far have refused to do so, as they claim overloading 
\code{q()} was insane.
}}}
\seealso{
\code{\link{Distribution-class}}, \code{q.r}
}
\examples{
require(distr)
N <- Norm()
q(N)(0.3)
## in RStudio or Jupyter IRKernel, use q.l(.)(.) instead of q(.)(.)
q.l(N)(0.3)
}

\keyword{distribution}
\keyword{methods}
\concept{pseudo-inverse distribution function}
\concept{quantile function}
\concept{accessor function}
\concept{left-continuous}
