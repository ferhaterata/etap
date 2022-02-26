n <- 20
h1 <- hcl.colors(n, palette = "Dynamic")
h2 <- hcl.colors(n, palette = "Tofino")
h3 <- hcl.colors(n, palette = "Berlin")
h4 <- hcl.colors(n, palette = "Dark 3")
h5 <- hcl.colors(n, palette = "Dark 2")
hcl.pals("diverging")
hcl.pals("qualitative")
library(unikn)
seecol(list(h1, h2, h3, h4, h5),
       col_brd = "white", lwd_brd = 4,
       title = "Example palettes from hcl.colors(n = 10)",
       pal_names = c("h1", "h2", "h3", "h4", "h5"))

