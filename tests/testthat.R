library(testthat)
library(iclean)
library(data.table)

simple_afs_check <- function() {
  file.exists(sync.afs::get_afs())
}

## some variables for selectors
dfkey <- data.table::copy(sync.afs::data_key)
dtypes <- c('sas7bdat', 'csv', 'rda')  # file types to include for data choices
rfiles <- dfkey[filetype %in% dtypes, rname]
mfiles <- dfkey[filetype %in% dtypes, filename]

filt <- if (simple_afs_check()) NULL else "***"
if (is.null(filt)) {
  dfs <- get_all(rfiles, key=dfkey)
  test_check("iclean", filter=filt)
}

