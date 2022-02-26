#include <Rcpp.h>
#include <math.h>

// [[Rcpp::export(name = "trunc", rng = false)]]
long trunc_(Rcpp::String from, long x, Rcpp::String to) {
  if (to == "i1") return x & 1;
  if (to == "i4") return x & 0x0F;
  if (to == "i8") return (char)x;
  if (to == "i16") return (short)x;
  if (to == "i32") return (int)x;
  if (to == "i64") return (long)x;

  std::string msg = std::string("\'to\' type is not recognized: ") +
                    to.get_cstring() + std::string(" \n");
  Rcpp::warning(msg);
  return x;
}

unsigned long unsignedTrunc(Rcpp::String from, long x, Rcpp::String to) {
  if (to == "i1") return x & 1;
  if (to == "i4") return x & 0x0F;
  if (to == "i8") return (unsigned char)x;
  if (to == "i16") return (unsigned short)x;
  if (to == "i32") return (unsigned int)x;
  if (to == "i64") return (unsigned long)x;

  std::string msg = std::string("\'to\' type is not recognized: ") +
                    to.get_cstring() + std::string(" \n");
  Rcpp::warning(msg);
  return (unsigned long)x;
}

// [[Rcpp::export(rng = false)]]
unsigned long lshr(Rcpp::String type, long x, long y) {
  x = unsignedTrunc("i64", x, type);
  if (type == "i4") return (x >> y) & 0x0F;
  if (type == "i8") return (unsigned char)(x >> y);
  if (type == "i16") return (unsigned short)(x >> y);
  if (type == "i32") return (unsigned int)(x >> y);
  if (type == "i64") return (unsigned long)(x >> y);
  std::string msg = std::string("given type is not recognized: ") +
                    type.get_cstring() + std::string(" \n");
  Rcpp::warning(msg);
  return x >> y;
}

// [[Rcpp::export(rng = false)]]
long ashr(Rcpp::String type, long x, long y) {
  // x = trunc_("i64", x, type); //without this line, working well !
  if (type == "i4")
    return (x >> y) & 0x0F;  // not working for negative values. need to fix !
                             // must be true --> ashr("i4", -2, 1) == -1
  if (type == "i8") return (char)(x >> y);
  if (type == "i16") return (short)(x >> y);
  if (type == "i32") return (int)(x >> y);
  if (type == "i64") return (long)(x >> y);

  std::string msg = std::string("given type is not recognized: ") +
                    type.get_cstring() + std::string(" \n");
  Rcpp::warning(msg);
  return x >> y;
}

// [[Rcpp::export(rng = false)]]
long shl(Rcpp::String type, long x, long y) {
  // x = trunc_("i64", x, type);  // without this line, working well !
  if (type == "i4") return (x << y) & 0x0F;
  if (type == "i8") return (char)(x << y);
  if (type == "i16") return (short)(x << y);
  if (type == "i32") return (int)(x << y);
  if (type == "i64") return (long)(x << y);

  std::string msg = std::string("given type is not recognized: ") +
                    type.get_cstring() + std::string(" \n");
  Rcpp::warning(msg);
  return x << y;
}

// [[Rcpp::export(name = "and", rng = false)]]
long and_(long x, long y) { return x & y; }

// [[Rcpp::export(name = "or", rng = false)]]
long or_(long x, long y) { return x | y; }

// [[Rcpp::export(name = "xor", rng = false)]]
long xor_(long x, long y) { return x ^ y; }

// [[Rcpp::export(rng = false)]]
long fptosi(Rcpp::String from, double x, Rcpp::String to) {
  return trunc_(from, trunc(x), to);
}

// [[Rcpp::export(rng = false)]]
long fptoui(Rcpp::String from, double x, Rcpp::String to) {
  return unsignedTrunc(from, trunc(x), to);
}

// [[Rcpp::export(rng = false)]]
double uitofp(Rcpp::String from, unsigned long x, Rcpp::String to) {
  x = unsignedTrunc("i64", x, from);
  if (to == "float") return (float)x;
  if (to == "double") return (double)x;
  std::string msg = std::string("given type is not recognized: ") +
                    to.get_cstring() + std::string(" \n");
  Rcpp::warning(msg);
  return x;
}

// [[Rcpp::export(rng = false)]]
double sitofp(Rcpp::String from, long x, Rcpp::String to) {
  if (to == "float") return (float)x;
  if (to == "double") return (double)x;
  std::string msg = std::string("given type is not recognized: ") +
                    to.get_cstring() + std::string(" \n");
  Rcpp::warning(msg);
  return x;
}

// [[Rcpp::export(rng = false)]]
long sext(Rcpp::String from, long x, Rcpp::String to) {
  if (from == "i1" && x == 1) return -1;
  if (from == "i1" && x == 0) return 0;
  return unsignedTrunc(from, x, to);
}

// if (unexpectedCondition)
//   Rcpp::stop("Unexpected condition occurred");
