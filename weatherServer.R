library(shiny)

#Application Logic goes here
server <- {
  pws_data = fetch_device_data("E8:DB:84:E4:03:97")$content
  date_time <- pws_data[[1]][288]
  pressure <- pws_data[[5]][288] * 33.8639
  outtemp <- pws_data[[6]][288]
  humidity <- pws_data[[7]][288]
  winddir_10avg <- pws_data[[9]][288]
  windspeed_10avg <- pws_data[[11]][288]
  windgust <- pws_data[[12]][288]
  hourlyrain <- pws_data[[14]][288]
  dailyrain <- pws_data[[16]][288]
  weeklyrain <- pws_data[[17]][288]
  solarrad <- pws_data[[20]][288]
  uv_index <- pws_data[[21]][288]
  feelsLike <- pws_data[[22]][288]
  dewPoint <- pws_data[[23]][288]
  
  wind_direction <- ""
  
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
  
  displayText <- ""
  
  if(pressure >= 1050 && uv_index >= 2 && uv_index <= 6 && outtemp >= 80) {
    displayText <- "It's a great day for tanning! Be sure to put on sunscreen!"
  } else if(pressure >= 1050 && outtemp >= 55) {
    displayText <- "It's going to be a great night for stargazing! Get the telescope out!"
  }
  
  displayAlert <- ""
  
  windchill <- 35.74 + (0.6215 * outtemp) - (35.75 * windspeed_10avg^0.16) + (0.4275 * outtemp * windspeed_10avg^0.16)
  
  if(windgust >= 46 && windgust <= 57 && windspeed_10avg >= 31 && windspeed_10avg >= 39) {
    displayAlert <- "Alert: Wind Advisory."
  } else if(windgust >= 58 && windspeed_10avg >= 40) {
    displayAlert <- "Alert: High Wind Warning."
  } else if(outtemp < 105 && outtemp >= 100) {
    displayAlert <- "Alert: Heat Advisory."
  } else if(outtemp >= 105) {
    displayAlert <- "Alert: Excessive Heat Warning"
  } else if(outtemp <= 50 && windspeed_10avg >= 5 && windchill >= 25) {
    displayAlert <- "Alert: Wind Chill Warning"
  } else if(outtemp <= 50 && windspeed_10avg >= 5 && windchill >= 15 && windchill < 25) {
    displayAlert <- "Alert: Wind Chill Advisory"
  } else {
    displayAlert <- "Alert: There are no current weather alerts."
  }
  
  output$additionalWeather <- renderText(displayText)
  output$alert <- renderText(displayAlert)
  output$date <- renderText(sprintf("Last pull from %s", format(date_time, tz="America/New_York",usetz=TRUE)))
  output$temp <- renderText(sprintf("Temperature: %.0f\u00B0 F, feels like %.0f\u00B0 F", outtemp, feelsLike))
  output$humidity <- renderText(sprintf("Humidity: %.0f%% with a dew point at %.0f\u00B0 F", humidity, dewPoint))
  output$wind <- renderText(sprintf("Wind: %.2f mph from %s\n with gusts of %.2f mph", windspeed_10avg, wind_direction, windgust))
  output$pressure <- renderText(sprintf("Pressure: %.2f millibars", pressure))
  output$rain <- renderText(sprintf("Rain: %.2f in hourly, %.2f in daily, %.2f in weekly", hourlyrain, dailyrain, weeklyrain))
  output$solar <- renderText(sprintf("Solar: %.0f W/m\u00B2, %.0f UV Index", solarrad, uv_index))
  output$tempGraph <- renderPlot(plot(pws_data[[1]], pws_data[[6]], xlab="Time (last 24 hours)", ylab="Temperature (\u00B0 F)", type="h", col=139, lwd = 6))
  output$pressureGraph <- renderPlot(plot(pws_data[[1]], pws_data[[5]][1:288]*33.8639, xlab="Time (last 24 hours)", ylab="Pressure (millibars)", type="h", col=490, lwd = 6))
}