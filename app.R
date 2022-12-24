library("shiny")
library(ambientweatheR)

#UI logic goes here
ui <- fluidPage(tags$style('.container-fluid {
                             background-color: white;
              }', ".container-fluid {color: black;
                                 font-size: 20px;
                                 font-style: bold;
                                 font-family: arial;
                                 }"),
  titlePanel(title = tags$h1(strong("")),
             windowTitle = "Michael's Website"
  ),
  hr(),
  
  tagList(tags$head(tags$style('body { word-wrap: break-word; }',  '.navbar-brand{display:none; color: white;}')),
          navbarPage("",
                     
                     #Home Page Tab and Content         
                     tabPanel(tags$h1(icon("home"), strong("Home |")),
                              tagList(tags$h3(
                                source("home.R", local=TRUE)$value
                              )),
                     ),
                     
                     # Page showing details of the software projects I have
                     # worked on, including team size, methodology, and
                     # technologies used, along with any artifacts produced.
                     tabPanel(tags$h1(icon("user"), strong("About Me |")),
                              tagList(tags$h3(
                                source("projects.R", local=TRUE)$value
                              )),
                     ),
                     # Show and nicely display weather data pulled from
                     # Phoenix Station
                     tabPanel(tags$h1(icon("cloud"), strong(textOutput("weatherTab", inline = TRUE), " |")),
                              tagList(tags$h3(
                                source("weather.R", local=TRUE)$value
                              )),
                     ),
          )
  ),
  hr(),
  "Website developed by Michael Nersinger",
  br(),
  tags$a(href="https://github.com/mnn7135/personal-web/", target="_blank", "https://github.com/mnn7135/personal-web/"),
  hr()
  )

#Application Logic goes here
server <- function(input, output) {
  Sys.setenv(AW_API_KEY = "9258f994d53042ca9bcbe7f5cc44dfbbfa366e4ca4ac43c19a33268a6e060cb6")
  Sys.setenv(AW_APPLICATION_KEY = "78a34a92bffc4cc8962e87525a8a35f843e1d5dda7a94c3f88114283d16389ed")
  Sys.setenv(GITHUB_PAT = "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")
  
  source("weatherServer.R", local=TRUE)$value
}
# Run the application 
shinyApp(ui = ui, server = server)