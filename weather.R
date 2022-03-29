library(shiny)

tagList(tags$h3(
  "Phoenix Station - East Victor, NY",
  hr(),
  verbatimTextOutput("alert", placeholder=TRUE),
  verbatimTextOutput("additionalWeather"),
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
tags$body(
  textOutput("date"),
  "Last maintenanced on 2022-03-26 12:53:00 EDT")
)

