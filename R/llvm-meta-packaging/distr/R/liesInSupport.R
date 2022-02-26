setMethod("liesInSupport", signature(object = "DiscreteDistribution",
                                     x = "numeric"),
    function(object, x, checkFin = FALSE){
       supp <- support(object)
       erg <- x %in% supp
       if(checkFin && !all(object@.finSupport)){
          lO <- q.l(object)(0)
          rO <- q.l(object)(1)
          lS <- min(supp)
          rS <- max(supp)

          ll.f <- is.finite(lO)
          lr.f <- is.finite(rO)

          ll <- object@.finSupport[1]
          lr <- object@.finSupport[2]

          lln <- !ll.f|!object@.finSupport[1]|is.na(object@.finSupport[1])
          lrn <- !lr.f|!object@.finSupport[2]|is.na(object@.finSupport[2])


          erg <- erg | ((x>=lO) & (x<lS) & ll) | ((x<=rO) & (x>rS) & lr) |
                       ((x<lS) & lln) | ((x>rS) & lrn)
         }
       return(erg)
       })

setMethod("liesInSupport", signature(object = "Distribution",
                                     x = "matrix"),
    function(object, x, checkFin = FALSE){
            ret <- liesInSupport(object,as.vector(x),checkFin)
#            dim(ret) <- dim(x)
            return(ret)
    })

setMethod("liesInSupport", signature(object = "AbscontDistribution",
                                     x = "numeric"),
    function(object, x, checkFin = FALSE){
         ## checkFin not used here but for simple coercing agains x ="matrix"
        if(!is.nan(q.l(object)(0)))
            low <- q.l(object)(0)
        else
            low <- q.l(object)(10*.Machine$double.eps)
        if(!is.nan(q.l(object)(1)))
            upp <- q.l(object)(1)
        else
            upp <- q.l(object)(1-10*.Machine$double.eps)

        (x >= low)&(x <= upp)
    })

#setMethod("liesInSupport", signature(object = "AbscontDistribution",
#                                     x = "matrix"),
#    function(object, x){
#        if(ncol(x) != 1)
#            stop("'x' has wrong dimension")
#       else{
#          ret <- liesInSupport(object,as.vector(x),checkFin)
#            dim(ret) <- dim(x)
#            return(ret)
#       }
#    })

setMethod("liesInSupport", signature(object = "LatticeDistribution",
                                     x = "numeric"),
    function(object, x, checkFin = FALSE){
       erg <- x %in% support(object)
       if(checkFin && !all(object@.finSupport)){
          lO <- q.l(object)(0)
          rO <- q.l(object)(1)
          lln <- !object@.finSupport[1]|is.na(object@.finSupport[1])
          lrn <- !object@.finSupport[2]|is.na(object@.finSupport[2])

          L <- lattice(object)
          vals <- (x-pivot(L))/width(L)
          ep <- .Machine$double.eps
          erg <- .isInteger(vals) & (vals>=-ep) & (vals<=Length(L)-1+ep)
          erg <- erg & ((x>=lO)|lln) & ((x<=rO)|lrn)
         }
       return(erg)
       })

setMethod("liesInSupport", signature(object = "UnivarLebDecDistribution",
                                     x = "numeric"),
    function(object, x, checkFin = FALSE){
       ac <- acPart(object)
       dc <- discretePart(object)
       ep <- .Machine$double.eps
       acl <- rep(TRUE, length(x))
       dcl <- TRUE
       if(acWeight(object)>ep) acl <- liesInSupport(ac,x)
       if(discreteWeight(object)>ep) dcl <- liesInSupport(dc,x, checkFin)
       return(acl|dcl)
       })

setMethod("liesInSupport", signature(object = "UnivarMixingDistribution",
                                     x = "numeric"),
    function(object, x, checkFin = FALSE){
       obj <- flat.mix(object)
       return(liesInSupport(obj,x,checkFin))
       })

.alwaysInSupp <- function(object, x, checkFin = TRUE) is.finite(x)
.posInSupp <- function(object, x, checkFin = TRUE) (x>=0)
.stricposInSupp <- function(object, x, checkFin = TRUE) (x>0)

setMethod("liesInSupport", signature(object = "ExpOrGammaOrChisq",
                                     x = "numeric"),.posInSupp)
setMethod("liesInSupport", signature(object = "Lnorm",
                                     x = "numeric"),.posInSupp)
setMethod("liesInSupport", signature(object = "Fd",
                                     x = "numeric"),.posInSupp)

setMethod("liesInSupport", signature(object = "Norm",
                                     x = "numeric"),.alwaysInSupp)
setMethod("liesInSupport", signature(object = "DExp",
                                     x = "numeric"),.alwaysInSupp)
setMethod("liesInSupport", signature(object = "Cauchy",
                                     x = "numeric"),.alwaysInSupp)
setMethod("liesInSupport", signature(object = "Td",
                                     x = "numeric"),.alwaysInSupp)
setMethod("liesInSupport", signature(object = "Logis",
                                     x = "numeric"),.alwaysInSupp)
setMethod("liesInSupport", signature(object = "Weibull",
                                     x = "numeric"),.alwaysInSupp)

setMethod("liesInSupport", signature(object = "Unif",
                                     x = "numeric"),
  function(object, x, checkFin = TRUE){(x>=Min(object))&(x<=Max(object))})
setMethod("liesInSupport", signature(object = "Beta",
                                     x = "numeric"),
  function(object, x, checkFin = TRUE){(x>=0)&(x<=1)})
