## Controllers for ../partials/choose_data_ui.R
## Manage loading datasets/tracking active ones
## Prefix: df

################################################################################
##
##                                 Observers
##
################################################################################
## Get data
shiny::observeEvent(input$dfUpdate, {
    rfname <- input$data
    vals$dfs[[rfname]] <- sync.afs::get_data(rfname, dkey=dfkey)
    vals$status[dataset == rfname, `:=`(loaded=TRUE, active=TRUE)]
    print(sprintf('Loaded %s', rfname))
})

## Change b/w R/master file names
shiny::observeEvent(input$dfUseMasterNames, {
    choices <- if (input$dfUseMasterNames) setNames(rfiles, mfiles)
               else setNames(rfiles, rfiles)
    current <- input$data
    shiny::updateSelectInput(session, inputId='data', choices=choices, selected=current)
})
