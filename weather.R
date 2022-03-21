library(shiny)

tagList(tags$h4(
  "Phoenix Station - East Victor, NY",
  br(),
  "Maintained by Michael N.",
  br(),
  "Time Received:",
  verbatimTextOutput("date"),
  br(),
  "Temperature (degrees F)",
  verbatimTextOutput("temp"),
  br(),
  "Humidity (%)",
  verbatimTextOutput("humidity"),
  br(),
  "Wind Speed (mph)",
  verbatimTextOutput("wind"),
  br(),
))
