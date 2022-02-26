#include <Rcpp.h>
#include <math.h>

// Enable C++11
// [[Rcpp::plugins(cpp11)]]

// [[Rcpp::export]]
Rcpp::List rcpp_hello_world() {
  Rcpp::CharacterVector x = Rcpp::CharacterVector::create("foo", "bar");
  Rcpp::NumericVector y = Rcpp::NumericVector::create(0.0, 1.0);
  Rcpp::List z = Rcpp::List::create(x, y);
  return z;
}

// [[Rcpp::export(name = "trunc", rng = false)]]
unsigned long trunc_(Rcpp::String from, long x, Rcpp::String to) {
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
unsigned long lshr(Rcpp::String type, unsigned long x, long y) {
  if (type == "i1")
    x = x & 1;
  else if (type == "i4")
    x = x & 0x0F;
  else if (type == "i8")
    x = x & 0xFF;
  else if (type == "i16")
    x = x & 0xFFFF;
  else if (type == "i32")
    x = x & 0xFFFFFFFF;
  else if (type == "i64")
    x = x & 0xFFFFFFFFFFFFFFFF;

  if (type == "i1") return (x >> y) & 0x01;
  if (type == "i4") return (x >> y) & 0x0F;
  if (type == "i8") return (x >> y) & 0xFF;
  if (type == "i16") return (x >> y) & 0xFFFF;
  if (type == "i32") return (x >> y) & 0xFFFFFFFF;
  if (type == "i64") return (x >> y) & 0xFFFFFFFFFFFFFFFF;

  std::string msg = std::string("given type is not recognized: ") +
                    type.get_cstring() + std::string(" \n");
  Rcpp::warning(msg);
  return x >> y;
}

// [[Rcpp::export(rng = false)]]
long ashr(Rcpp::String type, long x, long y) {
  if (type == "i1") return (x >> y) & 0x01;
  if (type == "i4") return (x >> y) & 0x0F;
  // must be true --> ashr("i4", -2, 1) == -1
  // not working for negative values. need to fix !
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
  if (type == "i1") return (x << y) & 0x01;
  if (type == "i4") return (x << y) & 0x0F;
  if (type == "i8") return (x << y) & 0xFF;
  if (type == "i16") return (x << y) & 0xFFFF;
  if (type == "i32") return (x << y) & 0xFFFFFFFF;
  if (type == "i64") return (x << y) & 0xFFFFFFFFFFFFFFFF;

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
  x = trunc(x);
  if (to == "i1") return (bool)x;
  if (to == "i4") return (char)x & 0x0F;
  if (to == "i8") return (char)x;
  if (to == "i16") return (short)x;
  if (to == "i32") return (int)x;
  if (to == "i64") return (long)x;

  std::string msg = std::string("\'to\' type is not recognized: ") +
                    to.get_cstring() + std::string(" \n");
  Rcpp::warning(msg);
  return x;
}

// [[Rcpp::export(rng = false)]]
unsigned long fptoui(Rcpp::String from, double x, Rcpp::String to) {
  x = trunc(x);
  if (to == "i1") return (bool)x;
  if (to == "i4") return (unsigned char)x & 0x0F;
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
double uitofp(Rcpp::String from, unsigned long x, Rcpp::String to) {
  if (from == "i1")
    x = x & 1;
  else if (from == "i4")
    x = x & 0x0F;
  else if (from == "i8")
    x = x & 0xFF;
  else if (from == "i16")
    x = x & 0xFFFF;
  else if (from == "i32")
    x = x & 0xFFFFFFFF;
  else if (from == "i64")
    x = x & 0xFFFFFFFFFFFFFFFF;

  if (to == "float") return (float)x;
  if (to == "double") return (double)x;

  std::string msg = std::string("given type is not recognized: ") +
                    to.get_cstring() + std::string(" \n");
  Rcpp::warning(msg);
  return x;
}

// [[Rcpp::export(rng = false)]]
double sitofp(Rcpp::String from, long x, Rcpp::String to) {
  if (to == "i1")
    x = x & 1;
  else if (to == "i4")
    x = x & 0x0F;
  else if (to == "i8")
    x = (char)x;
  else if (to == "i16")
    x = (short)x;
  else if (to == "i32")
    x = (int)x;
  else if (to == "i64")
    x = (long)x;

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

  if (to == "i1") return x & 1;
  if (to == "i4") return x & 0x0F;
  if (to == "i8") return x & 0xFF;
  if (to == "i16") return x & 0xFFFF;
  if (to == "i32") return x & 0xFFFFFFFF;
  if (to == "i64") return x & 0xFFFFFFFFFFFFFFFF;

  std::string msg = std::string("\'to\' type is not recognized: ") +
                    to.get_cstring() + std::string(" \n");
  Rcpp::warning(msg);
  return (unsigned long)x;
}

int counter = 0;
// [[Rcpp::export]]
int inc() { return ++counter; }

// [[Rcpp::export]]
Rcpp::S4 my_norm(double mean, double sd) {
  // Obtaining namespace of Distr package
  Rcpp::Environment pkg = Rcpp::Environment::namespace_env("distr");
  // Picking up Norm() function from distr package
  Rcpp::Function f = pkg["Norm"];
  // Next code is interpreted as Norm(mean=10, sd=2)
  return f(Rcpp::Named("sd") = sd, Rcpp::Named("mean") = mean);
}

std::map<std::string, Rcpp::RObject> memory;

// [[Rcpp::export]]
void store(Rcpp::String name, Rcpp::RObject object) { memory[name] = object; }

// [[Rcpp::export]]
Rcpp::RObject load(Rcpp::String name) { return memory[name]; }

// [[Rcpp::export]]
Rcpp::S4 rcpp_package_function(Rcpp::NumericMatrix m) {
  // Obtaining namespace of Matrix package
  Rcpp::Environment pkg = Rcpp::Environment::namespace_env("Matrix");
  // Picking up Matrix() function from Matrix package
  Rcpp::Function f = pkg["Matrix"];
  // Executing Matrix( m, sparse = TRIE )
  return f(m, Rcpp::Named("sparse", true));
}

// [[Rcpp::export]]
void rcpp_type(Rcpp::RObject x) {
  if (Rcpp::is<Rcpp::NumericVector>(x)) {
    if (Rf_isMatrix(x))
      Rcpp::Rcout << "NumericMatrix\n";
    else
      Rcpp::Rcout << "NumericVector\n";
  } else if (Rcpp::is<Rcpp::IntegerVector>(x)) {
    if (Rf_isFactor(x))
      Rcpp::Rcout << "factor\n";
    else
      Rcpp::Rcout << "IntegerVector\n";
  } else if (Rcpp::is<Rcpp::CharacterVector>(x))
    Rcpp::Rcout << "CharacterVector\n";
  else if (Rcpp::is<Rcpp::LogicalVector>(x))
    Rcpp::Rcout << "LogicalVector\n";
  else if (Rcpp::is<Rcpp::DataFrame>(x))
    Rcpp::Rcout << "DataFrame\n";
  else if (Rcpp::is<Rcpp::List>(x))
    Rcpp::Rcout << "List\n";
  else if (x.isS4())
    Rcpp::Rcout << "S4\n";
  else if (x.isNULL())
    Rcpp::Rcout << "NULL\n";
  else
    Rcpp::Rcout << "unknown\n";

  // Converting `RObject` to `NumericVector`
  //  RObject x;
  //  NumericVector v = as<NumericVector>(x);
}

namespace internal {

template <int RTYPE>
Rcpp::Vector<RTYPE> say_hello(Rcpp::Vector<RTYPE> x) {
  Rcpp::Rcout << "Hello!" << std::endl;
  return x;
}

}  // namespace internal

// [[Rcpp::export]]
Rcpp::RObject say_hello(Rcpp::RObject x) {
  RCPP_RETURN_VECTOR(internal::say_hello, x);
}

// if (unexpectedCondition)
//   Rcpp::stop("Unexpected condition occurred");
