library(shiny)

tagList(tags$h3(
  "Phoenix Station - East Victor, NY",
  hr(),
  verbatimTextOutput("alert", placeholder=TRUE),
  hr(),
  textOutput("temp"),
  plotOutput("tempGraph"),
  hr(),
  textOutput("humidity"),
  hr(),
  textOutput("wind"),
  hr(),
  textOutput("pressure"),
  plotOutput("pressureGraph"),
  hr(),
  textOutput("rain"),
  hr(),
  textOutput("solar"),
  hr(),
),
tags$h4(
  textOutput("date"),)
)

