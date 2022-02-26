#https://tailrecursion.com/wondr/posts/tail-recursion-in-r.html
countdown <- function(n) if (n > 0) countdown(n - 1) else "done"
countdown(10000)

countdown <- function(n) {
  while (n > 0) n <- n - 1;
  "done"
}

countdown(10000)

trampoline <- function(f, ...) {
  function(...) {
    ret <- f(...)
    while (inherits(ret, "recursion")) {
      ret <- eval(as.call(c(f, unclass(ret))))
    }
    ret
  }
}

recur <- function(...) {
  structure(list(...), class = "recursion")
}

countdown <- trampoline(function(n) {
  if (n > 0) recur(n - 1) else "done"
})
countdown(10000)
