library("dequer") # required for an efficient implementation of stack

DFS <- function(prev, v, path, prob, visited, edge_visited, env) {
  nodes <- stack()
  push(nodes, list(prev, v, path, prob, visited, edge_visited, env))
  while (length(nodes)) {
    e <- pop(nodes)
    prev <- e[[1]]; v <- e[[2]]; path <- e[[3]]; prob <- e[[4]];
    visited <- e[[5]]; edge_visited <- e[[6]]; env <- e[[7]]
    #  mark v visited
    visited[[v$name]] <- visited[[v$name]] + 1
    color[v$name] <<- "gray"
    # add blockname to the path
    path <- paste0(path, "%", v$name)
    # initialize current block
    .block <<- v
    # execute block's instructions
    for (inst in v$insts) {
      eval(parse(text = inst[1]), envir = env)
    }
    # eval path probability
    if (length(prev)) {
      expr <- paste0(prev$name, "_", v$name)
      value <- eval(parse(text = expr), envir = env)
      out <- paste0(prev$name, "#", v$name)
      edge_visited[[out]] <- edge_visited[[out]] + 1
      # print(paste0(out, " = ", value))
      prob <- paste0(prob, "*", value)
    }
    # for each successor v' of v { fs
    for (i in seq_along(succs[[v$name]])) {
      # if v' not yet visited and prob is greater than 0 {
      if (length(succs[[v$name]][[i]])) {
        expr <- paste0(v$name, "_", succs[[v$name]][[i]]$name)
        value <- eval(parse(text = expr), envir = env)
        if (value > 0 && all(visited <= max_loop)) {
          # if (i == 1) clone <- env # to be more efficient
          # else
          clone <- rlang::env_clone(env) # don't create unnecessary envs.
          push(nodes, list(v, succs[[v$name]][[i]], path, prob, visited, edge_visited, clone))
        }
      }
    }
    #
    if (!length(succs[[v$name]])) {
      color[v$name] <<- "black"
      p <- eval(parse(text = prob), envir = env)
      path.prob <<- c(path.prob, round(p, 5)) # TODO: is rounding good here?
      line <- paste0(path, ":", prob, "=", p)
      write(line, file = profile, append = TRUE)
      for (i in seq_along(visited)) {
        if (visited[[i]] != 0) {
          # collect frequency as percentage
          freq[names(visited)[i]] <<- paste0(freq[names(visited)[i]], "+", eval(parse(text = prob)))
          total_visit[[names(visited)[i]]] <<- total_visit[[names(visited)[i]]] + visited[[i]]
        }
      }
      for (i in seq_along(edge_visited)) {
        if (edge_visited[[i]] != 0) {
          edge_global[i] <<- paste0(edge_global[i], "+", eval(parse(text = prob)))
          edge_local[[i]] <<- edge_local[[i]] + edge_visited[[i]]
        }
      }
    }
  }
}
