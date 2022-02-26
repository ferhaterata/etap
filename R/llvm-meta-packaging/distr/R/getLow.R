#------------------------------------------------------------------------------
### getLow / getUp methods
#------------------------------------------------------------------------------

 setMethod("getLow", "AbscontDistribution",
            function(object, eps = getdistrOption("TruncQuantile")) {
                 q0 <- q.l(object)(0)
                 if (q0 > - Inf){
                   return(q0)
                }else{
                   qF <- q.l(object)
                   qe <- qF(eps)
                   if (!is.na(qe) && qe > -Inf)
                      return(qe)
                   else{
                      if(.inArgs("log.p",qF))
                         return(qF(p = .fm(x = .5, f = q.l(object)),
                               log.p = TRUE))
                      else
                         return(qF(p = exp(.fm(x = .5, f = q.l(object)))))
                   }
                }  
            })
 setMethod("getUp", "AbscontDistribution",
            function(object, eps = getdistrOption("TruncQuantile")) {
                 q1 <- q.l(object)(1)
                 if (q1 < Inf){
                   return(q1)
                 }else{
                    qF <- q.l(object)
                    if (.inArgs("lower.tail", qF)){
                          qe <- qF(eps, lower.tail = FALSE)
                          if (!is.na(qe) && qe < Inf)
                               return(qe)
                          else{
                             if(.inArgs("log.p",qF))
                                return(qF(p = .fM2(x = .5, f = q.l(object)),
                                      log.p = TRUE))
                             else
                                return(qF(p = exp(.fM2(x = .5, f = q.l(object)))))
                          }
                      }else{
                          qe <- q.l(object)(1-eps)
                          if (!is.na(qe) && qe < Inf)
                               return(qe)
                          else{
                             if(.inArgs("log.p",qF))
                               return(qF(p = .fM(x = .5, f = q.l(object)),
                                      log.p = TRUE))
                             else
                               return(qF(p = exp(.fM(x = .5, f = q.l(object)))))
                          }
                      }
                 }
            })
 setMethod("getLow", "DiscreteDistribution",
            function(object, ...) min(support(object)) )
 setMethod("getUp", "DiscreteDistribution",
            function(object, ...) max(support(object)) )

 setMethod("getLow", "LatticeDistribution",
            function(object, ...){ 
                lattice <- lattice(object) 
                qF <- q.l(object)
                if(is.finite(Length(lattice)) || width(lattice)>0)
                   return(min(support(object)))
                if(.inArgs("log.p",qF))
                   return(qF(p = .fm(x = .5, f = q.l(object)), log.p = TRUE))
                else 
                   return(qF(p = exp(.fm(x = .5, f = q.l(object)))))
                })
 setMethod("getUp", "LatticeDistribution",
            function(object, ...){
                lattice <- lattice(object) 
                if(is.finite(Length(lattice)) || width(lattice)<0)
                   return(max(support(object)))
                qF <- q.l(object)
                if (.inArgs("lower.tail", qF)){
                    if(.inArgs("log.p",qF))
                       return(qF(p = .fM(x = .5, f = q.l(object)),
                                        log.p = TRUE))
                    else
                       return(qF(p = exp(.fM(x = .5, f = q.l(object)))))
                }
                if(.inArgs("log.p",qF))
                   return(qF(p = .fM2(x = .5, f = q.l(object)),
                             lower.tail = FALSE, log.p = TRUE))               
                else
                   return(qF(p = exp(.fM2(x = .5, f = q.l(object))),
                             lower.tail = FALSE))               
                
                })   

 setMethod("getLow", "UnivarLebDecDistribution",
            function(object, eps = getdistrOption("TruncQuantile")) 
                     min(getLow(discretePart(object)),
                         getLow(acPart(object), eps = eps)))
 setMethod("getUp", "UnivarLebDecDistribution",
            function(object, eps = getdistrOption("TruncQuantile")) 
                     max(getUp(discretePart(object)),
                         getUp(acPart(object), eps = eps)))

 setMethod("getLow", "UnivarMixingDistribution",
            function(object, eps = getdistrOption("TruncQuantile")){ 
                     l <- length(mixCoeff)
                     low <- Inf
                     for(i in 1:l){
                         if(!is(try(low0 <- getLow(mixDistr[[i]], eps = eps), 
                                    silent = TRUE), "try-error"))
                            low <- min(low,low0)
                         else {
                            if(!is(try(low0 <- getLow(mixDistr[[i]]), 
                                       silent = TRUE), "try-error"))
                               low <- min(low,low0)                         
                         }
                     }    
                     return(low)})
 setMethod("getUp", "UnivarMixingDistribution",
            function(object, eps = getdistrOption("TruncQuantile")){ 
                     l <- length(mixCoeff)
                     up <- -Inf
                     for(i in 1:l){
                         if(!is(try(up0 <- getUp(mixDistr[[i]], eps = eps), 
                                    silent = TRUE), "try-error"))
                            up <- max(up,up0)
                         else {
                            if(!is(try(up0 <- getUp(mixDistr[[i]]), 
                                       silent = TRUE), "try-error"))
                               up <- max(up,up0)
                         }
                     }    
                     return(up)})
