library(shiny)
library(ambientweatheR)

# written by Michael N

ui <- fluidPage(
  tags$style(
    ".container-fluid {color: black;
                                 font-size: 16px;
                                 font-family: arial;
                                 }
    hr { border-color: black; }"
  ),
  titlePanel(
    title = tags$h1(strong("")),
    windowTitle = "Michael's Homepage"
  ),
  tagList(
    tags$head(
      tags$style(
        "body { word-wrap: break-word; }",
        ".navbar-brand{ display:none; }"
      )
    ),
    navbarPage(inverse=TRUE,
      "",
      # Home
      tabPanel(
        tags$h1(strong(
          "|", icon("home"), " Home"
        )),
        tagList(tags$h3(source(
          "src/client/home.R",
          local = TRUE
        )$value))
      ),
      # Projects
      tabPanel(
        tags$h1(strong(
          "|", icon("chart-bar"),
          "Projects"
        )),
        tagList(tags$h3(source(
          "src/client/projects.R",
          local = TRUE
        )$value))
      ),
      # Weather
      tabPanel(
        tags$h1(strong(
          "| ",
          uiOutput("weather_tooltip",
            inline = TRUE
          ),
          textOutput("weather_tab",
            inline = TRUE
          )
        )),
        tagList(tags$h3(source(
          "src/client/weather.R",
          local = TRUE
        )$value))
      ),
      # Astronomy
      tabPanel(
        tags$h1(strong(
          "| ", icon("star"), "Astronomy"
        )),
        tagList(tags$h3(source(
          "src/client/astronomy.R",
          local = TRUE
        )$value))
      ), 
    )
  ),
  hr(),
  div("Website developed by Michael Nersinger | ", 
      tags$a(
        href = "https://github.com/mnn7135/personal-web/",
        target = "_blank",
        "https://github.com/mnn7135/personal-web/",
        style = "font-size: 14px;"
      ),
      style = "font-size: 14px;"),
  hr()
)
server <- function(input, output) {
  # Handle App level server configurations for fetching data.
  Sys.setenv(
    AW_API_KEY =
      "9258f994d53042ca9bcbe7f5cc44dfbbfa366e4ca4ac43c19a33268a6e060cb6"
  )
  Sys.setenv(
    AW_APPLICATION_KEY =
      "78a34a92bffc4cc8962e87525a8a35f843e1d5dda7a94c3f88114283d16389ed"
  )
  Sys.setenv(GITHUB_PAT = "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")
  Sys.setenv(TZ = "America/New_York")

  source("src/server/weather_server.R", local = TRUE)$value
}
# Run the application.
shinyApp(ui = ui, server = server)
