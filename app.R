library("shiny")
library(ambientweatheR)

#UI logic goes here
ui <- fluidPage(
  titlePanel(title = "Michael Nersinger's Website",
             windowTitle = "Welcome!"
  ),
  
  hr(),
  
  tagList(tags$head(tags$style(type = 'text/css', '.navbar-brand{display:none;}')),
          navbarPage("",
                     
                     #Home Page Tab and Content         
                     tabPanel(icon("home"),
                              tagList(tags$h3(
                                #source("inputs.R", local=TRUE)$value
                              )),
                     ),
                     
                     # Page showing details of the software projects I have
                     # worked on, including team size, methodology, and
                     # technologies used, along with any artifacts produced.
                     tabPanel("Software Projects",
                              tagList(tags$h3(
                                #source("munsonMoney.R", local=TRUE)$value
                              )),
                     ),
                     # Show and nicely display weather data pulled from
                     # Phoenix Station
                     tabPanel("Victor, NY Weather",
                              tagList(tags$h3(
                                source("weather.R", local=TRUE)$value
                              )),
                     ),
                     # Digital Resume
                     tabPanel("Digital Resume",
                              tagList(tags$h3(
                                source("resume.R", local=TRUE)$value
                              ))
                     ),
                     # Contact information
                     tabPanel("Contact",
                              tagList(tags$h3(
                                #source("compTestUI.R", local=TRUE)$value
                              ))
                     ),
          )
  ),
  hr(),
  "Website developed by Michael Nersinger",
  br(),
  "Github: https://github.com/mnn7135/personal-web",
  hr()
  )

#Application Logic goes here
server <- function(input, output) {
  Sys.setenv(AW_API_KEY = "9258f994d53042ca9bcbe7f5cc44dfbbfa366e4ca4ac43c19a33268a6e060cb6")
  Sys.setenv(AW_APPLICATION_KEY = "78a34a92bffc4cc8962e87525a8a35f843e1d5dda7a94c3f88114283d16389ed")
  Sys.setenv(GITHUB_PAT = "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")
  pws_data = fetch_device_data("E8:DB:84:E4:03:97")$content
  output$raw <- renderTable(pws_data)
  date_time <- pws_data[[1]][288] #covered
  pressure <- pws_data[[5]][288] * 33.8639 #covered
  outtemp <- pws_data[[6]][288] #covered
  humidity <- pws_data[[7]][288] #covered
  winddir_10avg <- pws_data[[9]][288] #covered
  windspeed_10avg <- pws_data[[11]][288] #covered
  windgust <- pws_data[[12]][288] #covered
  hourlyrain <- pws_data[[14]][288]
  dailyrain <- pws_data[[16]][288]
  weeklyrain <- pws_data[[17]][288]
  solarrad <- pws_data[[20]][288]
  uv_index <- pws_data[[21]][288]
  feelsLike <- pws_data[[22]][288] #covered
  dewPoint <- pws_data[[23]][288] #covered
  
  wind_direction <- "XXX"
  
  if(348.75 <= winddir_10avg && winddir_10avg <= 360 || winddir_10avg < 11.25) {
    wind_direction <- "N"
  } else if(11.25 <= winddir_10avg && winddir_10avg < 33.75) {
    wind_direction <- "NNE"
  } else if(33.75 <= winddir_10avg && winddir_10avg < 56.25) {
    wind_direction <- "NE"
  } else if(56.25 <= winddir_10avg && winddir_10avg < 78.75) {
    wind_direction <- "ENE"
  } else if(78.75 <= winddir_10avg && winddir_10avg < 101.25) {
    wind_direction <- "E"
  } else if(101.25 <= winddir_10avg && winddir_10avg < 123.75) {
    wind_direction <- "ESE"
  } else if(123.75 <= winddir_10avg && winddir_10avg < 146.25) {
    wind_direction <- "SE"
  } else if(146.25 <= winddir_10avg && winddir_10avg < 168.75) {
    wind_direction <- "SSE"
  } else if(168.75 <= winddir_10avg && winddir_10avg < 191.25) {
    wind_direction <- "S"
  } else if(191.25 <= winddir_10avg && winddir_10avg < 213.75) {
    wind_direction <- "SSW"
  } else if(213.75 <= winddir_10avg && winddir_10avg < 236.25) {
    wind_direction <- "SW"
  } else if(236.25 <= winddir_10avg && winddir_10avg < 258.75) {
    wind_direction <- "WSW"
  } else if(258.75 <= winddir_10avg && winddir_10avg < 281.25) {
    wind_direction <- "W"
  }else if(281.25 <= winddir_10avg && winddir_10avg < 303.75) {
    wind_direction <- "WNW"
  } else if(303.75 <= winddir_10avg && winddir_10avg < 326.25) {
    wind_direction <- "NW"
  } else if(326.25 <= winddir_10avg && winddir_10avg < 348.75) {
    wind_direction <- "NNW"
  }
  
  
  output$date <- renderText(sprintf("Last pull from %s", format(date_time, tz="America/New_York",usetz=TRUE)))
  output$temp <- renderText(sprintf("Temperature: %.0f\u00B0 F, feels like %.0f\u00B0 F", outtemp, feelsLike))
  output$humidity <- renderText(sprintf("Humidity: %.0f%% with a dew point at %.0f\u00B0 F", humidity, dewPoint))
  output$wind <- renderText(sprintf("Wind: %.2f mph from %s\n with gusts of %.2f mph", windspeed_10avg, wind_direction, windgust))
  output$pressure <- renderText(sprintf("Pressure: %.2f mbar", pressure))
  output$rain <- renderText(sprintf("Rain: %.2f in hourly, %.2f in daily, %.2f in weekly", hourlyrain, dailyrain, weeklyrain))
  output$solar <- renderText(sprintf("Solar: %.0f W per m\u00B2 %.0f UV Index", solarrad, uv_index))
}
# Run the application 
shinyApp(ui = ui, server = server)