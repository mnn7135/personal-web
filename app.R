library(shiny)
library(ambientweatheR)

# written by Michael N

ui <- fluidPage(tags$style(".container-fluid {color: black;
                                 font-size: 20px;
                                 font-style: bold;
                                 font-family: arial;
                                 }"),
  
  titlePanel(title = tags$h1(strong("")),
             windowTitle = "Michael's Homepage"
  ),
  tagList(tags$head(tags$style('body { word-wrap: break-word; }', 
                               '.navbar-brand{ display:none; }')),
          navbarPage("",
                     
                     # Home    
                     tabPanel(tags$h1(strong("|", icon("home"), " Home")),
                              tagList(tags$h3(
                                source("src/client/home.R", local=TRUE)$value
                              )),
                     ),
                     
                     # Projects
                     tabPanel(tags$h1(strong("|", icon("chart-bar"), 
                                             "Projects")),
                              tagList(tags$h3(
                                source("src/client/projects.R", local=TRUE)$value
                              )),
                     ),
                     
                     # Weather
                     tabPanel(tags$h1(strong("| ", uiOutput("weather_tooltip", 
                                                            inline = TRUE), 
                                             textOutput("weather_tab", 
                                                        inline = TRUE))),
                              tagList(tags$h3(
                                source("src/client/weather.R", local=TRUE)$value
                              )),
                     ),
                     # Astronomy
                     tabPanel(tags$h1(strong("| ", icon("star"), "Astronomy")),
                              tagList(tags$h3(
                                source("src/client/astronomy.R", local=TRUE)$value
                              )),
                     ),
          )
  ),
  hr(),
  "Website developed by Michael Nersinger",
  br(),
  tags$a(href="https://github.com/mnn7135/personal-web/", target="_blank", 
         "https://github.com/mnn7135/personal-web/"),
  hr()
  )


server <- function(input, output) {
  
  source("src/server/weather_server.R", local=TRUE)$value
  
}

# Run the application.
shinyApp(ui = ui, server = server)
