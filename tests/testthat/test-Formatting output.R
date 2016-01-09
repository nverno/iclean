context("Formatting output")

test_that("center_text returns strings of proper length", {
    if (!simple_afs_check()) skip("Can't reach AFS directory.")
    expect_equal(length(mfiles), 21L)
})
