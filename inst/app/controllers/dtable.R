### dtable.R --- 
## Filename: dtable.R
## Description: Controllers for the DT::datatable
## Author: Noah Peart
## Created: Thu Jan  7 20:52:29 2016 (-0500)
## Last-Updated: Thu Jan  7 20:53:05 2016 (-0500)
##           By: Noah Peart
######################################################################
output$dtable <- DT::renderDataTable(
    vals$dat
)
