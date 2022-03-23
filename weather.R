library(shiny)

tagList(tags$h3(
  "Phoenix Station - East Victor, NY",
  hr(),
  verbatimTextOutput("alert"),
  hr(),
  textOutput("temp"),
  hr(),
  textOutput("humidity"),
  hr(),
  textOutput("wind"),
  hr(),
  textOutput("pressure"),
  hr(),
  textOutput("rain"),
  hr(),
  textOutput("solar"),
  hr(),
),
tags$h4(
  textOutput("date"),)
)

