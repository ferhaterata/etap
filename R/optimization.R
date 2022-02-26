#https://cran.r-project.org/web/packages/matlib/vignettes/linear-equations.html
rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
library(matlib)   # use the package
A <- matrix(c(1, 1, 1,
              1, 2, 1,
              2, 1, 1), 3, 3, byrow = TRUE)
colnames(A) <- c("alloca", "load", "store") # "io.read", "io.write"
rownames(A) <- c("program.1", "program.2", "program.3")
A
b <- c(21, 31, 31) #1
b <- c(21, 31, 32) #2
b <- c(21, 31, 33) #3
showEqn(A, b)
Solve(A, b, fractions = TRUE)
plotEqn3d(A, b)

# Linera Programming
# https://rstudio-pubs-static.s3.amazonaws.com/534936_8eeb46b4b20d47509e4dede705dbb1c4.html
library(lpSolveAPI)

lps.model <- make.lp(0, 3) # define 3 variables, the constraints are added below
add.constraint(lps.model, c(6, 2, 4), "<=", 150)
add.constraint(lps.model, c(1, 1, 6), ">=", 0)
add.constraint(lps.model, c(4, 5, 4), "=", 40)
# set objective function (default: find minimum)
set.objfn(lps.model, c(-3, -4, -3))
# write model to a file
write.lp(lps.model, 'model.lp', type = 'lp')

# these commands defines the model
# /* Objective function */
#   min: -3 C1 -4 C2 -3 C3;
#
# /* Constraints */
# +6 C1 +2 C2 +4 C3 <= 150;
# +  C1 +  C2 +6 C3 >=   0;
# +4 C1 +5 C2 +4 C3  =  40;
#
# writing it in the text file named 'model.lp'
solve(lps.model)

# Retrieve the var values from a solved linear program model
get.variables(lps.model)  # check with the solution above!

# another eg
lps.model2 <- make.lp(0, 3)
add.constraint(lps.model2, c(1, 2, 3), "<=", 14)
add.constraint(lps.model2, c(3, -1, -6), ">=", 0)
add.constraint(lps.model2, c(1, -1, 0), "<=", 2)
set.objfn(lps.model2, c(3, 4), indices = c(1, 2)) # does not use C3
lp.control(lps.model2, sense = 'max')     # changes to max: 3 C1 + 4 C2


