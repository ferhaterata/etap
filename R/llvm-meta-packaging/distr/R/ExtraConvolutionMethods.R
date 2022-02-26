##setMethod("+", c("AbscontDistribution","DiscreteDistribution"),
##          function(e1,e2){               
##            rfun = function(n) r(e1)(n) + r(e2)(n)
##            AbscontDistribution( r = rfun)
##          })


##setMethod("+", c("DiscreteDistribution","AbscontDistribution"),
##          function(e1,e2){
##            rfun = function(n) r(e1)(n) + r(e2)(n)
##            AbscontDistribution(r = rfun)
##          })




setMethod("+", c("numeric", "UnivariateDistribution"),
          function(e1, e2){
            message("ExtraConvolutionMethods.setMethod(\"+\", c(\"numeric\",\"UnivariateDistribution\")\n")
            e2 + e1
          })

setMethod("-", c("numeric", "UnivariateDistribution"),
          function(e1, e2){
            message("ExtraConvolutionMethods.setMethod(\"-\", c(\"numeric\",\"UnivariateDistribution\")\n")
            -1*e2 + e1
          })

setMethod("*", c("numeric", "UnivariateDistribution"),
          function(e1, e2){
            message("ExtraConvolutionMethods.setMethod(\"*\", c(\"numeric\",\"UnivariateDistribution\")\n")

            e2 * e1
          })

setMethod("-", c("UnivariateDistribution", "UnivariateDistribution"),
          function(e1,e2){
            message("ExtraConvolutionMethods.setMethod(\"-\", c(\"UnivariateDistribution\",\"UnivariateDistribution\")\n")

            e1+(-e2)
          })
setMethod("-", c("UnivariateDistribution", "missing"),
          function(e1){
            message("ExtraConvolutionMethods.setMethod(\"-\", c(\"UnivariateDistribution\",\"missing\")\n")
            e1*(-1)
          })


setMethod("-", c("UnivariateDistribution", "numeric"),

          function(e1, e2){
            message("ExtraConvolutionMethods.setMethod(\"-\", c(\"UnivariateDistribution\",\"numeric\")\n")
            return(e1 + (-e2))
          })

setMethod("/", c("UnivariateDistribution", "numeric"),
          function(e1, e2){
            message("ExtraConvolutionMethods.setMethod(\"/\", c(\"UnivariateDistribution\",\"numeric\")\n")
            if(e2 == 0) stop("division by zero")
            return(e1 * (1/e2))
          })


setMethod("+", c("AbscontDistribution", "DiscreteDistribution"),
          function(e1,e2){
            message("ExtraConvolutionMethods.setMethod(\"+\", c(\"AbscontDistribution\",\"DiscreteDistribution\")\n")
            return(e2 + e1)
          })

setMethod("+", c("LatticeDistribution", "DiscreteDistribution"),
          function(e1,e2){
            message("ExtraConvolutionMethods.setMethod(\"+\", c(\"LatticeDistribution\",\"DiscreteDistribution\")\n")
            return(e2 + as(e1,"DiscreteDistribution"))
          })


setMethod("+", c("DiscreteDistribution","AbscontDistribution"),
function(e1,e2){
  message("ExtraConvolutionMethods.setMethod(\"+\", c(\"DiscreteDistribution\",\"AbscontDistribution\")\n")
  rfun <- function(n){}
     body(rfun) <- substitute({ f(n) + g(n) },
                                list(f = e1@r, g = e2@r))
     grid <- support(e1)
     probab <- d(e1)(grid)

     lower1 <- getLow(e1)
     upper1 <- getUp(e1)
     lower2 <- getLow(e2)
     upper2 <- getUp(e2)

     lower <- lower1 + lower2
     upper <- upper1 + upper2
     x <- seq(from = lower, to = upper,
              length = getdistrOption("DefaultNrGridPoints"))
     h <- x[2]-x[1]
           ### to avoid double accounting for density boundary
           ### points we jitter a little:
     dpn <- outer(x+rnorm(x)*sd(x)*getdistrOption("DistrResolution"),
                  grid, function(x,y) d(e2)(x - y)) %*% probab

     ### treatment if density of e2 has singularities
     if(any(idx <- (dpn*h >= 10*length(dpn)))){
        Lx <- length(dpn)
        idx <- seq(Lx)[idx]
        Li <- length(idx)
        xx <- x[idx]
        xxp <- ifelse(upper2-xx < .Machine$double.eps, xx-h/4 , xx+h/2)
        xxm <- ifelse(xx-lower2 < .Machine$double.eps, xx+h/4 , xx-h/2)
        xx0 <- sort(c(xxm,xxp))
        jdx <- 2*seq(Li)-1
        pn <- outer(xx0, grid, function(x,y) p(e2)(x - y)) %*% probab/(xxp-xxm)
        dpn[idx] <- diff(pn)[jdx]
     }

     dfun <- .makeDNew(x, dpn, h=1, standM="int" )

     if(is(e2,"Chisq")){
        pfun <- .makePNew(x, dpn, h,
                          .notwithLArg(e1)||.notwithLArg(e2))
     }else{
#
     pl <- outer(x, grid, function(x,y) p(e2)(x - y)) %*% probab
     pu <- if (.inArgs("lower.tail", p(e2)))
               outer(x, grid,
                     function(x,y) p(e2)(x - y, lower.tail = FALSE)) %*% probab
           else
               outer(x, grid, function(x,y) 1-p(e2)(x - y)) %*% probab
     ## cdf (steps 5--7)
     pfun <- .makePNew(x, NULL, h,
                        .notwithLArg(e1)||.notwithLArg(e2), pxl = pl , pxu = pu)
     }
     ## quantile function
     yL <-  if ((q.l(e1)(0) == -Inf)||(q.l(e2)(0) == -Inf))
          -Inf else lower
     yR <-  if ((q.l(e1)(1) ==  Inf)||(q.l(e2)(1) ==  Inf))
           Inf else upper

     ## contintuity correction
     px.l <- pfun(x + 0.5*h)
     px.u <- pfun(x + 0.5*h, lower.tail = FALSE)

#     print(summary(x))
#     print(summary(px.l))
#     print(summary(px.u))
     qfun <- .makeQNew(x + 0.5*h, px.l, px.u,
                       .notwithLArg(e1)||.notwithLArg(e1), yL, yR)

     object <- AbscontDistribution( r = rfun, d = dfun, p = pfun,
                    q = qfun, .withSim = FALSE, .withArith = TRUE)

     if(is(e1@Symmetry,"SphericalSymmetry")&&
        is(e2@Symmetry,"SphericalSymmetry"))
           object@Symmetry <- SphericalSymmetry(SymmCenter(e1@Symmetry)+
                                                 SymmCenter(e2@Symmetry))
     object
     })


setMethod("+", c("numeric", "LatticeDistribution"),
          function(e1, e2){
            message("ExtraConvolutionMethods.setMethod(\"+\", c(\"numeric\",\"LatticeDistribution\")\n")
            e2 + e1
          })

setMethod("-", c("numeric", "LatticeDistribution"),
          function(e1, e2){
            message("ExtraConvolutionMethods.setMethod(\"-\", c(\"numeric\",\"LatticeDistribution\")\n")
            -1*e2 + e1
          })

setMethod("*", c("numeric", "LatticeDistribution"),
          function(e1, e2){
            message("ExtraConvolutionMethods.setMethod(\"*\", c(\"numeric\",\"LatticeDistribution\")\n")
            e2 * e1
          })

setMethod("-", c("LatticeDistribution", "LatticeDistribution"),
          function(e1,e2){
            message("ExtraConvolutionMethods.setMethod(\"-\", c(\"LatticeDistribution\",\"LatticeDistribution\")\n")
            e1+(-e2)
          })

setMethod("-", c("LatticeDistribution", "missing"),
          function(e1){
            message("ExtraConvolutionMethods.setMethod(\"-\", c(\"LatticeDistribution\",\"missing\")\n")
            e1*(-1)
          })


setMethod("-", c("LatticeDistribution", "numeric"),
          function(e1, e2){
            message("ExtraConvolutionMethods.setMethod(\"-\", c(\"LatticeDistribution\",\"numeric\")\n")
            return(e1 + (-e2))
          })

setMethod("/", c("LatticeDistribution", "numeric"),
          function(e1, e2){
            message("ExtraConvolutionMethods.setMethod(\"/\", c(\"LatticeDistribution\",\"numeric\")\n")
            if(e2 == 0) stop("division by zero")
            return(e1 * (1/e2))
          })
setMethod("-", c("UnivariateDistribution", "LatticeDistribution"),
          function(e1,e2){
            message("ExtraConvolutionMethods.setMethod(\"-\", c(\"UnivariateDistribution\",\"LatticeDistribution\")\n")
            e1+(-e2)
          })
setMethod("-", c("LatticeDistribution", "UnivariateDistribution"),
          function(e1,e2){
            message("ExtraConvolutionMethods.setMethod(\"-\", c(\"LatticeDistribution\",\"UnivariateDistribution\")\n")
            e1+(-e2)
          })
