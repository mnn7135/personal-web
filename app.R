library("shiny")
library(ambientweatheR)

#UI logic goes here
ui <- fluidPage(
  titlePanel(title = "Michael's Personal Website",
             windowTitle = "Michael's Personal Website"
  ),
  
  hr(),
  
  tagList(tags$head(tags$style(type = 'text/css', '.navbar-brand{display:none;}')),
          navbarPage("",
                     
                     #Home Page Tab and Content         
                     tabPanel(icon("home"),
                              tagList(tags$h1(
                                #source("inputs.R", local=TRUE)$value
                              )),
                     ),
                     
                     # Page showing details of the software projects I have
                     # worked on, including team size, methodology, and
                     # technologies used, along with any artifacts produced.
                     tabPanel("Software Projects",
                              tagList(tags$h1(
                                #source("munsonMoney.R", local=TRUE)$value
                              )),
                     ),
                     # Show and nicely display weather data pulled from
                     # Phoenix Station
                     tabPanel("Weather",
                              tagList(tags$h4(
                                source("weather.R", local=TRUE)$value
                              )),
                     ),
                     # Contact information
                     tabPanel("Contact",
                              tagList(tags$h1(
                                #source("compTestUI.R", local=TRUE)$value
                              ))
                     ),
          )
  ))

#Application Logic goes here
server <- function(input, output) {
  Sys.setenv(AW_API_KEY = "9258f994d53042ca9bcbe7f5cc44dfbbfa366e4ca4ac43c19a33268a6e060cb6")
  Sys.setenv(AW_APPLICATION_KEY = "78a34a92bffc4cc8962e87525a8a35f843e1d5dda7a94c3f88114283d16389ed")
  information = fetch_device_data("E8:DB:84:E4:03:97")
  print(information[1])
  output$weatherAlerts <- renderTable(information[1])
}
# Run the application 
shinyApp(ui = ui, server = server)