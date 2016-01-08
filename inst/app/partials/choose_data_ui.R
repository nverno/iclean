##' UI for choosing dataset
choose_data <- shiny::tagList(
    shiny::selectInput('data', 'Data', choices=rfiles, selected='pp_raw'),
    shiny::checkboxInput('useMasterNames', 'Use master file names', value=FALSE),
    shiny::actionButton('update', 'Update')
)
