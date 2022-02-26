################################
##
## Class: GeomParameter
##                                
################################


## Access Methods

### Replaced by NbinomParameter ....
### pre v1.9 /deprecated  
### defunct as of 2.8.0
#setMethod("prob", "GeomParameter", function(object)
#     {.Defunct(new = "",
#                        package = "distr",
#                        msg = gettext(
#"Class 'GeomParameter' is no longer needed and will be replaced by \nclass 'NbinomParameter' soon."
#                                     )
#                 )
#      object@prob
#     }
#     )


## code is in NegbinomDistribution.R
# setMethod("prob", "NbinomParameter", function(object) object@prob)


## Replace Methods
### Replaced by NbinomParameter ....
### pre v1.9:  /deprecated
### defunct as of 2.8.0
#setReplaceMethod("prob", "GeomParameter",
#                             function(object, value)
#                                      {.Defunct(new = "",
#                                                   package = "distr",
#                                                   msg = gettext(
#"Class 'GeomParameter' is no longer needed and will be replaced by \nclass 'NbinomParameter' soon."
#                                                                )
#                                                  )
#                                       object@prob <- value;
#                                       object})

## code is in NegbinomDistribution.R
#setReplaceMethod("prob", "NbinomParameter",
#                  function(object, value)
#                          { object@prob <- value; object}
#                  )


### no longer needed from version 1.9 on
#setValidity("GeomParameter", function(object){
#  if(length(prob(object)) != 1)
#    stop("prob has to be a numeric of length 1")    
#  if(prob(object) <= 0)
#    stop("prob has to be in (0,1]")
#  if(prob(object) > 1)
#    stop("prob has to be in (0,1]")
#  else return(TRUE)
#}
#)

################################
##
## Class: geometric distribution 
##
################################

Geom <- function(prob = 0.5) new("Geom", prob = prob)

## wrapped access methods
setMethod("prob", "Geom", function(object) prob(param(object)))
## wrapped replace methods
setMethod("prob<-", "Geom", function(object, value) new("Geom", prob = value))

setMethod("size", "Geom", function(object) return(1))
