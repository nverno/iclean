dash_body <- shinydashboard::dashboardBody(
    shinydashboard::tabItems(
        shinydashboard::tabItem(
            tabName='summary',
            shiny::fluidRow(
                shinydashboard::box(
                    DT::dataTableOutput('dfStatus')
                ),
                shinydashboard::box(
                    title='Column Names',
                    status='primary',
                    solidHeader=TRUE,
                    shiny::verbatimTextOutput('dfNames')
                ),
                shinydashboard::box(
                    title='Summary',
                    status='primary',
                    solidHeader=TRUE,
                    shiny::verbatimTextOutput('dfStr')
                )
            )
        ),
        shinydashboard::tabItem(
            tabName='table',
            shiny::fluidRow(
                shinydashboard::box(
                    div(style='overflow-x: scroll', DT::dataTableOutput('dtable')),
                    height=300,
                    width="100%"
                )
            )
        )
    )
)
