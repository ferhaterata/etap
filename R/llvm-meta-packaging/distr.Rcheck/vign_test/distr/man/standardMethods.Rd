\name{standardMethods}
\alias{standardMethods}
\title{Utility to automatically generate accessor and replacement functions}
\description{
Creates definitions for accessor and replacement functions of an given class.
}
\usage{
standardMethods(class, writetofile = FALSE, directory)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{class}{the class for which accessor and replacement functions
    are to be produced, given as a string}
  \item{writetofile}{logical value, indicating wheter output is to be written to a file}
  \item{directory}{if writetofile = TRUE, the output is
    written to a file in the given directory, the name of the file
    starting with "classname" and ending with "StandardMethods.txt"}
}
\value{no value is returned
}
\author{Thomas Stabla \email{statho@web.de}}
\examples{
setClass("testclass", representation(a = "numeric", b = "character"))
standardMethods("testclass")
}
\keyword{utilities}
\keyword{programming}
