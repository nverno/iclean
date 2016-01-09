##' Wrapper for sync.afs::get_data
##' @title Retrieve a vector of datasets from AFS
##' @param data dataset names
##' @param key key linking names to master file locations.
##' @return list of data.tables names according to 'data'
##' @export
get_all <- function(data, key) {
    setNames(lapply(data, sync.afs::get_data, dkey=key), data)
}

##' remove nulls/empty values from list
##' @title Remove null/empty elements from list
##' @param lst List to clean.
##' @param check_nested logical determines if nested lists should be unlisted.
##' @return Cleaned list
##' @export
nonEmpty <- function(lst, check_nested=TRUE) {
    if (check_nested) {
        lst[vapply(lst, function(i) 
            !is.null(i) && 
            length(unlist(i, use.names=FALSE)), logical(1))]
    } else {
        lst[vapply(lst, function(i) 
            !is.null(i) && 
            length(i), logical(1))]
    }
}

##' Find variables matching patterns in different datasets.
##' @title Search datasets for variables matching patterns.
##' @param pattern Vector of patterns to search for (can be regex).
##' @param data Vector of datasets from which to search for variable matches.
##' @param regex Logical whether to use regex or search for exact matches.
##' @param ... Passed to \code{grep}
##' @return List of datasets with matches.
##' @export
grep_vars <- function(pattern, data, regex=TRUE, ...) {
    res <- lapply(data, function(dat) {
        if (regex) {
            Vectorize(grep, 'pattern')(pattern, names(dat), value=TRUE, ...)
        } else names(dat)[names(dat) %in% pattern]
    })
    names(res) <- names(data)
    nonEmpty(res)
}

##' Format lists for output
print_list <- function(lst, offset=1, width=30, ...) {
    cl <- match.call()[-1L]
    if (!("sep" %in% names(cl))) sep <- ", "
    strings <- lapply(lst, function(val) {
        capture.output
    })
}

##' Center justify vector of strings.
center_text <- function(words, width, sep=", ", ...) {
    strings <- capture.output(cat(words, sep=sep, fill=width))
}

## Testing
tst <- get_all(rfiles, dfkey)
lst <- grep_vars("98", tst)
