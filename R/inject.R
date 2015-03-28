inject <- function(func, ...){
  namespace <- list(...)
  old_values <- list()

  # what the actual fuck, Anton?
  for(n in names(namespace)){ # what
    old_values[[n]] <- globalenv()[[n]] # the
    assign(n, namespace[[n]], globalenv()) # fuck?
  }

  result <- tryCatch(func(), finally = {
    for(n in names(namespace)){
      assign(n, old_values[[n]], globalenv())
    }
  })

  return(result)
}
