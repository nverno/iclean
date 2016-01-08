##' Mess around with data interactively (clean/reshape etc.)
##' @param use_afs Use master files from AFS
##' @param update Update AFS files before grabbing.
##' @param data Data to use (default NULL, and use AFS data)
##' @include data.table shiny shinydashboard
##' @export
iclean <- function(use_afs=TRUE, update=FALSE, data=NULL) {
    if (use_afs) {
        sync.afs::check_afs()
        path <- sync.afs::get_afs()
        filename <- rname <- NULL
        dkey <- if (update) sync.afs::update_key() else data.table::copy(sync.afs::data_key)

        ## some variables for selectors
        dtypes <- c('sas7bdat', 'csv', 'rda')  # file types to include for data choices
        rfiles <- dkey[filetype %in% dtypes, rname]
        mfiles <- dkey[filetype %in% dtypes, filename]
    }

    ## Deal with alternative where data is specified.
    
    ## App
    partials <- 'inst/app/partials'
    controls <- 'inst/app/controllers'
    vals <- NULL
    
    ui <- shiny::shinyUI(
        shinydashboard::dashboardPage(
            shinydashboard::dashboardHeader(title ='Data Manipulation'),
            shinydashboard::dashboardSidebar(
                shinydashboard::menuItem(
                    "Data", tabName="choose_data", icon=shiny::icon("th"),
                    source(file.path(partials, 'choose_data_ui.R'), local=TRUE)
                ),
                shinydashboard::menuItem(
                    "Table", tabName="dtable", icon=shiny::icon("table"),
                    shiny::fluidRow(DT::dataTableOutput('dtable'), height=300))
            ),
            shinydashboard::dashboardBody(
                shinydashboard::tabItems(
                    ## First tab
                    shinydashboard::tabItem(
                        tabName='choose_data',
                        shiny::fluidRow(
                            shinydashboard::box(str(isolate(vals$dat))),
                            shinydashboard::box(shiny::renderPrint(isolate(names(vals$dat))))
                        )
                    ),
                    shinydashboard::tabItem(
                        tabName='dtable',
                        shiny::fluidRow(DT::dataTableOutput('dtable'), height=300)
                    )
                )
            )
        )
    )
    
    server <- function(input, output, session) {
        vals <- shiny::reactiveValues(dat=data.frame())
        
        ## Observers for data choosing
        source(file.path(controls, 'choose_data.R'), local=TRUE)$value
    }

    shiny::runApp(list(ui=ui, server=server))
}
