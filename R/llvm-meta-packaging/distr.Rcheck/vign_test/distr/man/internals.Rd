\name{internals_for_distr}
\alias{internals_for_distr}
\alias{.is.vector.lattice}
\alias{.is.consistent}
\alias{.isInteger}
\alias{.isNatural}
\alias{.isNatural0}
\alias{.mergegaps}
\alias{.mergegaps2}
\alias{.pmixfun}
\alias{.dmixfun}
\alias{.qmixfun}
\alias{.rmixfun}
\alias{.del0dmixfun}
\alias{.ULC.cast}
\alias{.loupmixfun}
\alias{.make.lattice.es.vector}
\alias{.presubs}
\alias{.inArgs}
\alias{.EuclidAlgo}
\alias{.getCommonWidth}
\alias{.isEqual}
\alias{.isIn}
\alias{.setEqual}
\alias{.isEqual01}
\alias{.makeD}
\alias{.makeP}
\alias{.makeQ}
\alias{.makeDNew}
\alias{.makePNew}
\alias{.makeQNew}
\alias{.makeDd}
\alias{.makePd}
\alias{.makeQd}
\alias{.makeQc}
\alias{.fM2}
\alias{.fM}
\alias{.fm}
\alias{.notwithLArg}
\alias{.multm}
\alias{.plusm}
\alias{.getObjName}
\alias{.discretizeP}
\alias{.expm.d}
\alias{.expm.c}
\alias{.logm.d}
\alias{.logm.c}
\alias{.P2D}
\alias{.P2Q}
\alias{.D2P}
\alias{.Q2P}
\alias{.csimpsum}
\alias{.primefun}
\alias{.IssueWarn}
\alias{.fillList}
\alias{.trunc.up}
\alias{.trunc.low}
\alias{.modifyqgaps}
\alias{.DistrCollapse}
\alias{.convDiscrDiscr}
\alias{.inWithTol}
\alias{.panel.mingle}
\alias{devNew}

\title{Internal functions of package distr}

\description{
These functions are used internally by package distr.}

\usage{
.is.vector.lattice(x)
.is.consistent(lattice, support, eq.space = TRUE)
.make.lattice.es.vector(x)
.inArgs(arg, fct)
.isEqual(p0, p1, tol = min( getdistrOption("TruncQuantile")/2,
                                          .Machine$double.eps^.7))
.isEqual01(x)
.isIn(p0, pmat, tol = min( getdistrOption("TruncQuantile")/2,
                                          .Machine$double.eps^.7
                                          ))
.isInteger(x, tol = .Machine$double.eps)
.isNatural(x, tol = .Machine$double.eps)
.isNatural0(x, tol = .Machine$double.eps)
.setEqual(x, y, tol = 1e-7)
.presubs(inp, frompat, topat)
.makeD(object, argList,  stand = NULL, fac = NULL)
.makeP(object, argList,  sign = TRUE, correct = NULL, fac =
                 NULL, fac2 = NULL)
.makeQ(object, lastCall, sign = TRUE, Cont = TRUE)
.plusm(e1, e2, Dclass = "DiscreteDistribution")
.multm(e1, e2, Dclass = "DiscreteDistribution")
.notwithLArg(D)
.getObjName(i = 1)
.discretizeP(D, lower, upper, h)
.fm(x,f)
.fM(x,f)
.fM2(x,f)
.makeDd(x,y, yleft, yright)
.makePd(x,y, yleft, yright)
.makeQd(x,y, yleft, yright)
.makeQc(x,y, yleft, yright)
.makeDNew(x, dx, h = NULL, Cont = TRUE, standM = "sum")
.makePNew(x, dx, h = NULL, notwithLLarg = FALSE,
                      Cont = TRUE, myPf = NULL, pxl = NULL, pxu = NULL)
.makeQNew(x, px.l, px.u, notwithLLarg = FALSE, yL , yR, Cont = TRUE)
.mergegaps(gaps, support)
.mergegaps2(gaps1, gaps2)
.consolidategaps(gaps)
.pmixfun(mixDistr, mixCoeff, leftright = "right")
.dmixfun(mixDistr, mixCoeff, withStand = FALSE, supp = NULL)
.rmixfun(mixDistr, mixCoeff)
.qmixfun(mixDistr, mixCoeff, Cont = TRUE, pnew, gaps = NULL, leftright = "left")
.del0dmixfun(mixDistr)
.loupmixfun(mixDistr)
.ULC.cast(x)
.expm.d(e1)
.expm.c(e1)
.logm.d(e1)
.logm.c(e1)
.P2D (p, xx, ql, qu, ngrid = getdistrOption("DefaultNrGridPoints"))
.P2Q (p, xx, ql,qu, ngrid = getdistrOption("DefaultNrGridPoints"), 
                qL = -Inf, qU = Inf)
.D2P (d, xx, ql, qu,  ngrid = getdistrOption("DefaultNrGridPoints"))
.Q2P (q, ngrid = getdistrOption("DefaultNrGridPoints"))
.csimpsum(fx)
.primefun(f,x, nm = NULL)
.IssueWarn(Arith,Sim)
.List(list0)
.fillList(list0, len=length(list0))
.trunc.up(object, upper)
.trunc.low(object, lower)
.modifyqgaps(pfun, qfun, gaps, leftright = "left")
.DistrCollapse(support, prob, eps = getdistrOption("DistrResolution"))
.EuclidAlgo(n1,n2)
.getCommonWidth(x1,x2, tol=.Machine$double.eps)
.convDiscrDiscr(e1,e2)
.inWithTol(x,y,tol=.Machine$double.eps)
.panel.mingle(dots,element)
devNew(...)
}


\arguments{
  \item{x}{a (numeric) vector, or (in case of \code{.ULC.cast}) an object of class \code{"AcDcLcDistribution"}}
  \item{y}{a (numeric) vector}
  \item{f}{a function in one (numeric) argument}
  \item{lattice}{a lattice (of class \code{Lattice})}
  \item{support}{a support vector}
  \item{eq.space}{logical: shall we check for the support to be equally spaced?} 
  \item{arg}{a formal argument as character}
  \item{fct}{a function}
  \item{p0,p1}{(numeric) vectors} 
  \item{pmat}{(matrix) a matrix with two columns where row-wise the left column
              is smaller than the right one} 
  \item{tol}{an error tolerance (numeric)}
  \item{e1}{a distribution object}
  \item{e2}{a numeric}
  \item{object}{a distribution object}  
  \item{argList}{an (unevaluated) list of arguments passed to \code{m(object)}  
        where  \code{m} is in \code{d,p,q}}
  \item{stand}{factor for a (Lebesgue) density to integrate to 1}
  \item{sign}{the sign of the second operand --- for multiplication at 
               the moment}
  \item{correct}{unevaluated R-code to correct for right-continuity 
                  (for multiplication with negative numerics at the moment)}
  \item{fac}{factor to be multiplied with the return value}
  \item{fac2}{factor to be added to the return value}
  \item{lastCall}{unevaluated R-Code ---gives how the result of a call to 
                   \code{q(e1)} is further transformed}
  \item{Cont}{logical: \code{TRUE} if \code{object} is continuous}
  \item{DClass}{character: name of distribution class}
  \item{D}{a distribution object}
  \item{i}{an integer}
  \item{yleft, yright}{extrapolation value beyond left/right endpoint of grid}
  \item{h}{numeric: grid width}
  \item{standM}{standardization method --- summation or integration}
  \item{notwithLLarg}{logical --- can we use \code{log.p}, \code{lower.tail} 
  arguments for \code{p,q}-methods of first operand?}
  \item{dx}{numeric: vector of cell-probabilities for the (discretized) 
  distribution}
  \item{myPf}{function with args \code{x,y, yleft, yright} 
  (as \code{approxfun}): 
              if given: replaces \code{approxfun} as interpolation method for 
              continuos distributions}
  \item{pxl,pxu}{numeric: if given vector of (lower/upper) cumulative 
  probabilities}
  \item{yL, yR}{argmin / argmax of p()-method}
  \item{inp}{either a language object or a character vector}
  \item{frompat}{vector of character strings containing regular expressions (or
          character string for \code{fixed = TRUE}) to be matched in the
          given character vector.  Coerced by \code{as.character} to a
          character string if possible; (as argument \code{pattern} in 
          \code{\link{gsub}} --- but possibly of length >1).}
  \item{topat}{ a (vector of) replacement(s) for matched pattern in 
          \code{.presubs}. 
          Coerced to character if possible.  For \code{fixed = FALSE} this
          can include backreferences \code{"\\1"} to \code{"\\9"} to 
          parenthesized subexpressions of \code{pattern}.  For 
          \code{perl = TRUE} only, it can
          also contain \code{"\\U"} or \code{"\\L"} to convert the rest of the
          replacement to upper or lower case; (as argument \code{replacement} 
          in \code{\link{gsub}}--- but possibly of length >1).}
 \item{gaps,gaps1,gaps2}{matrices \code{m} with two columns, 
             such that \code{t(m)}, interpreted as vector, is ordered}         
 \item{support}{support vector of a univariate discrete distribution}         
 \item{prob}{probability vector for a univariate discrete distribution}         
 \item{mixDistr}{an object of class \code{UnivarDistrList}}
 \item{mixCoeff}{an object of class \code{numeric}; a probability vector}
 \item{pnew}{a function \code{function(q, lower.tail = TRUE, log.p = FALSE}
 realizing slot \code{p} in a distribution object.}
 \item{withStand}{logical; if \code{TRUE} a standardization is made such
 that the sum of the values of the result evaluated at argument \code{supp} is 1}
 \item{supp}{NULL or \code{numeric}; if \code{withStand} is \code{TRUE} used
 to standardize such that the result is a probability density.}
 \item{p,pfun}{slot \code{p} of an object of class \code{"AbscontDistribution"}} 
 \item{d}{slot \code{d} of an object of class \code{"AbscontDistribution"}} 
 \item{q,qfun}{slot \code{q} of an object of class \code{"AbscontDistribution"}} 
 \item{xx}{a given grid of x-values for functions \code{p}, \code{d} to be
 evaluated at}  
 \item{ql,qu}{lower and upper \code{getdistrOption("TruncQuantile")}-quantile of
 the distribution; also, if argument \code{xx} is missing, left and right endpoint
 of a regular grid of \code{ngrid} gridpoints to be used in place of \code{xx}.}  
 \item{qL,qU}{argmin / argmax of p()-method}  
 \item{ngrid}{number of gridpoints}
 \item{fx}{a vector of function evaluations multiplied by the gridwidth}
 \item{f}{a vector of function evaluations}
 \item{nm}{an optional right asymptotic value}
 \item{Arith}{logical; slot \code{.withArith} of a distribution object,
              or logically-``any'' of these slots in a collection of such objects} 
 \item{Sim}{logical; slot \code{.withSim} of a distribution object,
              or logically-``any'' of these slots in a collection of such objects} 
 \item{list0}{list, the elements of which are to be copied to a new list using
              recycling if necessary}
 \item{len}{length of the list to be filled}              
 \item{lower}{lower truncation point}
 \item{upper}{upper truncation point}
 \item{leftright}{character; for slot \code{q}: if partially matched to \code{"right"} 
                  function will return the right continuous version, else
                  the left continuous version; for slot \code{p}: if partially 
                  matched to \code{"left"} the left continuous version, else
                  the right continuous version;}
 \item{n1}{integer argument for \code{.EuclidAlgo}}
 \item{n2}{integer argument for \code{.EuclidAlgo}}
 \item{x1}{width argument for \code{.getCommonWidth}}
 \item{x2}{width argument for \code{.getCommonWidth}}
 \item{dots}{the unevaluated \code{\dots} argument}
 \item{element}{the name of the item in the unevaluated \code{\dots} argument}
 \item{...}{arguments passed through to other functions}
}

\details{
\code{.is.vector.lattice} checks whether a given vector \code{x} is equally 
spaced.
\code{.is.consistent} checks whether a given support vector \code{support} is 
consistent to a given lattice \code{lattice} --- with or without checking
if \code{support} is equally spaced.  \code{.make.lattice.es.vector} 
makes an object of class \code{Lattice} out of a given (equally spaced) vector 
\code{x}.

\code{.inArgs} checks whether an argument \code{arg} is a formal argument of 
     \code{fct} --- not vectorized.

\code{.isEqual} checks whether \code{p0} and \code{p1} are equal to given
      tolerance.
\code{.isIn} checks whether \code{p0} lies in any of the intervals given by
     matrix \code{pmat} to given tolerance.
\code{.isEqual01}(x) checks whether \code{x} is 0 or 1 to given tolerance. 
\code{.setEqual} sets all elements of x which are equal to some element of y 
         up to tolerance tol, to exactly the respective element of y. 
         
\code{.notwithLArg} checks whether object \code{D} was generated by simulations 
or if its slots \code{p,q} do not have \code{lower.tail} arguments.

\code{.getObjName} returns the name of the object in the \code{i}th operand.
\code{.discretizeP} discretizes \code{D} to a grid of probabilities from 
     \code{lower} to \code{upper} with width \code{h}.   

\code{.fm}, \code{.fM} return the smallest / biggest value in (0,1) such that
  \code{f}(x) is finite; \code{.fM2} is a variant of \code{.fM} using a 
  \code{lower.tail = FALSE} argument.

\code{.makeD}, \code{.makeP}, \code{.makeQ} generate slots \code{p,d,q} for
    binary operations \code{e1 /op/ e2} for a distribution object \code{e1} 
    and a numeric \code{e2} ---for the moment only \code{/op/}'s 
     \code{+,-,*,/} are implemented.

\code{.plusm}, \code{.multm} more specifically use \code{.makeD}, \code{.makeP}, 
\code{.makeQ} to generate slots \code{p,d,q} for \code{+}, \code{*}, 
      respectively. 


\code{.makeDd}, \code{.makePd}, \code{.makeQd} provide discrete analogues to 
\code{approxfun} for interpolation at non grid-values 

\code{.makeQc} is an analogue to \code{makeQd} for absolutely continuous 
distributions using \code{approxfun}. 

\code{.makeDNew} generates slot \code{d} for a new distribution object.
In case of a discrete distribution it produces a step function with 
\code{stepfun} (using \code{.makeDd}) and standardizes to 1 by summation.
In case of a continuous distribution it produces a density function with 
\code{approxfun} and standardizes to 1 by integration if the latter fails,
  it uses a trapezoid rule / summation for this purpose.

\code{.makePNew} generates slot \code{p} for a new distribution object.
In case of a discrete distribution it produces a step function from 
\code{cumsum} applied to \code{dx} ---or from \code{pxl} if this is given, with 
\code{stepfun} (using \code{.makePd}). 
In case of a continuous distribution it produces a cdf with 
\code{approxfun}. In case of \code{RtoDPQ}, \code{approxfun} is replaced by
\code{myPf} which calls \code{ecdf} directly.

\code{.makeQNew} generates slot \code{q} for a new distribution object.
In case of a discrete distribution it produces a step function 
(using \code{.makeQd}). Special care is taken for left continuity...
In case of a continuous distribution it produces a quantile function with 
\code{approxfun}. 

\code{.isInteger}, \code{.isNatural}, and \code{.isNatural0} test for each 
coordinate of argument \code{x} whether it
is integer [natural / natural or 0] or not.

\code{.mergegaps} modifies the gaps matrix of an a.c. distribution according to
the support slot of a discrete distribution; if necessary, a gap interval
[a,b] is split into [a,c],[c,b] if \code{a<c<b}.
\code{.mergegaps2} merges two gap matrices of two a.c. distributions \code{X1} 
and \code{X2} such that in the intervals of the resulting gap matrix, 
neither \code{X1} nor \code{X2} carries mass.
\code{.consolidategaps} consolidates a gap matrix, i.e. joins adjacent 
gap intervals.  

\code{.pmixfun}, \code{.dmixfun}, \code{.rmixfun}, and \code{.qmixfun}
fill the slots \code{p}, \code{d}, \code{r}, and \code{q}
of a corresponding mixing distribution according to the arguments
in \code{mixDistr}, \code{mixCoeff}.

\code{.loupmixfun} finds commun lower and upper bounds for the support of
the mixing distribution.

\code{.del0dmixfun} sets (if slot \code{d.ac} is not \code{NULL}) the return
value of slot function \code{d.ac} of \code{mixDistr} 
for argument \code{0} to \code{0}.

\code{.ULC.cast} coerces an object of class \code{"AcDcLcDistribution"} to
class \code{"UnivarLebDecDistribution"}, using \code{simplifyD}.


\code{.expm.d,.expm.c} for discrete, resp. a.c. argument \code{e1} fill the 
slots \code{p}, \code{d}, \code{r}, and \code{q}
of the transformation \code{exp(e1)} exactly.
\code{.logm.d,.logm.c} for discrete, resp. a.c. argument \code{e1} fill the 
slots \code{p}, \code{d}, \code{r}, and \code{q}
of the transformation \code{log(e1)} exactly.

For objects of class \code{\link{AbscontDistribution}},
\code{.P2D} and \code{.P2Q} reconstruct function slots \code{d} resp. 
\code{q} from function slot \code{p}
by means of function \code{D1ss} from package \pkg{sfsmisc};
and of function \code{.makeQNew},  respectively. The other way round, 
\code{.D2P} and \code{.Q2P} reconstruct function slot \code{p} from 
from function slots  \code{d} resp. \code{q} 
by means of function \code{.makePNew} and explicite numeric inversion,  
respectively.

\code{.csimpsum} is used internally in \code{.makePNew} to produce
a primitive function out of function evaluations by means of vectorized
Simpson quadrature method, returning already the function values
of the prime function on a grid; it is to mimick the behaviour
of \code{cumsum}. \code{.primefun} is similar but more flexible and
produces the prime function as a function.

\code{.List} checks if argument already is a list, and if so leaves it as
             it is, otherwise casts it to a list by a call to \code{list}.

\code{.fillList} fills a new list with the elements of a given list \code{list0}
                 until length \code{len} is reached using recycling if necessary.
                 Argument \code{list0} is cast to \code{list} by a call
                 to \code{.List} if necessary.

\code{.trunc.up}, \code{.trunc.low}  provide common routines for
classes \code{DiscreteDistribution} and \code{AbscontDistribution} for 
one-sided truncation, using (for slot \code{r}) Peter Dalgaard's clever 
log-tricks as indicated in 
\url{http://r.789695.n4.nabble.com/help-on-sampling-from-the-truncated-normal-gamma-distribution-on-the-far-end-probability-is-very-low-td868119.html#a868120}.

\code{.modifyqgaps} modifies slot \code{q} for objects of class 
     \code{AbscontDistribution} in the presence of gaps, i.e.; if slot
     \code{gaps} is not \code{NULL}. If argument \code{leftright} does not
     partially match \code{"right"} (default) returns the left continuous
     version of the quantile function, else the right continuous one.
 
\code{.EuclidAlgo} computes the greatest common divisor of two integers by 
      means of the Euclidean algorithm.
\code{.getCommonWidth} for two lattices with widths \code{x1} and \code{x2}
      computes the smallest common lattice width for convolution.
\code{.convDiscrDiscr} computes the convolution of two discrete distributions by
    brute force.
\code{.inWithTol} works like \code{\%in\%} but with a given tolerance.

\code{.panel.mingle} is used for mingling arguments \code{panel.first},
\code{panel.last} in a plot; it returns the evaluated argument \code{element}
within dots, if it is a symbol; else if it can be interpreted as a call, and if
the top call is \code{list}, it returns a list of the items of the call to \code{list},
unevaluated, and otherwise the unchanged argument.

\code{devNew} opens a new device. This function is for back compatibility
with R versions < 2.8.0. To control the number of opened devices, when
\code{length(dev.list())>20}, in interactive mode we ask the user to shut
some windows until \code{length(dev.list())<=20}; in non-interactive mode
we shut the first 15 open devices (except for the first one) before opening
a new one.
}


\value{
\item{.is.vector.lattice}{\code{logical} (length 1).}
\item{.is.consistent}{\code{logical} (length 1).}
\item{.notwithLArg}{\code{logical} (length 1).}
\item{.make.lattice.es.vector}{an object of class \code{Lattice}.}
\item{.inArgs}{\code{logical} (length 1).}
\item{.isIn, .isEqual,.isEqual01}{vector of \code{logical}.}
\item{.fm,.fM, .fM2}{a \code{numeric} of length 1.}
\item{.plusm,.multm}{an object of class \code{DiscreteDistribution} or 
       \code{AbscontDistribution} according to argument \code{DClass}.}
\item{.getObjName}{\code{character}.}
\item{.discretizeP}{\code{numeric} --- the probabilities for the grid-values.}
\item{.makeDd,.makePd, .makeQd}{a function with args 
       \code{x, y, yleft, yright}.}
\item{.makeD,.makeDNew}{a function with args \code{x, log = FALSE}.}
\item{.makeP,.makePNew}{a function with args \code{q, lower.tail = TRUE, 
       log.p = FALSE}.}
\item{.makeQ,.makeQNew}{a function with args \code{p, lower.tail = TRUE, 
       log.p = FALSE}.}
\item{.isInteger,.isNatural,.isNatural0}{\code{logical} (same length as argument \code{x}).}
\item{.mergegaps,.mergegaps2}{a \code{gaps}-matrix, i.e.; a matrix \code{m} with two columns, 
              such that \code{t(m)}, interpreted as vector, is ordered.}
\item{.pmixfun}{slot \code{p} for a mixing distribution, i.e. a function 
                \code{function(q, lower.tail = TRUE, log.p = FALSE)}, which
                is  the cdf of the distribution.}
\item{.dmixfun}{slot \code{d} for a mixing distribution, i.e. a function 
                \code{function(x, log = FALSE)}, which
                is  the density of the distribution.}
\item{.qmixfun}{slot \code{q} for a mixing distribution, i.e. a function 
                \code{function(p, lower.tail = TRUE, log.p = FALSE)}, which
                is  the quantile function of the distribution.}
\item{.rmixfun}{slot \code{r} for a mixing distribution, i.e. a function 
                \code{function(n)} generating r.v.'s according to the distribution.}
\item{.deldmixfun}{a possibly modified argument \code{mixDistr}.}
\item{.loupmixfun}{a list of four components: \code{qL}, the minimal value of 
\code{q(x)(0)}, \code{ql}, the minimal value of 
\code{q(x)(getdistrOption("TruncQuantile"))}, \code{qU}, the maximal value of 
\code{q(x)(1)}, \code{qu}, the maximal value of 
\code{q(x)(getdistrOption("TruncQuantile"), lower.tail = FALSE)},
\code{x} running through the members of \code{mixDistr} in each case.}
\item{.ULC.cast}{an object of class \code{"UnivarLebDecDistribution"}.}
\item{.expm.d,.logm.d}{an object of class \code{"DiscreteDistribution"}.} 
\item{.expm.c,.logm.c}{an object of class \code{"AbscontDistribution"}.} 
\item{.P2D}{a density \code{d} as function \code{function(x,  log = FALSE)}.}
\item{.P2Q}{a quantile function \code{q} as function \code{function(p, 
            lower.tail = TRUE, log.p = FALSE)}} 
\item{.D2P, .Q2P}{a cdf \code{p} as function \code{function(q, 
            lower.tail = TRUE, log.p = FALSE)}.}
\item{.csimpsum}{a vector of evaluations of the prime function at the grid points.}
\item{.primefun}{the prime function as a function.}
\item{.IssueWarn}{a list with two warnings to be issued each of which may be empty.}
\item{.List}{a list.}
\item{.fillList}{a list.}
\item{.trunc.up,.trunc.low}{a list with elements \code{r,p,d,q} (in this order).}
\item{.DistrCollapse}{upon a suggestion by Jacob van Etten, 
       \email{jacobvanetten@yahoo.com}: help function to collapse the support 
       points of a discrete distributions if they are too close to each other;
       here argument \code{support} is the (original; already sorted) support
       and \code{prob} a corresponding probability vector of same length.
       Criterium for collapsing: a distance smaller than argument
       \code{eps}.
       }
\item{.EuclidAlgo}{returns the greatest common divisor (an integer).}
\item{.getCommonWidth}{returns the  smallest common lattice width (a numeric).}
\item{.convDiscrDiscr}{returns the convolution of two discrete distributions.}
\item{.inWithTol}{returns a logical vector of same lenght as \code{x} for the
    matches (up to tolerance) with vector \code{y}.}
\item{.panel.mingle}{used for mingling arguments \code{panel.first},
\code{panel.last}; returns the evaluated argument \code{element} within dots,
if it is a symbol; else if it can be interpreted as a call, and if the top
call is \code{list}, it returns a list of the items of the call to \code{list},
unevaluated, and otherwise the unchanged argument.}
\item{devNew}{returns the return value of the device opened,
usually invisible \code{NULL}.}
}

\author{
  Peter Ruckdeschel \email{peter.ruckdeschel@uni-oldenburg.de},
  Matthias Kohl \email{Matthias.Kohl@stamats.de}
}

\seealso{
\code{\link{AbscontDistribution}},
\code{\link{DiscreteDistribution}},
\code{\link{LatticeDistribution}},
\code{\link{RtoDPQ}},
\code{\link{RtoDPQ.d}},
\code{\link{convpow}},
\code{\link{operators}},
\code{\link{plot-methods}}
\code{\link[grDevices:dev]{dev.new}}
}
\keyword{internal}
\concept{utilities}
