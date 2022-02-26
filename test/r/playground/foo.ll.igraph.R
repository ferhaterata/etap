library("distr")
library("distrEx")
library("igraph")


#--------------------------
g1 <- graph(edges = c(1, 2, 2, 3, 3, 1), n = 3, directed = T)
plot(g1) # A simple plot of the network - we'll talk more about plots later
#--------------------------
g.foo <- graph(
  edges = c("entry", "if.then", "if.then", "if.then2"), directed = TRUE
)

g.foo <- set_graph_attr(g.foo, "name", "foo")
g.foo <- set_graph_attr(g.foo, "formals", "x <- Norm(mean=11, sd=1); y <- Norm(mean=5, sd=1);")
graph_attr(g.foo)
graph_attr_names(g.foo)
graph_attr(g.foo, "formals")

vertex_attr(g.foo)

V(g.foo)$inst <-
  c(
    paste("retval <- Unif(-1000,1000)",
          "x.addr <- Unif(-1000,1000)",
          "y.addr <- Unif(-1000,1000)",
          "a <- Unif(-1000,1000)",
          "x.addr <- x",
          "y.addr <- y",
          "v0 <- x.addr",
          "v1 <- y.addr",
          "add <- v1 + 6.000000e+00",
          "cmp <- v0 - add; cmp <- p(cmp)(0)",
          "entry_if.then <- round(cmp, 2); entry_if.end4 <- round(1 - cmp, 2)",
          sep = ";"),
    paste("v2 <- y.addr",
          "mul <- 2.000000e+00 * v2",
          "a <- mul",
          "v3 <- a",
          "cmp1 <- v3 - -2.000000e+00; cmp1 <- 1 - p(cmp1)(0)",
          "if.then_if.then2 <- round(cmp1, 2); if.then_if.end <- round(1 - cmp1, 2)",
          sep = ";"
    ),
    paste("v4 <- x.addr",
          "v5 <- y.addr",
          "mul3 <- v4 * v5",
          "retval <- mul3",
          "if.then2_return <- 1.00",
          sep = ";"
    )
  )

vertex_attr(g.foo, index = 1)$inst

plot(g.foo, l = "sugiyama", vertex.color = "skyblue", vertex.size = 40) # A simple plot of the network - we'll talk more about plots later



