#US eelction
rm(list = ls())
#packages 
packages <- c('ggplot2', 'corrplot','tidyverse','shiny','shinydashboard',
              'caret','dummies','mlbench','tidyr','Matrix','lubridate',
              'data.table','vtreat', 'rsample','scales')
#load packages
for (package in packages) {
    if (!require(package, character.only=T, quietly=T)) {
        install.packages(package)
        library(package, character.only=T)
    }
}

#load data
df <- read.csv("economy_us_election.csv")

# drop downs
presidents <- sort(as.vector(unique(df$President)))
presidential_party <- sort(as.vector(unique(df$Presidential.Party)))
market <- sort(as.vector(unique(df$Market)))

# Define UI for application
ui <- dashboardPage(
    dashboardHeader(title = "US Election & Market analysis"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("About", tabName = "about", icon = icon("dashboard")),
            menuItem("Presidential party", tabName = "party", icon = icon("list-alt")),
            menuItem("Presidents", tabName = "president", icon = icon("th"))
            
        )
    ),
    dashboardBody(
        tabItems(
            tabItem(tabName = "about",includeMarkdown("readme.md"),hr()),
            tabItem(tabName = "party",
                    sidebarLayout(
                        sidebarPanel(
                            checkboxInput("partyInput", choices = presidential_party),
                            checkboxInput("marketInput", choices = market)
                        ),
                    mainPanel(
                        h2("Presidential Party",style="text-align: center;")
                        #fluidRow(valueBoxOutput("countryOutput"),
                        #         valueBoxOutput("ciytOutput")),
                        #fluidRow(
                        #    valueBoxOutput("categoryOutput"),
                        #    valueBoxOutput("subCategoryOutput")
                        #),
                        #fluidRow(valueBoxOutput("amountRaisedOutput"),
                        #         valueBoxOutput("percentofSuccessfulProjectsOutput")
                        #)
                    )
            ),
            tabItem(tabName = "president",
                    sidebarLayout(
                        sidebarPanel(
                            checkboxInput("presidentInput", choices = presidents),
                            checkboxInput("marketInput", choices = market)
                        ),
                        mainPanel(
                            h2("President",style="text-align: center;"), 
                            #fluidRow(
                            #    h3("Amount pledged",style="text-align: center;"),
                            #    plotOutput("pledgeYearOutput"),
                            h3("# of pledges",style="text-align: center;")
                            #    plotOutput("pledgenumYearOutput")
                                #plotOutput(""),
                            )
                        )
                    )
            ) 
        )
    )
)



server <- function(input, output,session) {
    
}

shinyApp(ui, server)

