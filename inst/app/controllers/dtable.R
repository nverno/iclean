### dtable.R --- 
## Filename: dtable.R
## Description: Controllers for the DT::datatable
## Author: Noah Peart
## Created: Thu Jan  7 20:52:29 2016 (-0500)
## Last-Updated: Fri Jan  8 14:26:30 2016 (-0500)
##           By: Noah Peart
######################################################################
output$dtable <- DT::renderDataTable({
    vals$dfs[[dfInds()[1]]] # , extensions='Responsive'
})
