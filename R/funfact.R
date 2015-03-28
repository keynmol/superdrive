funfact <- function(f, ...){
  add_args <- list(...)
  function(...){
    ags <- list(...)
    ags <- c(ags, add_args)
    return(do.call(f, ags))
  }
}
