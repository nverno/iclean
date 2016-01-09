##' Mess around with data interactively (clean/reshape etc.)
##' 
##' @title Interactively manipulate master files.
##' @param use_afs Use master files from AFS
##' @param update Update AFS files before grabbing.
##' @param data Data to use (default NULL, and use AFS data)
##' @import data.table shiny shinydashboard
##' @export
data_manip <- function(use_afs=TRUE, update=FALSE, data=NULL) {
    if (use_afs) {
        sync.afs::check_afs()
        path <- sync.afs::get_afs()
        filename <- rname <- NULL
        dfkey <- if (update) sync.afs::update_key() else data.table::copy(sync.afs::data_key)

        ## some variables for selectors
        dtypes <- c('sas7bdat', 'csv', 'rda')  # file types to include for data choices
        rfiles <- dfkey[filetype %in% dtypes, rname]
        mfiles <- dfkey[filetype %in% dtypes, filename]
    }

    ## Deal with alternative where data is specified.
    
    ## App
    partials <- 'inst/app/partials'
    controls <- 'inst/app/controllers'
    
    ## dashboard components
    source(file.path(partials, "dashboardSidebar.R"), local=TRUE)$value  # dash_sidebar
    source(file.path(partials, "dashboardBody.R"), local=TRUE)$value     # dash_body

    ui <- shiny::shinyUI(
        shinydashboard::dashboardPage(
            shinydashboard::dashboardHeader(title ='Data Manipulation'),
            dash_sidebar,
            dash_body
        )
    )
    
    server <- function(input, output, session) {
        ## Initialize list of data.tables as long as rfiles
        vals <- shiny::reactiveValues(
            dfs=setNames(vector('list', length(rfiles)), rfiles),
            status=data.table::data.table(dataset=rfiles, loaded=FALSE, active=FALSE)
        )
        
        ## Observers for data choosing
        source(file.path(controls, 'choose_data.R'), local=TRUE)
        source(file.path(controls, 'dtable.R'), local=TRUE)
        source(file.path(controls, 'summary.R'), local=TRUE)
    }

    shiny::runApp(list(ui=ui, server=server))
    invisible()
}
