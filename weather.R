library(shiny)

tagList(div(tags$h1(
    strong("Weather at Phoenix Station"),
    hr(), style="font-size: 45px;"
  )), 
  tags$h1(
    "Phoenix Station is my own personal weather station that I mantain and use to gather weather data. Using the API provided by AmbientWeather, and with support and documentation available for R, I was able to create a small page that displays local weather information for Victor, NY. Sorry if you live elsewhere, you should still check out other AmbientWeather.net weather stations, as almost all are owned by weather enthusiasts like me! The weather station is an AmnientWeather WS-2000 Smart Station.",
    hr(),
  ),
  tags$h3(
  verbatimTextOutput("alert", placeholder=TRUE),
  hr(),
  
  tags$h2(strong("Current Weather Conditions")),
  hr(),
  
  fluidRow(
    column(3, div(),
    ),
    column(6, align="center", uiOutput("weatherIcon"), div(tags$h1(textOutput("weatherDesc"), style="font-size: 80px;")), hr(), div(tags$h1(textOutput("outTemp"), style="font-size: 120px;")), hr(), 
    ),
    column(3, div(),
    ),
  ),
  fluidRow(
    column(3, div(),
    ),
    column(6, align="center",
           tags$h1(textOutput("outFeels")),
           tags$h1(textOutput("rainLastHour"))),
    column(3, div(),
    ),
  ),
  hr(),
  tags$h2(strong("Weather Forecast")),
  fluidRow(
    column(4, align="center", div(tags$h2("Later Today")), hr(), uiOutput("weatherIconLater"), div(tags$h2(textOutput("weatherDescLater"), style="font-size: 30px;")), hr(), div(tags$h2(textOutput("outHighLater"), style="font-size: 20px;")), hr(),
    ),
    column(4, align="center", div(tags$h2("Tomorrow")), hr(), uiOutput("weatherIcon1Day"), div(tags$h2(textOutput("weatherDesc1Day"), style="font-size: 30px;")), hr(), div(tags$h2(textOutput("outHigh1Day"), style="font-size: 20px;")), hr(),
    ),
    column(4, align="center", div(tags$h2("2 Day")), hr(), uiOutput("weatherIcon2Day"), div(tags$h2(textOutput("weatherDesc2Day"), style="font-size: 30px;")), hr(), div(tags$h2(textOutput("outHigh2Day"), style="font-size: 20px;")), hr(),
    ),
  ),
  tags$h2(strong("Outdoor Details")),
  hr(),
  fluidRow(
    column(1,
    ),
    column(2, div("Wind"),
    ),
    column(2, div(textOutput("windSpeed")),
           style = 'border-left: 1px solid'
    ),
    column(2, div(),
    ),
    column(2, div("Pressure"),
    ),
    column(2, div(textOutput("outPressure")),
           style = 'border-left: 1px solid'
    ),
    column(1,
    ),
  ),
  hr(),
  fluidRow(
    column(1,
    ),
    column(2, div("Wind Gusts"),
    ),
    column(2, div(textOutput("windGust")),
           style = 'border-left: 1px solid'
    ),
    column(2, div(),
    ),
    column(2, div("UV Index"),
    ),
    column(2, div(textOutput("solarData")),
           style = 'border-left: 1px solid'
    ),
    column(1,
    ),
  ),
  hr(),
  fluidRow(
    column(1,
    ),
    column(2, div("Humidity"),
    ),
    column(2, div(textOutput("outHumidity")),
           style = 'border-left: 1px solid'
    ),
    column(2, div(),
    ),
    column(2, div("Daily Rainfall"),
    ),
    column(2, div(textOutput("dailyRain")),
           style = 'border-left: 1px solid'
    ),
    column(1,
    ),
  ),
  hr(),
  fluidRow(
    column(1,
    ),
    column(2, div("Dew Point"),
    ),
    column(2, div(textOutput("outDewPoint")),
           style = 'border-left: 1px solid'
    ),
    column(2, div(),
    ),
    column(2, div(textOutput("windchillText")),
    ),
    column(2, div(textOutput("windchillValue")),
           style = 'border-left: 1px solid'
    ),
    column(1,
    ),
  ),
  hr(),
  
  fluidRow(
    column(12, tags$h2(strong("Data Graphs")),
    )
  ),
  hr(),
  fluidRow(
    column(2,
    ),
    column(2, selectInput("graphType1", "", choices = c("Temperature", "Dew Point", "Humidity", "Pressure", "Rain", "Wind", "Wind Gusts", "UV Index"), selected = "Temperature"),
    ),
    column(2, selectInput("graphType2", "", choices = c("Temperature", "Dew Point", "Humidity", "Pressure", "Rain", "Wind", "Wind Gusts", "UV Index"), selected = "Pressure"),
    ),
    column(2, selectInput("graphType3", "", choices = c("Temperature", "Dew Point", "Humidity", "Pressure", "Rain", "Wind", "Wind Gusts", "UV Index"), selected = "Wind"),
    ),
    column(2, selectInput("graphType4", "", choices = c("Temperature", "Dew Point", "Humidity", "Pressure", "Rain", "Wind", "Wind Gusts", "UV Index"), selected = "Humidity"),
    ),
    column(2,
    ),
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
  hr(),
),
div(tags$h1("* 1 standard atmosphere of pressure equals 1013.25 millibars at sea level.", style="font-size: 12px;")),
div(tags$h1(
  textOutput("date"),
  tableOutput("testTable"),
  "Last maintenanced on 07/26/22 2:33 PM EDT", style="font-size: 14px;"))
)
