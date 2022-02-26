\name{operators-methods}
\docType{methods}

\alias{operators-methods}
\alias{operators}
\alias{-,UnivariateDistribution,missing-method}
\alias{-,LatticeDistribution,missing-method}
\alias{-,Norm,missing-method}
\alias{+,UnivariateDistribution,numeric-method}
\alias{+,AbscontDistribution,numeric-method}
\alias{+,DiscreteDistribution,numeric-method}
\alias{+,LatticeDistribution,numeric-method}
\alias{+,UnivarLebDecDistribution,numeric-method}
\alias{+,AffLinAbscontDistribution,numeric-method}
\alias{+,AffLinDiscreteDistribution,numeric-method}
\alias{+,AffLinLatticeDistribution,numeric-method}
\alias{+,AffLinUnivarLebDecDistribution,numeric-method}
\alias{+,CompoundDistribution,numeric-method}
\alias{+,Cauchy,numeric-method}
\alias{+,Dirac,numeric-method}
\alias{+,Norm,numeric-method}
\alias{+,Unif,numeric-method}
\alias{+,numeric,UnivariateDistribution-method}
\alias{+,numeric,LatticeDistribution-method}
%%\alias{-,UnivariateDistribution,ANY-method}
\alias{-,UnivariateDistribution,numeric-method}
\alias{-,UnivariateDistribution,UnivariateDistribution-method}
\alias{-,LatticeDistribution,numeric-method}
\alias{-,LatticeDistribution,LatticeDistribution-method}
\alias{-,LatticeDistribution,UnivariateDistribution-method}
\alias{-,UnivariateDistribution,LatticeDistribution-method}
\alias{-,AcDcLcDistribution,AcDcLcDistribution-method}
\alias{-,numeric,UnivariateDistribution-method}
\alias{-,numeric,LatticeDistribution-method}
\alias{*,UnivariateDistribution,numeric-method}
\alias{*,AbscontDistribution,numeric-method}
\alias{*,DiscreteDistribution,numeric-method}
\alias{*,LatticeDistribution,numeric-method}
\alias{*,UnivarLebDecDistribution,numeric-method}
\alias{*,CompoundDistribution,numeric-method}
\alias{*,AffLinAbscontDistribution,numeric-method}
\alias{*,AffLinDiscreteDistribution,numeric-method}
\alias{*,AffLinLatticeDistribution,numeric-method}
\alias{*,AffLinUnivarLebDecDistribution,numeric-method}
\alias{*,DExp,numeric-method}
\alias{*,Exp,numeric-method}
\alias{*,ExpOrGammaOrChisq,numeric-method}
\alias{*,Weibull,numeric-method}
\alias{*,Cauchy,numeric-method}
\alias{*,Dirac,numeric-method}
\alias{*,Norm,numeric-method}
\alias{*,Logis,numeric-method}
\alias{*,Lnorm,numeric-method}
\alias{*,Unif,numeric-method}
\alias{*,numeric,UnivariateDistribution-method}
\alias{*,numeric,LatticeDistribution-method}
\alias{/,UnivariateDistribution,numeric-method}
\alias{/,LatticeDistribution,numeric-method}
\alias{+,UnivariateDistribution,UnivariateDistribution-method}
\alias{+,AbscontDistribution,AbscontDistribution-method}
\alias{+,AbscontDistribution,DiscreteDistribution-method}
\alias{+,DiscreteDistribution,AbscontDistribution-method}
\alias{+,DiscreteDistribution,DiscreteDistribution-method}
\alias{+,LatticeDistribution,DiscreteDistribution-method}
\alias{+,LatticeDistribution,LatticeDistribution-method}
\alias{+,UnivarLebDecDistribution,UnivarLebDecDistribution-method}
\alias{+,AcDcLcDistribution,AcDcLcDistribution-method}
\alias{+,Binom,Binom-method}
\alias{+,Cauchy,Cauchy-method}
\alias{+,Chisq,Chisq-method}
\alias{+,Dirac,Dirac-method}
\alias{+,ExpOrGammaOrChisq,ExpOrGammaOrChisq-method}
\alias{+,Pois,Pois-method}
\alias{+,Nbinom,Nbinom-method}
\alias{+,Norm,Norm-method}
\alias{+,Logis,numeric-method}
\alias{+,Dirac,UnivariateDistribution-method}
\alias{+,Dirac,DiscreteDistribution-method}
\alias{+,UnivariateDistribution,Dirac-method}
\alias{-,numeric,Beta-method}
\alias{-,Dirac,Dirac-method}
\alias{*,Dirac,Dirac-method}
\alias{*,Dirac,UnivariateDistribution-method}
\alias{*,UnivariateDistribution,Dirac-method}
\alias{*,AcDcLcDistribution,AcDcLcDistribution-method}
\alias{/,Dirac,Dirac-method}
\alias{/,numeric,Dirac-method}
\alias{/,numeric,AcDcLcDistribution-method}
\alias{/,AcDcLcDistribution,AcDcLcDistribution-method}
\alias{^,AcDcLcDistribution,numeric-method}
\alias{^,AcDcLcDistribution,Integer-method}
\alias{^,AcDcLcDistribution,AcDcLcDistribution-method}
\alias{^,numeric,AcDcLcDistribution-method}



\title{Methods for operators +,-,*,/,... in Package distr}

\description{Arithmetics and unary mathematical transformations for distributions}

\details{Arithmetics as well as all functions from group \code{Math}, see \code{\link[methods:S4groupGeneric]{Math}}
are provided for distributions; wherever possible exact expressions are used; else 
random variables are generated according to this transformation and subsequently the remaining
slots filled by \code{\link{RtoDPQ}}, \code{\link{RtoDPQ.d}}}

\section{Methods}{\describe{
\item{\code{-}}{\code{signature(e1 = "UnivariateDistribution", e2 = "missing")} unary operator; result again of class \code{"UnivariateDistribution"}; exact}
\item{\code{-}}{\code{signature(e1 = "Norm", e2 = "missing")} unary operator; result again of \code{"Norm"}; exact}
\item{\code{+}}{\code{signature(e1 = "UnivariateDistribution", e2 = "numeric")} result again of class \code{"UnivariateDistribution"}; exact}
\item{\code{+}}{\code{signature(e1 = "AbscontDistribution", e2 = "numeric")} result of 
 class \code{"AffLinAbscontDistribution"}; exact}
\item{\code{+}}{\code{signature(e1 = "DiscreteDistribution", e2 = "numeric")} result of 
 class \code{"AffLinDiscreteDistribution"}; exact}
\item{\code{+}}{\code{signature(e1 = "LatticeDistribution", e2 = "numeric")} result  of 
 class \code{"AffLinLatticeDistribution"}; exact}
\item{\code{+}}{\code{signature(e1 = "UnivarLebDecDistribution", e2 = "numeric")} result of 
 class \code{"AffLinUnivarLebDecDistribution"}; exact}
\item{\code{+}}{\code{signature(e1 = "CompoundDistribution", e2 = "numeric")} result of 
 class \code{"AffLinUnivarLebDecDistribution"}; exact}
\item{\code{+}}{\code{signature(e1 = "AffLinAbscontDistribution", e2 = "numeric")} result again of 
 class \code{"AffLinAbscontDistribution"}; exact}
\item{\code{+}}{\code{signature(e1 = "AffLinDiscreteDistribution", e2 = "numeric")} result again of 
 class \code{"AffLinDiscreteDistribution"}; exact}
\item{\code{+}}{\code{signature(e1 = "AffLinLatticeDistribution", e2 = "numeric")} result again of 
 class \code{"AffLinLatticeDistribution"}; exact}
\item{\code{+}}{\code{signature(e1 = "AffLinUnivarLebDecDistribution", e2 = "numeric")} result of 
 class \code{"AffLinUnivarLebDecDistribution"}; exact}
\item{\code{+}}{\code{signature(e1 = "Cauchy", e2 = "numeric")} result again of class \code{"Cauchy"}; exact}
\item{\code{+}}{\code{signature(e1 = "Dirac", e2 = "numeric")} result again of class \code{"Dirac"}; exact}
\item{\code{+}}{\code{signature(e1 = "Norm", e2 = "numeric")} result again of class \code{"Norm"}; exact}
\item{\code{+}}{\code{signature(e1 = "Unif", e2 = "numeric")} result again of class \code{"Unif"}; exact}
\item{\code{+}}{\code{signature(e1 = "Logis", e2 = "numeric")}  result again of class \code{"Logis"}; exact}
\item{\code{+}}{\code{signature(e1 = "numeric", e2 = "UnivariateDistribution")} is translated to  
         \code{signature(e1 = "UnivariateDistribution", e2 = "numeric")}; exact}
\item{\code{-}}{\code{signature(e1 = "UnivariateDistribution", e2= "ANY")};exact}
\item{\code{-}}{\code{signature(e1 = "UnivariateDistribution", e2 = "numeric")} is translated to 
 \code{e1 + (-e2)}; exact}
\item{\code{-}}{\code{signature(e1 = "numeric", e2 = "UnivariateDistribution")} is translated to \code{(-e1) + e2}; exact}
\item{\code{-}}{\code{signature(e1 = "numeric", e2 = "Beta")} if \code{ncp(e2)==0} and \code{e1 == 1},
an exact (central) \code{Beta(shape1 = shape2(e2), shape2 = shape1(e2))} is returned, else
the default method is used; exact}
\item{\code{*}}{\code{signature(e1 = "UnivariateDistribution", e2 = "numeric")} result again of class \code{"UnivariateDistribution"}; exact}
\item{\code{*}}{\code{signature(e1 = "AbscontDistribution", e2 = "numeric")} result of 
 class \code{"AffLinAbscontDistribution"}; exact}
\item{\code{*}}{\code{signature(e1 = "DiscreteDistribution", e2 = "numeric")} result of 
 class \code{"AffLinDiscreteDistribution"}; exact}
\item{\code{*}}{\code{signature(e1 = "LatticeDistribution", e2 = "numeric")} result  of 
 class \code{"AffLinLatticeDistribution"}; exact}
\item{\code{*}}{\code{signature(e1 = "UnivarLebDecDistribution", e2 = "numeric")} result of 
 class \code{"AffLinUnivarLebDecDistribution"}; exact}
\item{\code{*}}{\code{signature(e1 = "CompoundDistribution", e2 = "numeric")} result of 
 class \code{"AffLinUnivarLebDecDistribution"}; exact}
\item{\code{*}}{\code{signature(e1 = "AffLinAbscontDistribution", e2 = "numeric")} result again of 
 class \code{"AffLinAbscontDistribution"}; exact}
\item{\code{*}}{\code{signature(e1 = "AffLinDiscreteDistribution", e2 = "numeric")} result again of 
 class \code{"AffLinDiscreteDistribution"}; exact}
\item{\code{*}}{\code{signature(e1 = "AffLinLatticeDistribution", e2 = "numeric")} result again of 
 class \code{"AffLinLatticeDistribution"}; exact}
\item{\code{*}}{\code{signature(e1 = "AffLinUnivarLebDecDistribution", e2 = "numeric")} result of 
 class \code{"AffLinUnivarLebDecDistribution"}; exact}
\item{\code{*}}{\code{signature(e1 = "DExp", e2 = "numeric")} if \code{abs(e2)>0} result again of class \code{"DExp"}; exact}
\item{\code{*}}{\code{signature(e1 = "Exp", e2 = "numeric")} if \code{e2>0} result again of class \code{"Exp"}; exact}
\item{\code{*}}{\code{signature(e1 = "ExpOrGammaOrChisq", e2 = "numeric")} if \code{e1} is a Gamma distribution and \code{e2>0} 
                                                                    result of class \code{"Gammad"}; exact}
\item{\code{*}}{\code{signature(e1 = "Weibull", e2 = "numeric")} if \code{e2>0} 
                                                                    result of class \code{"Weibull"}; exact}
\item{\code{*}}{\code{signature(e1 = "Cauchy", e2 = "numeric")}  if \code{abs(e2)>0} result again of class \code{"Cauchy"}; exact}
\item{\code{*}}{\code{signature(e1 = "Dirac", e2 = "numeric")}  result again of class \code{"Dirac"}; exact}
\item{\code{*}}{\code{signature(e1 = "Norm", e2 = "numeric")}  if \code{abs(e2)>0} result again of class \code{"Norm"}; exact}
\item{\code{*}}{\code{signature(e1 = "Unif", e2 = "numeric")}  if \code{abs(e2)>0} result again of class \code{"Unif"}; exact}
\item{\code{*}}{\code{signature(e1 = "Logis", e2 = "numeric")}  if \code{e2>0} result again of class \code{"Logis"}; exact}
\item{\code{*}}{\code{signature(e1 = "Lnorm", e2 = "numeric")}  if \code{e2>0} result again of class \code{"Lnorm"}; exact}
\item{\code{*}}{\code{signature(e1 = "numeric", e2 = "UnivariateDistribution")} is translated to 
         \code{signature(e1 = "UnivariateDistribution", e2 = "numeric")}; exact}
\item{\code{/}}{\code{signature(e1 = "UnivariateDistribution", e2 = "numeric")} is translated to \code{e1 * (1/e2)}; exact}
\item{\code{+}}{\code{signature(e1 = "UnivariateDistribution", e2 = "UnivariateDistribution")}  result again of class 
         \code{"UnivariateDistribution"}; is generated by simulations}
\item{\code{-}}{\code{signature(e1 = "UnivariateDistribution", e2 = "UnivariateDistribution")} is translated to \code{(-e1) + (-e2)}; 
          result again of class   \code{"UnivariateDistribution"}; is generated by simulations}
\item{\code{-}}{\code{signature(e1 = "AcDcLcDistribution", e2 = "AcDcLcDistribution")}: both operands are coerced
                to class \code{"UnivarLebDecDistribution"} and the corresponding method is used.
                }
\item{\code{+}}{\code{signature(e1 = "AbscontDistribution", e2 = "AbscontDistribution")} assumes \code{e1}, \code{e2} independent; result again of class 
         \code{"AbscontDistribution"}; is generated by FFT}
\item{\code{+}}{\code{signature(e1 = "AbscontDistribution", e2 = "DiscreteDistribution")} assumes \code{e1}, \code{e2} independent; result again of class 
         \code{"AbscontDistribution"}; is generated by FFT}
\item{\code{+}}{\code{signature(e1 = "DiscreteDistribution", e2 = "AbscontDistribution")} assumes \code{e1}, \code{e2} independent; result again of class 
         \code{"AbscontDistribution"}; is generated by FFT}
\item{\code{+}}{\code{signature(e1 = "LatticeDistribution", e2 = "LatticeDistribution")} assumes \code{e1}, \code{e2} independent; 
if the larger lattice-width is an integer multiple of the smaller(in abs. value) one: result again of class 
         \code{"LatticeDistribution"}; is generated by D/FFT}
\item{\code{+}}{\code{signature(e1 = "DiscreteDistribution", e2 = "DiscreteDistribution")} assumes \code{e1}, \code{e2} independent; result again of class 
         \code{"DiscreteDistribution"}; is generated by explicite convolution}
\item{\code{+}}{\code{signature(e1 = "LatticeDistribution", e2 = "DiscreteDistribution")} assumes \code{e1}, \code{e2} independent; result again of class 
         \code{"DiscreteDistribution"}; is generated by explicite convolution}
\item{\code{+}}{\code{signature(e1 = "UnivarLebDecDistribution", e2 = "UnivarLebDecDistribution")} assumes \code{e1}, \code{e2} independent; result again of class 
         \code{"UnivarLebDecDistribution"}; is generated by separate explicite convolution of a.c. and discrete parts of \code{e1} and \code{e2}
         and subsequent flattening with \code{\link{flat.LCD}}; if \code{getdistrOption("withSimplify")} is  \code{TRUE}, result is piped
         through a call to \code{\link{simplifyD}}}
\item{\code{+}}{\code{signature(e1 = "AcDcLcDistribution", e2 = "AcDcLcDistribution")}: both operands are coerced
                to class \code{"UnivarLebDecDistribution"} and the corresponding method is used.
                }
\item{\code{+}}{\code{signature(e1 = "Binom", e2 = "Binom")} assumes \code{e1}, \code{e2} independent; 
if \code{prob(e1)==prob(e2)}, result again of class 
         \code{"Binom"}; uses the convolution formula for binomial distributions; exact}
\item{\code{+}}{\code{signature(e1 = "Cauchy", e2 = "Cauchy")}  assumes \code{e1}, \code{e2} independent; result again of class 
         \code{"Cauchy"}; uses the convolution formula for Cauchy distributions; exact}
\item{\code{+}}{\code{signature(e1 = "Chisq", e2 = "Chisq")}  assumes \code{e1}, \code{e2} independent; result again of class 
         \code{"Chisq"}; uses the convolution formula for Chisq distributions; exact}
\item{\code{+}}{\code{signature(e1 = "Dirac", e2 = "Dirac")} result again of class \code{"Dirac"}; exact}
\item{\code{+}}{\code{signature(e1 = "ExpOrGammaOrChisq", e2 = "ExpOrGammaOrChisq")}  assumes \code{e1}, \code{e2} independent; if 
         \code{e1}, \code{e2} are Gamma distributions, result is of class 
         \code{"Gammad"}; uses the convolution formula for Gamma distributions; exact}
\item{\code{+}}{\code{signature(e1 = "Pois", e2 = "Pois")}  assumes \code{e1}, \code{e2} independent; result again of class 
         \code{"Pois"}; uses the convolution formula for Poisson distributions; exact}
\item{\code{+}}{\code{signature(e1 = "Nbinom", e2 = "Nbinom")}  assumes \code{e1}, \code{e2} independent; if 
\code{prob(e1)==prob(e2)}, result again of class 
         \code{"Nbinom"}; uses the convolution formula for negative binomial distributions; exact}
\item{\code{+}}{\code{signature(e1 = "Norm", e2 = "Norm")}  assumes \code{e1}, \code{e2} independent; result again of class 
         \code{"Norm"}; uses the convolution formula for normal distributions; exact}
\item{\code{+}}{\code{signature(e1 = "UnivariateDistribution", e2 = "Dirac")}  translated to \code{e1 + location(e2)}; 
         result again of class \code{"Dirac"}; exact}
\item{\code{+}}{\code{signature(e1 = "Dirac", e2 = "UnivariateDistribution")}  translated to \code{e2 + location(e1)}; 
         result again of class \code{"Dirac"}; exact}
\item{\code{+}}{\code{signature(e1 = "Dirac", e2 = "DiscreteDistribution")}  translated to \code{e2 + location(e1)}; 
         result again of class \code{"Dirac"}; exact}
\item{\code{-}}{\code{signature(e1 = "Dirac", e2 = "Dirac")}  result again of class \code{"Dirac"}; exact}
\item{\code{*}}{\code{signature(e1 = "Dirac", e2 = "Dirac")}  result again of class \code{"Dirac"}; exact}
\item{\code{*}}{\code{signature(e1 = "UnivariateDistribution", e2 = "Dirac")}  translated to \code{e1 * location(e2)}; 
         result again of class \code{"Dirac"}; exact}
\item{\code{*}}{\code{signature(e1 = "Dirac", e2 = "UnivariateDistribution")}  translated to \code{e2 * location(e1)}; 
         result again of class \code{"Dirac"}; exact}
\item{\code{*}}{\code{signature(e1 = "AcDcLcDistribution", e2 = "AcDcLcDistribution")}: by means of \code{\link{decomposePM}}
                \code{e1} and \code{e2} are decomposed into positive and negative parts; of these, convolutions of the
                corresponding logarithms are computed separately and finally \code{exp} is applied to them, again separately;
                the resulting mixing components are then ``flattened'' to one object of class 
                \code{UnivarLebDecDistribution} by \code{\link{flat.LCD}} which according to \code{getdistrOption(withSimplify)} 
                gets piped through a call to \code{\link{simplifyD}}.
                }
\item{\code{/}}{\code{signature(e1 = "Dirac", e2 = "Dirac")}  result again of class \code{"Dirac"}; exact}
\item{\code{/}}{\code{signature(e1 = "numeric", e2 = "Dirac")}  result again of class \code{"Dirac"}; exact}
\item{\code{/}}{\code{signature(e1 = "numeric", e2 = "AcDcLcDistribution")}: if \code{d.discrete(e2)(0)*discreteWeight(e2)>0}
                throws an error (would give division by 0 with positive probability); else by means of \code{\link{decomposePM}}
                \code{e2} is decomposed into positive and negative parts; then, similarly the result obtains as for 
                \code{"*"(signature(e1 = "AcDcLcDistribution", e2 = "AcDcLcDistribution"))} by the exp-log trick
                and is ``flattened'' to one object of class 
                \code{UnivarLebDecDistribution} by \code{\link{flat.LCD}} and 
                according to \code{getdistrOption(withSimplify)} is piped through
                a call to \code{\link{simplifyD}}; exact..
                }
\item{\code{/}}{\code{signature(e1 = "AcDcLcDistribution", e2 = "AcDcLcDistribution")}: translated to \code{e1 * (1/e2)}.
                }
\item{\code{^}}{\code{signature(e1 = "AcDcLcDistribution", e2 = "Integer")}: if \code{e2=0} returns \code{Dirac(1)};
                if \code{e2=1} returns \code{e1}; if \code{e2<0} translated to \code{(1/e1)^(-e2)}; exact. 
                }
\item{\code{^}}{\code{signature(e1 = "AcDcLcDistribution", e2 = "numeric")}: if \code{e2} is integer uses preceding
                item; else if \code{e1< 0} with positive probability, throughs an error; else
                the result obtains similarly to 
                \code{"*"(signature(e1 = "AcDcLcDistribution", e2 = "AcDcLcDistribution"))} by the exp-log trick
                and is ``flattened'' to one object of class 
                \code{UnivarLebDecDistribution} by \code{\link{flat.LCD}} and 
                according to \code{getdistrOption(withSimplify)} is piped through
                a call to \code{\link{simplifyD}}; exact.
                }
\item{\code{^}}{\code{signature(e1 = "AcDcLcDistribution", e2 = "AcDcLcDistribution")}: 
                if \code{e1} is negative with positive probability, 
                throws an error if \code{e2} is non-integer
                with positive probability; if \code{e1} is 0 with positive probability
                throws an error if \code{e2} is non-integer with positive probability. 
                if  \code{e2} is integer with probability 1 uses 
                \code{DiscreteDistribution(supp=e1^(Dirac(x))} for each \code{x} in \code{support(e2)},
                builds up a corresponding mixing distribution; the latter is ``flattened'' to one object of class 
                \code{UnivarLebDecDistribution} by \code{\link{flat.LCD}} and 
                according to \code{getdistrOption(withSimplify)} is piped through
                a call to \code{\link{simplifyD}}.
                Else the result obtains similarly to \code{"*"(signature(e1 = "AcDcLcDistribution", 
                e2 = "AcDcLcDistribution"))} by the exp-log trick
                and is ``flattened'' to one object of class 
                \code{UnivarLebDecDistribution} by \code{\link{flat.LCD}} and 
                according to \code{getdistrOption(withSimplify)} is piped through
                a call to \code{\link{simplifyD}}; exact.
                }
\item{\code{^}}{\code{signature(e1 = "numeric", e2 = "AcDcLcDistribution")}: 
                if \code{e1} is negative, throws an error if \code{e2} is non-integer
                with positive probability; if \code{e1} is 0 throws an error if
                \code{e2} is non-integer with positive probability. 
                if  \code{e2} is integer with probability 1 uses 
                \code{DiscreteDistribution(supp=e1^support(e2), prob=discrete.d(supp))}
                else the result obtains similarly to \code{"*"(signature(e1 = "AcDcLcDistribution", 
                e2 = "AcDcLcDistribution"))} by the exp-log trick
                and is ``flattened'' to one object of class 
                \code{UnivarLebDecDistribution} by \code{\link{flat.LCD}} and 
                according to \code{getdistrOption(withSimplify)} is piped through
                a call to \code{\link{simplifyD}}; exact.
                }
}}

\seealso{
\code{\link{UnivariateDistribution-class}}
\code{\link{AbscontDistribution-class}} \cr
\code{\link{DiscreteDistribution-class}}
\code{\link{LatticeDistribution-class}}\cr
\code{\link{Norm-class}}
\code{\link{Binom-class}}
\code{\link{Pois-class}}
\code{\link{Dirac-class}}\cr
\code{\link{Cauchy-class}}
\code{\link{Gammad-class}}
\code{\link{Logis-class}}
\code{\link{Lnorm-class}}\cr
\code{\link{Exp-class}}
\code{\link{Weibull-class}}
\code{\link{Nbinom-class}}
}

\arguments{
  \item{e1,e2}{ objects of class \code{"UnivariateDistribution"} (or subclasses) or \code{"numeric"}}
}
\examples{
N <- Norm(0,3)
P <- Pois(4)
a <- 3
N + a
N + P
N - a
a * N
a * P
N / a + sin( a * P - N)
N * P
N / N
\donttest{
## takes a little time
N ^ P
}
1.2 ^ N
abs(N) ^ 1.3
}
\references{
Ruckdeschel, P., Kohl, M.(2014):
   General purpose convolution algorithm for distributions 
  in S4-Classes by means of FFT. \emph{J. Statist. Softw.}
  \bold{59}(4): 1-25.
}

\keyword{math}
\keyword{distribution}
\keyword{arith}
\concept{convolution}
\concept{FFT}
\concept{affine linear}
\concept{image distribution}
