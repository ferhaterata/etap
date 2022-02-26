#include <Rcpp.h>

// [[Rcpp::export]]
Rcpp::List rcpp_hello_world() {
  Rcpp::CharacterVector x = Rcpp::CharacterVector::create("foo", "bar");
  Rcpp::NumericVector y = Rcpp::NumericVector::create(0.0, 1.0);
  Rcpp::List z = Rcpp::List::create(x, y);
  return z;
}

std::vector<Rcpp::RObject> memory;

// [[Rcpp::export]]
void add(Rcpp::RObject object) { memory.push_back(std::move(object)); }

// [[Rcpp::export]]
Rcpp::RObject get(std::size_t position) { return memory[position]; }

// [[Rcpp::export]]
void reserve(std::size_t new_cap) { memory.reserve(new_cap); }

// [[Rcpp::export]]
void clear() {
  // Erases all elements from the container. After this call, size() returns
  // zero. Invalidates any references, pointers, or iterators referring to
  // contained elements. Any past-the-end iterators are also invalidated.
  memory.clear();
}

// [[Rcpp::export]]
std::size_t size() {
  // The number of elements in the container.
  return memory.size();
}

// [[Rcpp::export]]
std::size_t capacity() {
  // Capacity of the currently allocated storage.
  return memory.capacity();
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
