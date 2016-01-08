
## Get data
shiny::observeEvent(input$update, {
    vals$dat <- if (input$useMasterNames) {
                    sync.afs::get_data(sync.afs::data_key[filename == input$data, rname],
                                       dkey=dkey)
                } else sync.afs::get_data(input$data, dkey=dkey)
})

## Change b/w R/master file names
shiny::observeEvent(input$useMasterNames, {
    if (input$useMasterNames) {
        choices <- dkey[filetype %in% dtypes, filename]
        current <- dkey[rname == input$data, filename]
    } else {
        choices <- dkey[filetype %in% dtypes, rname]
        current <- dkey[filename == input$data, rname]
    }
    shiny::updateSelectInput(session, inputId='data', choices=choices, selected=current)
})

