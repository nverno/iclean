context("Formatting output")
library(data.table)

simple_afs_check <- function() {
    file.exists(sync.afs::get_afs())
}

test_that("center_text returns strings of proper length", {
    if (!simple_afs_check()) skip("Can't reach AFS directory.")

})
