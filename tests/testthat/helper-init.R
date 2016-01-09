if (interactive()) sync.afs::check_afs()
simple_afs_check <- function() {
  file.exists(sync.afs::get_afs())
}

if (!simple_afs_check()) stop("No AFS connection.")

## some variables for selectors
dfkey <- data.table::copy(sync.afs::data_key)
dtypes <- c('sas7bdat', 'csv', 'rda')  # file types to include for data choices
rfiles <- dfkey[filetype %in% dtypes, rname]
mfiles <- dfkey[filetype %in% dtypes, filename]

all_dat <- get_all(rfiles, key=dfkey)  # ~50-60 MB
