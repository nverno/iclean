## Controllers for ../partials/choose_data_ui.R
## Prefix: df

################################################################################
##
##                                 Observers
##
################################################################################
## Get data
shiny::observeEvent(input$dfUpdate, {
  rfname <- if (input$dfUseMasterNames) {
    input$data
  } else dfkey[filename == input$data, rname]
  print(rfname)
  
  ## Load data into list
  vals$dfs[[rfname]] <- sync.afs::get_data(rfname, dkey=dfkey)
  vals$dfActive <- rfname
  print(head(vals$dfs[[rfname]]))
})

## Change b/w R/master file names
shiny::observeEvent(input$dfUseMasterNames, {
  print('master names')
    if (input$dfUseMasterNames) {
      choices <- setNames(rfiles, mfiles)
      current <- mfiles[rfiles == input$data]
    } else {
      choices <- setNames(rfiles, rfiles)
      current <- rfiles[mfiles == input$data]
    }
    shiny::updateSelectInput(session, inputId='data', choices=choices, selected=current)
})

################################################################################
##
##                       Output for 'choose_data' tab
##
################################################################################
output$dfStr <- renderPrint({
  str(vals$dfs[[vals$dfActive]])
})

output$dfNames <- renderPrint(names(vals$dfs[[vals$dfActive]]))
