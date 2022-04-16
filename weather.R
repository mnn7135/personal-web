library(shiny)

tagList(tags$h1(
    strong("Phoenix Station - Victor, NY"),
    hr()
  ), tags$h3(
  verbatimTextOutput("alert", placeholder=TRUE),
  verbatimTextOutput("additionalWeather"),
  hr(),
  
  tags$h2(strong("Current Weather Conditions")),
  hr(),
  fluidRow(
    column(6, div(imageOutput("weatherImage")),
    ),
    column(6, div(tags$h1(textOutput("temp"), style="font-size: 150px;"), hr(), 
                  tags$h1(textOutput("currentWeather")),
                  tags$h1(textOutput("tempFeels")),
                  tags$h1(textOutput("rainLastHour"))),
    ),
  ),
  hr(),
  
  tags$h2(strong("Today's Details")),
  hr(),
  fluidRow(
    column(6, div("Wind"),
    ),
    column(6, div(textOutput("wind")),
    ),
  ),
  hr(),
  fluidRow(
    column(6, div("Wind Gusts"),
    ),
    column(6, div(textOutput("gust")),
    ),
  ),
  hr(),
  fluidRow(
    column(6, div("Humidity"),
    ),
    column(6, div(textOutput("humidity")),
    ),
  ),
  hr(),
  fluidRow(
    column(6, div("Dew Point"),
    ),
    column(6, div(textOutput("dPoint")),
    ),
  ),
  hr(),
  fluidRow(
    column(6, div("Pressure"),
    ),
    column(6, div(textOutput("pressure")),
    ),
  ),
  hr(),
  fluidRow(
    column(6, div("UV Index"),
    ),
    column(6, div(textOutput("solar")),
    ),
  ),
  hr(),
  fluidRow(
    column(6, div("Daily Rainfall"),
    ),
    column(6, div(textOutput("dailyRain")),
    ),
  ),
  
  hr(),
  tags$h2(strong("Data Graphs")),
  hr(),
  fluidRow(
    column(6, div("Temperature Graph"),
    ),
    column(6, div("Pressure Graph"),
    ),
  ),
  hr(),
  fluidRow(
    column(6, div(plotOutput("tempGraph")),
    ),
    column(6, div(plotOutput("pressureGraph")),
    ),
  ),
  br(),
  fluidRow(
    column(6, div("Rain Graph"),
    ),
    column(6, div("Wind Graph"),
    ),
  ),
  hr(),
  fluidRow(
    column(6, div(plotOutput("rainGraph")),
    ),
    column(6, div(plotOutput("windGraph")),
    ),
  ),
  #tags$h3(tableOutput("raw"), style="color: black;"), # for testing purposes
  hr()
),
tags$body(
  textOutput("date"),
  "Last maintenanced on 2022-03-26 12:53:00 EDT")
)

