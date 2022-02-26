### for working under R < 2.8.0
if(getRversion()<'2.8.0'){
    devNew <- function(...){
        if(length(dev.list())>0)
        get(getOption("device"))(...)
    }
}else{
    devNew <- function(...){
        if(length(dev.list())>0){
           if(!is.null(getOption("newDevice"))){
               nrOpen <- length(grDevices::dev.list())
               if(getOption("newDevice")==TRUE) {
                  if(interactive()){
                      while(nrOpen >20){
                         invisible(readline(prompt=
                         paste(gettext(
                         "Too many open graphic devices; please shut some."),
                         "\n", gettext(
                         "When you have shut some devices, press [enter] to continue"),
                         "\n", sep="")))
                         nrOpen <- length(grDevices::dev.list())
                      }
                  }else{
                      if(nrOpen >20){
                         while(nrOpen<-length(grDevices::dev.list())>5)
                             grDevices::dev.off(which=grDevices::dev.list()[2])
                      }
                  }
                  dev.new(...)
               }
           }
        }
    }
}
options("newDevice"=FALSE)

