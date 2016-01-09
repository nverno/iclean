## UI for selecting data file
shiny::tagList(
  shiny::selectInput('data', 'Data', choices=setNames(rfiles, rfiles), selected='pp_raw'),
  shiny::checkboxInput('dfUseMasterNames', 'Use master file names', value=FALSE),
  shiny::actionButton('dfUpdate', 'Update', width="100%")
)
