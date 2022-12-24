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
    column(12, div(tags$h1(textOutput("outTemp"), style="font-size: 200px;"), hr(), 
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
    column(2, div("Wind Chill"),
    ),
    column(2, div(textOutput("windchillValue")),
    ),
  ),
  hr(),
  
  fluidRow(
    column(12, tags$h2(strong("Data Graphs")),
    )
  ),
  hr(),
  fluidRow(
    column(3, selectInput("graphType1", "Graph One", choices = c("Temperature", "Dew Point", "Humidity", "Pressure", "Rain", "Wind", "Wind Gusts", "UV Index"), selected = "Temperature"),
    ),
    column(3, selectInput("graphType2", "Graph Two", choices = c("Temperature", "Dew Point", "Humidity", "Pressure", "Rain", "Wind", "Wind Gusts", "UV Index"), selected = "Dew Point"),
    ),
    column(3, selectInput("graphType3", "Graph Three", choices = c("Temperature", "Dew Point", "Humidity", "Pressure", "Rain", "Wind", "Wind Gusts", "UV Index"), selected = "Wind"),
    ),
    column(3, selectInput("graphType4", "Graph Four", choices = c("Temperature", "Dew Point", "Humidity", "Pressure", "Rain", "Wind", "Wind Gusts", "UV Index"), selected = "Pressure"),
    )
  ),
  
  # Graph 1 & 2
  
  hr(),
  fluidRow(
    column(6, textOutput("graph1"),
    ),
    column(6, textOutput("graph2"),
    )
  ),
  hr(),
  fluidRow(
    column(6, div(plotOutput("dataGraph1")),
    ),
    column(6, div(plotOutput("dataGraph2")),
    )
  ),
  br(),
  
  # Graph 3 & 4
  hr(),
  fluidRow(
    column(6, textOutput("graph3"),
    ),
    column(6, textOutput("graph4"),
    )
  ),
  hr(),
  fluidRow(
    column(6, div(plotOutput("dataGraph3")),
    ),
    column(6, div(plotOutput("dataGraph4")),
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

