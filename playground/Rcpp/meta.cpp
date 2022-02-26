#include <Rcpp.h>

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
long trunc(Rcpp::String from, long x, Rcpp::String to) {
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
