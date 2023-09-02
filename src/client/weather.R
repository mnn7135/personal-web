library(shiny)

# written by Michael N

tagList(
  div(tags$h1(
    hr(),
    strong("Weather at Phoenix Station"),
    hr(),
  )),
  tags$h1(
    "Phoenix Station is my personal weather station that I mantain to gather
    weather data. This data is used to display alerts and make local
    predictions for Victor, NY. Weather forecasts are made live as new data
    comes in and are likely to change. The weather station is an
    AmbientWeather WS-2000 Smart Station.",
    hr(),
  ),
  tags$h2(strong("Warnings and Advisories")),
  hr(),
  tags$h3(
    div(align = "center", tags$h2(textOutput("alert"))),
    hr(),
    
    tags$h2(strong("Current Weather Conditions")),
    hr(),
    
    fluidRow(
      column(3, div(),),
      column(
        6,
        align = "center",
        uiOutput("weather_icon"),
        div(tags$h1(textOutput("weather_desc"),
                    style = "font-size: 80px;")),
        hr(),
        div(tags$h1(textOutput("out_temp"),
                    style = "font-size: 120px;")),
        hr(),
      ),
      column(3, div(),),
    ),
    fluidRow(
      column(3, div(),),
      column(6, align = "center",
             tags$h1(textOutput("out_feels")),
             tags$h1(textOutput("rain_last_hour"))),
      column(3, div(),),
    ),
    hr(),
    tags$h2(strong("Weather Forecast")),
    hr(),
    fluidRow(
      column(2),
      column(
        4,
        align = "center",
        div(tags$h2("Later Today")),
        hr(),
        uiOutput("weather_icon_later"),
        div(tags$h2(
          textOutput("weather_desc_later"),
          style = "font-size: 30px;"
        )),
        hr(),
        div(tags$h2(textOutput("out_high_later"),
                    style = "font-size: 20px;")),
        hr(),
      ),
      column(
        4,
        align = "center",
        div(tags$h2("Tomorrow")),
        hr(),
        uiOutput("weather_icon_1_day"),
        div(tags$h2(
          textOutput("weather_desc_1_day"),
          style = "font-size: 30px;"
        )),
        hr(),
        div(tags$h2(textOutput("out_high_1_day"),
                    style = "font-size: 20px;")),
        hr(),
      ),
      column(2),
    ),
    tags$h2(strong("Outdoor Details")),
    hr(),
    fluidRow(
      column(1,),
      column(2, div("Wind"),),
      column(2, div(textOutput("wind_speed")),
             style = 'border-left: 1px solid'),
      column(2, div(),),
      column(2, div("Pressure"),),
      column(2, div(textOutput("out_pressure")),
             style = 'border-left: 1px solid'),
      column(1,),
    ),
    hr(),
    fluidRow(
      column(1,),
      column(2, div("Wind Gusts"),),
      column(2, div(textOutput("wind_gust")),
             style = 'border-left: 1px solid'),
      column(2, div(),),
      column(2, div("UV Index"),),
      column(2, div(textOutput("solar_data")),
             style = 'border-left: 1px solid'),
      column(1,),
    ),
    hr(),
    fluidRow(
      column(1,),
      column(2, div("Humidity"),),
      column(2, div(textOutput("out_humidity")),
             style = 'border-left: 1px solid'),
      column(2, div(),),
      column(2, div("Daily Rainfall"),),
      column(2, div(textOutput("daily_rain")),
             style = 'border-left: 1px solid'),
      column(1,),
    ),
    hr(),
    fluidRow(
      column(1,),
      column(2, div("Dew Point"),),
      column(2, div(textOutput("out_dew_point")),
             style = 'border-left: 1px solid'),
      column(2, div(),),
      column(2, div(textOutput("windchill_text")),),
      column(2, div(textOutput("windchill_value")),
             style = 'border-left: 1px solid'),
      column(1,),
    ),
    hr(),
    
    fluidRow(column(12, tags$h2(
      strong("Data Graphs")
    ),)),
    hr(),
    fluidRow(
      column(2,),
      column(
        2,
        selectInput(
          "graph_type_1",
          "",
          choices = c(
            "Temperature",
            "Dew Point",
            "Humidity",
            "Pressure",
            "Rain",
            "Wind",
            "Wind Gusts",
            "UV Index"
          ),
          selected = "Temperature"
        ),
      ),
      column(
        2,
        selectInput(
          "graph_type_2",
          "",
          choices = c(
            "Temperature",
            "Dew Point",
            "Humidity",
            "Pressure",
            "Rain",
            "Wind",
            "Wind Gusts",
            "UV Index"
          ),
          selected = "Pressure"
        ),
      ),
      column(
        2,
        selectInput(
          "graph_type_3",
          "",
          choices = c(
            "Temperature",
            "Dew Point",
            "Humidity",
            "Pressure",
            "Rain",
            "Wind",
            "Wind Gusts",
            "UV Index"
          ),
          selected = "Wind"
        ),
      ),
      column(
        2,
        selectInput(
          "graph_type_4",
          "",
          choices = c(
            "Temperature",
            "Dew Point",
            "Humidity",
            "Pressure",
            "Rain",
            "Wind",
            "Wind Gusts",
            "UV Index"
          ),
          selected = "Humidity"
        ),
      ),
      column(2,),
    ),
    
    # Graphs
    
    hr(),
    fluidRow(column(6, div(
      plotOutput("data_graph_1")
    ),),
    column(6, div(
      plotOutput("data_graph_2")
    ),)),
    hr(),
    fluidRow(column(6, div(
      plotOutput("data_graph_3")
    ),),
    column(6, div(
      plotOutput("data_graph_4")
    ),)),
    hr(),
  ),
  div(
    tags$h1(
      "* 1 standard atmosphere of pressure equals 1013.25 millibars at sea level.",
      style = "font-size: 12px;"
    )
  ),
  div(
    tags$h1(
      textOutput("date"),
      "Last maintenanced on 07/26/22 2:33 PM EDT",
      style = "font-size: 14px;"
    )
  )
)
