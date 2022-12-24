library(shiny)

tagList(div(tags$h1(
    strong("Phoenix Station - Victor, NY"),
    hr(), style="font-size: 80px;"
  )), tags$h3(
  verbatimTextOutput("alert", placeholder=TRUE),
  hr(),
  
  tags$h2(strong("Current Weather Conditions")),
  hr(),
  fluidRow(
    column(12, div(tags$h1(textOutput("outTemp"), style="font-size: 150px;"), hr(), 
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
    column(2, div(textOutput("windchillText")),
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
    column(3, selectInput("graphType2", "Graph Two", choices = c("Temperature", "Dew Point", "Humidity", "Pressure", "Rain", "Wind", "Wind Gusts", "UV Index"), selected = "Pressure"),
    ),
    column(3, selectInput("graphType3", "Graph Three", choices = c("Temperature", "Dew Point", "Humidity", "Pressure", "Rain", "Wind", "Wind Gusts", "UV Index"), selected = "Wind"),
    ),
    column(3, selectInput("graphType4", "Graph Four", choices = c("Temperature", "Dew Point", "Humidity", "Pressure", "Rain", "Wind", "Wind Gusts", "UV Index"), selected = "Humidity"),
    )
  ),
  
  # Graphs
  
  hr(),
  fluidRow(
    column(6, div(plotOutput("dataGraph1")),
    ),
    column(6, div(plotOutput("dataGraph2")),
    )
  ),
  hr(),
  fluidRow(
    column(6, div(plotOutput("dataGraph3")),
    ),
    column(6, div(plotOutput("dataGraph4")),
    )
  ),
  br(),
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
div(tags$h1("* 1 standard atmosphere of pressure equals 1013.25 millibars at sea level.", style="font-size: 12px;")),
div(tags$h1(
  textOutput("date"),
  "Last maintenanced on 07/26/22 2:33 PM EDT", style="font-size: 14px;"))
)
