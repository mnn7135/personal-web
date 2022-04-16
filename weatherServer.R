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
  eventrain <- pws_data[[15]][288]
  dailyrain <- pws_data[[16]][288]
  solarrad <- pws_data[[20]][288]
  uv_index <- pws_data[[21]][288]
  feelsLike <- pws_data[[22]][288]
  dewPoint <- pws_data[[23]][288]
  
  pressureTrend <- (pws_data[[5]][264] * 33.8639) - pressure
  
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
  } else if(pressure >= 1030 && outtemp >= 55 && pressureTrend > 0) {
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
  } else if(eventrain >= 1 && windgust >= 58) {
    displayAlert <- "Alert: Severe Thunderstorm Warning"
  } else if(eventrain >= 3) {
    displayAlert <- "Alert: Flash Flood Warning"
  } else {
    displayAlert <- "There are no current weather alerts."
  }
  
  currentWeather <- ""
  image_loc <- ""
  rain_last_hour <-
  if(hourlyrain > 0) {
    rain_last_hour <- sprintf("Rainfall in the Last Hour: %.2f in", hourlyrain)
  }
    
  
  if(eventrain > 0) {
    currentWeather <- "Light Rain"
    image_loc <- "drizzle.png"
  } else if(eventrain > 0.5) {
    currentWeather <- "Rain"
    image_loc <- "rain.png"
  } else if(pressureTrend > 10) {
    currentWeather <- "Clear"
    if(solarrad > 10) {
      image_loc <- "sunny.png"
    } else {
      image_loc <- "moony.png"
    }
  } else if(windspeed_10avg >= 10.0) {
    currentWeather <- "Windy"
    image_loc <- "windy.png"
  } else if(pressureTrend >= -10 && pressureTrend <= 10) {
    currentWeather <- "Passing Clouds"
    if(solarrad > 10) {
      image_loc <- "somesun.png"
    } else {
      image_loc <- "somemoon.png"
    }
  } else if(pressureTrend < -10) {
    currentWeather <- "Cloudy"
    image_loc <- "cloudy.png"
  }
  
  output$weatherImage <- renderImage({
    filename <- normalizePath(file.path('./www', paste(image_loc, sep='')))
    list(src = filename)}, deleteFile = FALSE)
  output$currentWeather <- renderText(currentWeather)
  #output$raw <- renderTable(pws_data)
  output$additionalWeather <- renderText(displayText)
  output$dPoint <- renderText(sprintf("%.0f\u00B0 F", dewPoint))
  output$alert <- renderText(displayAlert)
  output$date <- renderText(sprintf("Last pull from %s", format(date_time, tz="America/New_York",usetz=TRUE)))
  output$temp <- renderText(sprintf("%.0f\u00B0 F", outtemp))
  output$tempFeels <- renderText(sprintf("Feels like %.0f\u00B0 F", feelsLike))
  output$humidity <- renderText(sprintf("%.0f%%", humidity))
  output$wind <- renderText(sprintf("%.0f mph from %s", windspeed_10avg, wind_direction))
  output$gust <- renderText(sprintf("%.0f mph from %s", windgust, wind_direction))
  
  output$pressure <- renderText(sprintf("%.2f mbar", pressure))
  output$solar <- renderText(sprintf("%.0f", uv_index))
  output$dailyRain <- renderText(sprintf("%.2f in", dailyrain))
  output$rainLastHour <- renderText(rain_last_hour)
  output$tempGraph <- renderPlot(plot(pws_data[[1]], pws_data[[6]], xlab="Time (last 24 hours)", ylab="Temperature (\u00B0 F)", type="h", col="#4E9A39", lwd = 8))
  output$pressureGraph <- renderPlot(plot(pws_data[[1]], pws_data[[5]][1:288]*33.8639, xlab="Time (last 24 hours)", ylab="Pressure (millibars)", type="h", col="#F39E43", lwd = 8))
  output$rainGraph <- renderPlot(plot(pws_data[[1]], (pws_data[[14]][1:288]), xlab="Time (last 24 hours)", ylab="Rainfall (inches)", type="h", col="#1A67CB", lwd = 8))
  output$windGraph <- renderPlot(plot(pws_data[[1]], pws_data[[11]][1:288] , xlab="Time (last 24 hours)", ylab="Wind Speed (mph)", type="h", col="#90D1FC", lwd = 8))
}