library(shiny)

# written by Michael N
#
# This file handles data associated with the back end of the weather.R page.
# It pulls data from the weather station using the AmbientWeather API, and
# displays current weather information. It also looks at general trends in
# the data over the previous 24 hours to make predictions about weather in the
# future.

server <- {
  NOW_INDEX = 288
  TONIGHT_INDEX = 252
  TOMORROW_INDEX = 1
  
  pws_data = fetch_device_data("E8:DB:84:E4:03:97")$content
  date_time <- pws_data[[1]][NOW_INDEX]
  
  # Ensure that there is data available from the station.
  if(!is.na(date_time)) {
    
    # Outdoor Information
    out_pressure <- pws_data[[5]][NOW_INDEX] * 33.8639 # inHg to mbar
    out_temp <- pws_data[[6]][NOW_INDEX]
    out_humidity <- pws_data[[7]][NOW_INDEX]
    wind_dir <- pws_data[[9]][NOW_INDEX]
    wind_speed <- pws_data[[11]][NOW_INDEX]
    wind_gust <- pws_data[[12]][NOW_INDEX]
    hourly_rain <- pws_data[[14]][NOW_INDEX]
    event_rain <- pws_data[[15]][NOW_INDEX]
    daily_rain <- pws_data[[16]][NOW_INDEX]
    solar_rad <- pws_data[[20]][NOW_INDEX]
    uv_index <- pws_data[[21]][NOW_INDEX]
    out_feels <- pws_data[[22]][NOW_INDEX]
    out_dewpoint <- pws_data[[23]][NOW_INDEX]
    
    output$weatherTab <- renderText(sprintf("Victor, NY %.0f\u00B0 F", out_temp))
    output$outDewPoint <- renderText(sprintf("%.0f\u00B0 F", out_dewpoint))
    output$date <- renderText(sprintf("Last pull from %s", format(date_time, tz="America/New_York",usetz=TRUE, format="%D %I:%M %p")))
    output$outTemp <- renderText(sprintf("%.0f\u00B0 F", out_temp))
    output$outFeels <- renderText(sprintf("Feels Like %.0f\u00B0 F", out_feels))
    output$outHumidity <- renderText(sprintf("%.0f%%", out_humidity))
    output$outPressure <- renderText(sprintf("%.2f mbar", out_pressure))
    output$dailyRain <- renderText(sprintf("%.2f in", daily_rain))
  
    # Determine Wind Direction
    wind_direction <- ""
    if(wind_dir >= 348.75 && wind_dir <= 360 || wind_dir < 11.25) {
      wind_direction <- "N"
    } else if(11.25 <= wind_dir && wind_dir < 33.75) {
      wind_direction <- "NNE"
    } else if(33.75 <= wind_dir && wind_dir < 56.25) {
      wind_direction <- "NE"
    } else if(56.25 <= wind_dir && wind_dir < 78.75) {
      wind_direction <- "ENE"
    } else if(78.75 <= wind_dir && wind_dir < 101.25) {
      wind_direction <- "E"
    } else if(101.25 <= wind_dir && wind_dir < 123.75) {
      wind_direction <- "ESE"
    } else if(123.75 <= wind_dir && wind_dir < 146.25) {
      wind_direction <- "SE"
    } else if(146.25 <= wind_dir && wind_dir < 168.75) {
      wind_direction <- "SSE"
    } else if(168.75 <= wind_dir && wind_dir < 191.25) {
      wind_direction <- "S"
    } else if(191.25 <= wind_dir && wind_dir < 213.75) {
      wind_direction <- "SSW"
    } else if(213.75 <= wind_dir && wind_dir < 236.25) {
      wind_direction <- "SW"
    } else if(236.25 <= wind_dir && wind_dir < 258.75) {
      wind_direction <- "WSW"
    } else if(258.75 <= wind_dir && wind_dir < 281.25) {
      wind_direction <- "W"
    }else if(281.25 <= wind_dir && wind_dir < 303.75) {
      wind_direction <- "WNW"
    } else if(303.75 <= wind_dir && wind_dir < 326.25) {
      wind_direction <- "NW"
    } else if(326.25 <= wind_dir && wind_dir < 348.75) {
      wind_direction <- "NNW"
    }
    
    output$windSpeed <- renderText(sprintf("%.0f mph from %s", wind_speed, wind_direction))
    output$windGust <- renderText(sprintf("%.0f mph from %s", wind_gust, wind_direction))
    
    # Determine if there is any active weather alerts.
    displayAlert <- ""
    windchill <- 35.74 + (0.6215 * out_temp) - (35.75 * wind_speed^0.16) + (0.4275 * out_temp * wind_speed^0.16)
    if(wind_gust >= 46 && wind_gust <= 57 || wind_speed >= 31 && wind_speed >= 39) {
      displayAlert <- "WIND ADVISORY"
    } else if(wind_gust >= 58 || wind_speed >= 40) {
      displayAlert <- "HIGH WIND WARNING"
    } else if(out_temp < 105 && out_temp >= 100) {
      displayAlert <- "HEAT ADVISORY"
    } else if(out_temp >= 105) {
      displayAlert <- "EXCESSIVE HEAT WARNING"
    } else if(out_temp <= 50 && wind_speed >= 5 && windchill <= -25) {
      displayAlert <- "WIND CHILL WARNING"
    } else if(out_temp <= 50 && wind_speed >= 5 && windchill <= -15 && windchill > -25) {
      displayAlert <- "WIND CHILL ADVISORY"
    } else if(hourly_rain >= 1 && wind_gust >= 58) {
      displayAlert <- "SEVERE THUNDERSTORM WARNING"
    } else if(hourly_rain >= 3) {
      displayAlert <- "FLASH FLOOD WARNING"
    } else {
      displayAlert <- "There are no Warnings or Advisories."
    }
    output$alert <- renderText(displayAlert)
    
    # Determine hourly rain
    rain_last_hour <- ""
    if(hourly_rain >= 0.1) {
      rain_last_hour <- sprintf("%.2f in hourly", hourly_rain)
    }
    output$rainLastHour <- renderText(rain_last_hour)
    
    # Determine UV Risk
    uv_risk <- ""
    if(uv_index <= 2) {
      uv_risk <- "(Low Risk)"
    } else if (uv_index <= 5) {
      uv_risk <- "(Moderate Risk)"
    } else if (uv_index <= 7) {
      uv_risk <- "(High Risk)"
    } else if (uv_index <= 10) {
      uv_risk <- "(Very High Risk)"
    } else if (uv_index >= 11) {
      uv_risk <- "(Extreme Risk)"
    }
    output$solarData <- renderText(sprintf("%.0f %s", uv_index, uv_risk))
    
    # Handle data graphs
    makeGraph <- (function(inputType) {
      switch(inputType,
             "Temperature" = plot(pws_data[[1]][NOW_INDEX:TOMORROW_INDEX], pws_data[[6]][NOW_INDEX:TOMORROW_INDEX], xlab="Time (last 24 hours)", ylab="Temperature (\u00B0 F)", type="h", col="#8db600", lwd = 3, xaxt="n"), 
             "Dew Point" = plot(pws_data[[1]][NOW_INDEX:TOMORROW_INDEX], pws_data[[23]][NOW_INDEX:TOMORROW_INDEX], xlab="Time (last 24 hours)", ylab="Dew Point (\u00B0 F)", type="h", col="#8db600", lwd = 3, xaxt="n"), 
             "Humidity" = plot(pws_data[[1]][NOW_INDEX:TOMORROW_INDEX], pws_data[[7]][NOW_INDEX:TOMORROW_INDEX] , xlab="Time (last 24 hours)", ylab="Humidity (%)", type="h", col="#cc5500", lwd = 3, xaxt="n"), 
             "Pressure" = plot(pws_data[[1]][NOW_INDEX:TOMORROW_INDEX], pws_data[[5]][NOW_INDEX:TOMORROW_INDEX]*33.8639, xlab="Time (last 24 hours)", ylab="Pressure (millibars)", type="h", col="#cd5c5c", lwd = 3, xaxt="n"), 
             "Rain" = plot(pws_data[[1]][NOW_INDEX:TOMORROW_INDEX], (pws_data[[14]][NOW_INDEX:TOMORROW_INDEX]), xlab="Time (last 24 hours)", ylab="Rainfall (inches)", type="h", col="#5f9ea0", lwd = 3, xaxt="n"), 
             "Wind" = plot(pws_data[[1]][NOW_INDEX:TOMORROW_INDEX], pws_data[[11]][NOW_INDEX:TOMORROW_INDEX] , xlab="Time (last 24 hours)", ylab="Wind Speed (mph)", type="h", col="#007fff", lwd = 3, xaxt="n"), 
             "Wind Gusts" = plot(pws_data[[1]][NOW_INDEX:TOMORROW_INDEX], pws_data[[12]][NOW_INDEX:TOMORROW_INDEX] , xlab="Time (last 24 hours)", ylab="Wind Gust Speed (mph)", type="h", col="#007fff", lwd = 3, xaxt="n"),
             "UV Index" = plot(pws_data[[1]][NOW_INDEX:TOMORROW_INDEX], pws_data[[21]][NOW_INDEX:TOMORROW_INDEX], xlab="Time (last 24 hours)", ylab="UV Index", type="h", col="#966fd6", lwd = 3, xaxt="n"))
      grid()
      axis.POSIXct(side=1, at=cut(pws_data[[1]][NOW_INDEX:TOMORROW_INDEX], "4 hours"), x=pws_data[[1]][NOW_INDEX:TOMORROW_INDEX], format="%I:%M %p")
    })
    
    graph1 <- reactive({makeGraph(input$graphType1)})
    graph2 <- reactive({makeGraph(input$graphType2)})
    graph3 <- reactive({makeGraph(input$graphType3)})
    graph4 <- reactive({makeGraph(input$graphType4)})
    
    # Render labels and graphs
    output$graph1 <- renderText(reactive({input$graphType1}))
    output$graph2 <- renderText(reactive({input$graphType2}))
    output$graph3 <- renderText(reactive({input$graphType3}))
    output$graph4 <- renderText(reactive({input$graphType4}))
    
    output$dataGraph1 <- renderPlot(graph1())
    output$dataGraph2 <- renderPlot(graph2())
    output$dataGraph3 <- renderPlot(graph3())
    output$dataGraph4 <- renderPlot(graph4())
    
    # Determine current weather condition
    currentTime <- as.POSIXlt(pws_data[[1]][NOW_INDEX], format="%H:%M")
    morningTime <- as.POSIXlt("07:00:00", format="%H:%M") # 7 AM
    eveningTime <- as.POSIXlt("19:00:00", format="%H:%M") # 7 PM
    
    icon_name <- ""
    icon_desc <- ""
    if(hourly_rain > 0) {
      icon_name <- "cloud-rain"
      icon_desc <- "Rain"
    } else if(wind_speed >= 20) {
      icon_name <- "wind"
      icon_desc <- "Windy"
    } else {
      if(morningTime <= currentTime && currentTime < eveningTime) {
        # Display Daytime Indicators
        if(uv_index > 3) {
          icon_name <- "sun"
          icon_desc <- "Sunny"
        } else {
          icon_name <- "cloud-sun"
          icon_desc <- "Cloudy"
        }
      } else {
        # Display Nighttime Indicators
        if((pws_data[[5]][NOW_INDEX] - pws_data[[5]][TOMORROW_INDEX]) <= -0.20) {
          icon_name <- "cloud-moon"
          icon_desc <- "Cloudy"
        } else {
          icon_name <- "moon"
          icon_desc <- "Clear"
        }
      }
    }
    output$weatherIcon <- renderText(as.character(icon(icon_name, "fa-10x")))
    output$weatherTooltip <- renderText(as.character(icon(icon_name)))
    output$weatherDesc <- renderText(icon_desc)
    
    # Weather Prediction
    predictWeather <- (function(index, confidence) {
      hourCount <- index/12
      iconTemp <- ""
      descTemp <- ""
      if((pws_data[[11]][NOW_INDEX] - pws_data[[11]][index])/hourCount + pws_data[[11]][NOW_INDEX] >= 20/confidence) {
        iconTemp <- "wind"
        descTemp <- "Windy"
      } else if((pws_data[[5]][NOW_INDEX] - pws_data[[5]][index])/hourCount >= 0.20/confidence) {
        if(index == TONIGHT_INDEX) {
          iconTemp <- renderText(as.character(icon("cloud-moon", "fa-4x")))
        } else {
          iconTemp <- renderText(as.character(icon("cloud-sun", "fa-4x")))
        }
        descTemp <- renderText("Cloudy")
      } else if((pws_data[[5]][NOW_INDEX] - pws_data[[5]][index])/hourCount <= -0.20/confidence) {
        if((pws_data[[7]][NOW_INDEX] - pws_data[[7]][index])/hourCount >= 20 || pws_data[[7]][NOW_INDEX] >= 85) {
          iconTemp <- renderText(as.character(icon("cloud-rain", "fa-4x")))
          descTemp <- renderText("Rain")
        } else {
          if(index == TONIGHT_INDEX) {
            iconTemp <- renderText(as.character(icon("cloud-moon", "fa-4x")))
          } else {
            iconTemp <- renderText(as.character(icon("cloud-sun", "fa-4x")))
          }
          descTemp <- renderText("Cloudy")
        }
      } else {
        if(index != TONIGHT_INDEX && icon_name == "moon") {
          iconTemp <- renderText(as.character(icon("sun", "fa-4x")))
          descTemp <- renderText("Sunny")
        } else if(index != TONIGHT_INDEX && icon_name == "cloud-moon") {
          iconTemp <- renderText(as.character(icon("cloud-sun", "fa-4x")))
          descTemp <- renderText(icon_desc)
        } else {
          iconTemp <- renderText(as.character(icon(icon_name, "fa-4x")))
          descTemp <- renderText(icon_desc)
        }
      }
      
      if(index == TONIGHT_INDEX) {
          output$weatherIconLater <- iconTemp 
          output$weatherDescLater <- descTemp
          tempOut <- renderText(sprintf("Low %.0f\u00B0 F", (pws_data[[6]][NOW_INDEX] - pws_data[[6]][index])/confidence + pws_data[[6]][NOW_INDEX]))
          output$outHighLater <- tempOut
      } else if(index == TOMORROW_INDEX) {
          output$weatherIcon1Day <- iconTemp 
          output$weatherDesc1Day <- descTemp 
          tempOut <- renderText(sprintf("High %.0f\u00B0 F", (pws_data[[6]][NOW_INDEX] - pws_data[[6]][index])/confidence + pws_data[[6]][NOW_INDEX]))
          output$outHigh1Day <- tempOut
      }
    })
    
    predictWeather(TONIGHT_INDEX, 1.00)
    predictWeather(TOMORROW_INDEX, 0.95)
    
    # Windchill should only be displayed when it has a noticeable value
    if(windchill <= -5) {
      output$windchillValue <- renderText(sprintf("%.0f\u00B0 F", windchill))
      output$windchillText <- renderText("Wind Chill")
    }
    
  } 
  # Handle if there is no data to pull
  else {
    output$weatherTab <- renderText("??\u00B0 F Victor, NY")
    output$alert <- renderText("Unable to retrieve weather data. Try refreshing the page.")
  }
}