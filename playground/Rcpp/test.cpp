#include <Rcpp.h>
#include <math.h>
using namespace Rcpp;

// This is a simple example of exporting a C++ function to R. You can
// source this function into an R session using the Rcpp::sourceCpp
// function (or via the Source button on the editor toolbar). Learn
// more about Rcpp at:
//
//   http://www.rcpp.org/
//   http://adv-r.had.co.nz/Rcpp.html
//   http://gallery.rcpp.org/
//

// [[Rcpp::export]]
NumericVector timesTwo(NumericVector x) { return x * 2; }

// [[Rcpp::export]]
long trunc_(Rcpp::String from, long x, Rcpp::String to) {
  if (to == "i1") return x & 1;
  if (to == "i8") return (char)x;
  if (to == "i16") return (short)x;
  if (to == "i32") return (int)x;
  if (to == "i64") return (long)x;

  std::string msg = std::string("\'to\' type is not recognized: ") +
                    to.get_cstring() + std::string(" \n");
  Rcpp::warning(msg);
  return x;
}
// [[Rcpp::export]]
long lshr(Rcpp::String from, long x, long y) { return x >> y; }
// [[Rcpp::export]]
long shl(Rcpp::String from, long x, long y) { return x << y; }
// [[Rcpp::export]]
long and_(long x, long y) { return x & y; }
// [[Rcpp::export]]
long or_(long x, long y) { return x | y; }
// [[Rcpp::export]]
long xor_(long x, long y) { return x ^ y; }
// [[Rcpp::export]]
long fptosi(Rcpp::String from, double x, Rcpp::String to) {
  return trunc_(from, trunc(x), to);
}
// [[Rcpp::export]]
long fptoui(Rcpp::String from, double x, Rcpp::String to) {
  return trunc_(from, trunc(x), to);
}

// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically
// run after the compilation.
//
/*** R
timesTwo(42)
fptoui("double", 123.5, "i32")
*/
