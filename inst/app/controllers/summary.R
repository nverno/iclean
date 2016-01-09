### summary.R --- 
## Filename: summary.R
## Description: Controllers for 'Summary' tab
## Author: Noah Peart
## Created: Fri Jan  8 13:10:04 2016 (-0500)
## Last-Updated: Fri Jan  8 14:52:51 2016 (-0500)
##           By: Noah Peart
######################################################################
## Prefix: 'df'

################################################################################
##
##                                 Reactives
##
################################################################################
dfInds <- reactive({
    input$dfUpdate
    vals$status[active==TRUE,,which=TRUE]
})

dfLoaded <- reactive({
    input$dfUpdate
    vals$status[loaded==TRUE,,which=TRUE]
})

################################################################################
##
##                                  Outputs
##
################################################################################
## Present the state of the various datasets as DT::datatable
output$dfStatus <- DT::renderDataTable({
    input$dfUpdate
    vals$status
})

## Active datasets
output$dfActive <- renderUI({
    
})

output$dfStr <- renderPrint({
    if (length(dfInds())) {
        cat(str(vals$dfs[dfInds()]))
    } else 'No data active.'
})

output$dfNames <- renderPrint({
    if (length(dfInds())) {
        print(lapply(vals$dfs[dfInds()], names))
    } else 'No data active.'
})
