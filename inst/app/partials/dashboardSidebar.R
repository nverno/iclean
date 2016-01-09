dash_sidebar <- shinydashboard::dashboardSidebar(
    source(file.path(partials, 'choose_data_ui.R'), local=TRUE)$value,
    shinydashboard::sidebarMenu(
        shinydashboard::menuItem("Summary", tabName="summary"),
        shinydashboard::menuItem("Table", tabName="table")
    )
)
