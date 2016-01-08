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
  
  ui <- shiny::shinyUI(
    shinydashboard::dashboardPage(
      shinydashboard::dashboardHeader(title ='Data Manipulation'),
      shinydashboard::dashboardSidebar(
        shinydashboard::menuItem(
          "Data", tabName="choose_data", icon=shiny::icon("th"),
          source(file.path(partials, 'choose_data_ui.R'), local=TRUE)$value
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
              shinydashboard::box(shiny::verbatimTextOutput('dfStr')),
              shinydashboard::box(shiny::verbatimTextOutput('dfNames'))
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
    ## Initialize list of data.tables as long as rfiles
    vals <- shiny::reactiveValues(
      dfs=vector('list', length(rfiles)),
      dfActive=NULL
    )
    
    ## Observers for data choosing
    source(file.path(controls, 'choose_data.R'), local=TRUE)$value
  }

  shiny::runApp(list(ui=ui, server=server))
  invisible()
}
