library(shiny)

tagList(tags$h1(
    strong("Phoenix Station - Victor, NY"),
    hr()
  ), tags$h3(
  verbatimTextOutput("alert", placeholder=TRUE),
  hr(),
  
  tags$h2(strong("Current Weather Conditions")),
  hr(),
  fluidRow(
    column(12, div(tags$h1(textOutput("outTemp"), style="font-size: 250px;"), hr(), 
    ),
    column(12, 
                  tags$h1(textOutput("outFeels")),
                  tags$h1(textOutput("rainLastHour"))),
    ),
  ),
  hr(),
  
  tags$h2(strong("Outdoor Details")),
  hr(),
  fluidRow(
    column(2, div("Wind"),
    ),
    column(2, div(textOutput("windSpeed")),
    ),
    column(4, div(),
    ),
    column(2, div("Pressure"),
    ),
    column(2, div(textOutput("outPressure")),
    ),
  ),
  hr(),
  fluidRow(
    column(2, div("Wind Gusts"),
    ),
    column(2, div(textOutput("windGust")),
    ),
    column(4, div(),
    ),
    column(2, div("UV Index"),
    ),
    column(2, div(textOutput("solarData")),
    ),
  ),
  hr(),
  fluidRow(
    column(2, div("Humidity"),
    ),
    column(2, div(textOutput("outHumidity")),
    ),
    column(4, div(),
    ),
    column(2, div("Daily Rainfall"),
    ),
    column(2, div(textOutput("dailyRain")),
    ),
  ),
  hr(),
  fluidRow(
    column(2, div("Dew Point"),
    ),
    column(2, div(textOutput("outDewPoint")),
    ),
    column(4, div(),
    ),
    column(2, div(),
    ),
    column(2, div(),
    ),
  ),
  hr(),
  
  fluidRow(
    column(12, tags$h2(strong("Data Graphs")),
    )
  ),
  hr(),
  fluidRow(
    column(6, selectInput("graphType1", "Select graph one data.", choices = c("Temperature", "Dew Point", "Humidity", "Pressure", "Rain", "Wind", "UV Index"), selected = "Temperature"),
    ),
    column(6, selectInput("graphType2", "Select graph two data.", choices = c("Temperature", "Dew Point", "Humidity", "Pressure", "Rain", "Wind", "UV Index"), selected = "Pressure"),
    )
  ),
  
  # Graph 1
  
  hr(),
  fluidRow(
    column(12, textOutput("graph1"),
    )
  ),
  hr(),
  fluidRow(
    column(12, div(plotOutput("dataGraph1")),
    )
  ),
  br(),
  
  # Graph 2
  
  fluidRow(
    column(12, textOutput("graph2"),
    )
  ),
  hr(),
  fluidRow(
    column(12, div(plotOutput("dataGraph2")),
    )
  ),
  hr(),
  
  tags$h2(strong("Indoor Details")),
  hr(),
  fluidRow(
    column(2, div("Temperature"),
    ),
    column(2, div(textOutput("inTemp")),
    ),
    column(4, div(),
    ),
    column(2, div("Pressure"),
    ),
    column(2, div(textOutput("inPressure")),
    ),
  ),
  hr(),
  fluidRow(
    column(2, div("Humidity"),
    ),
    column(2, div(textOutput("inHumidity")),
    ),
    column(4, div(),
    ),
    column(2, div("Feels Like"),
    ),
    column(2, div(textOutput("inFeels")),
    ),
  ),
  hr(),
  fluidRow(
    column(2, div("Dew Point"),
    ),
    column(2, div(textOutput("inDewPoint")),
    ),
    column(4, div(),
    ),
    column(2, div(),
    ),
    column(2, div(),
    ),
  ),
  hr(),
),
tags$body(
  textOutput("date"),
  "Last maintenanced on 07/26/22 2:33 PM EDT")
)

