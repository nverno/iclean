##' Wrapper for file.access to test file write permissions.
##' From \code{dplyr}
##' @title Check file write permission.
##' @param x File path
##' @export
is_writeable <- function(x) {
  unname(file.access(x, 2) == 0L)
}

