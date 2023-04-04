library(shiny)

# weatherServer.R - written by Michael N.
server <- {
  FINAL_ENTRY = 288
  START_ENTRY = 144
  
  # Pull Weather Station Data
  pws_data = fetch_device_data("E8:DB:84:E4:03:97")$content
  date_time <- pws_data[[1]][FINAL_ENTRY]
  
  if(!is.na(date_time)) {
    # Outdoor Information
    out_pressure <- pws_data[[5]][FINAL_ENTRY] * 33.8639
    out_temp <- pws_data[[6]][FINAL_ENTRY]
    out_humidity <- pws_data[[7]][FINAL_ENTRY]
    wind_dir <- pws_data[[9]][FINAL_ENTRY]
    wind_speed <- pws_data[[11]][FINAL_ENTRY]
    wind_gust <- pws_data[[12]][FINAL_ENTRY]
    hourly_rain <- pws_data[[14]][FINAL_ENTRY]
    event_rain <- pws_data[[15]][FINAL_ENTRY]
    daily_rain <- pws_data[[16]][FINAL_ENTRY]
    solar_rad <- pws_data[[20]][FINAL_ENTRY]
    uv_index <- pws_data[[21]][FINAL_ENTRY]
    out_feels <- pws_data[[22]][FINAL_ENTRY]
    out_dewpoint <- pws_data[[23]][FINAL_ENTRY]
  
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
    
    # Determine if there is any active weather alerts
    displayAlert <- ""
    windchill <- 35.74 + (0.6215 * out_temp) - (35.75 * wind_speed^0.16) + (0.4275 * out_temp * wind_speed^0.16)
    if(wind_gust >= 46 && wind_gust <= 57 && wind_speed >= 31 && wind_speed >= 39) {
      displayAlert <- "Alert: Wind Advisory."
    } else if(wind_gust >= 58 && wind_speed >= 40) {
      displayAlert <- "Alert: High Wind Warning."
    } else if(out_temp < 105 && out_temp >= 100) {
      displayAlert <- "Alert: Heat Advisory."
    } else if(out_temp >= 105) {
      displayAlert <- "Alert: Excessive Heat Warning"
    } else if(out_temp <= 50 && wind_speed >= 5 && windchill <= -25) {
      displayAlert <- "Alert: Wind Chill Warning"
    } else if(out_temp <= 50 && wind_speed >= 5 && windchill <= -15 && windchill > -25) {
      displayAlert <- "Alert: Wind Chill Advisory"
    } else if(event_rain >= 1 && wind_gust >= 58) {
      displayAlert <- "Alert: Severe Thunderstorm Warning"
    } else if(event_rain >= 3) {
      displayAlert <- "Alert: Flash Flood Warning"
    } else {
      displayAlert <- "There are no current weather alerts."
    }
    
    # Determine hourly rain
    
    rain_last_hour <- ""
    if(hourly_rain > 0) {
      rain_last_hour <- sprintf("%.2f in hourly", hourly_rain)
    }
    
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
    
    # Handle graphs
    
    g1Type <- reactive({input$graphType1})
    g2Type <- reactive({input$graphType2})
    g3Type <- reactive({input$graphType3})
    g4Type <- reactive({input$graphType4})
    
    output$graph1 <- renderText(g1Type())
    output$graph2 <- renderText(g2Type())
    output$graph3 <- renderText(g3Type())
    output$graph4 <- renderText(g4Type())
    
    graphs1 <- reactive({
      switch(input$graphType1,
             "Temperature" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[6]][START_ENTRY:FINAL_ENTRY], xlab="Time (last 12 hours)", ylab="Temperature (\u00B0 F)", type="h", col="#8db600", lwd = 3, xaxt="n"), 
             "Dew Point" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[23]][START_ENTRY:FINAL_ENTRY], xlab="Time (last 12 hours)", ylab="Temperature (\u00B0 F)", type="h", col="#8db600", lwd = 3, xaxt="n"), 
             "Humidity" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[7]][START_ENTRY:FINAL_ENTRY] , xlab="Time (last 12 hours)", ylab="Humidity (%)", type="h", col="#cc5500", lwd = 3, xaxt="n"), 
             "Pressure" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[5]][START_ENTRY:FINAL_ENTRY]*33.8639, xlab="Time (last 12 hours)", ylab="Pressure (millibars)", type="h", col="#cd5c5c", lwd = 3, xaxt="n"), 
             "Rain" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], (pws_data[[14]][START_ENTRY:FINAL_ENTRY]), xlab="Time (last 12 hours)", ylab="Rainfall (inches)", type="h", col="#5f9ea0", lwd = 3, xaxt="n"), 
             "Wind" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[11]][START_ENTRY:FINAL_ENTRY] , xlab="Time (last 12 hours)", ylab="Wind Speed (mph)", type="h", col="#007fff", lwd = 3, xaxt="n"), 
             "Wind Gusts" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[12]][START_ENTRY:FINAL_ENTRY] , xlab="Time (last 12 hours)", ylab="Wind Speed (mph)", type="h", col="#007fff", lwd = 3, xaxt="n"),
             "UV Index" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[21]][START_ENTRY:FINAL_ENTRY], xlab="Time (last 12 hours)", ylab="UV Index", type="h", col="#966fd6", lwd = 3, xaxt="n"))
             grid()
             axis.POSIXct(side=1, at=cut(pws_data[[1]][START_ENTRY:FINAL_ENTRY], "2 hours"), x=pws_data[[1]][START_ENTRY:FINAL_ENTRY], format="%I:%M %p")
      })
    
    graphs2 <- reactive({
      switch(input$graphType2,
             "Temperature" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[6]][START_ENTRY:FINAL_ENTRY], xlab="Time (last 12 hours)", ylab="Temperature (\u00B0 F)", type="h", col="#8db600", lwd = 3, xaxt="n"), 
             "Dew Point" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[23]][START_ENTRY:FINAL_ENTRY], xlab="Time (last 12 hours)", ylab="Temperature (\u00B0 F)", type="h", col="#8db600", lwd = 3, xaxt="n"), 
             "Humidity" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[7]][START_ENTRY:FINAL_ENTRY] , xlab="Time (last 12 hours)", ylab="Humidity (%)", type="h", col="#cc5500", lwd = 3, xaxt="n"), 
             "Pressure" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[5]][START_ENTRY:FINAL_ENTRY]*33.8639, xlab="Time (last 12 hours)", ylab="Pressure (millibars)", type="h", col="#cd5c5c", lwd = 3, xaxt="n"), 
             "Rain" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], (pws_data[[14]][START_ENTRY:FINAL_ENTRY]), xlab="Time (last 12 hours)", ylab="Rainfall (inches)", type="h", col="#5f9ea0", lwd = 3, xaxt="n"), 
             "Wind" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[11]][START_ENTRY:FINAL_ENTRY] , xlab="Time (last 12 hours)", ylab="Wind Speed (mph)", type="h", col="#007fff", lwd = 3, xaxt="n"), 
             "Wind Gusts" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[12]][START_ENTRY:FINAL_ENTRY] , xlab="Time (last 12 hours)", ylab="Wind Speed (mph)", type="h", col="#007fff", lwd = 3, xaxt="n"),
             "UV Index" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[21]][START_ENTRY:FINAL_ENTRY], xlab="Time (last 12 hours)", ylab="UV Index", type="h", col="#966fd6", lwd = 3, xaxt="n"))
      grid()
      axis.POSIXct(side=1, at=cut(pws_data[[1]][START_ENTRY:FINAL_ENTRY], "2 hours"), x=pws_data[[1]][START_ENTRY:FINAL_ENTRY], format="%I:%M %p")
    })
    
    graphs3 <- reactive({
      switch(input$graphType3,
             "Temperature" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[6]][START_ENTRY:FINAL_ENTRY], xlab="Time (last 12 hours)", ylab="Temperature (\u00B0 F)", type="h", col="#8db600", lwd = 3, xaxt="n"), 
             "Dew Point" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[23]][START_ENTRY:FINAL_ENTRY], xlab="Time (last 12 hours)", ylab="Temperature (\u00B0 F)", type="h", col="#8db600", lwd = 3, xaxt="n"), 
             "Humidity" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[7]][START_ENTRY:FINAL_ENTRY] , xlab="Time (last 12 hours)", ylab="Humidity (%)", type="h", col="#cc5500", lwd = 3, xaxt="n"), 
             "Pressure" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[5]][START_ENTRY:FINAL_ENTRY]*33.8639, xlab="Time (last 12 hours)", ylab="Pressure (millibars)", type="h", col="#cd5c5c", lwd = 3, xaxt="n"), 
             "Rain" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], (pws_data[[14]][START_ENTRY:FINAL_ENTRY]), xlab="Time (last 12 hours)", ylab="Rainfall (inches)", type="h", col="#5f9ea0", lwd = 3, xaxt="n"), 
             "Wind" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[11]][START_ENTRY:FINAL_ENTRY] , xlab="Time (last 12 hours)", ylab="Wind Speed (mph)", type="h", col="#007fff", lwd = 3, xaxt="n"), 
             "Wind Gusts" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[12]][START_ENTRY:FINAL_ENTRY] , xlab="Time (last 12 hours)", ylab="Wind Speed (mph)", type="h", col="#007fff", lwd = 3, xaxt="n"),
             "UV Index" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[21]][START_ENTRY:FINAL_ENTRY], xlab="Time (last 12 hours)", ylab="UV Index", type="h", col="#966fd6", lwd = 3, xaxt="n"))
      grid()
      axis.POSIXct(side=1, at=cut(pws_data[[1]][START_ENTRY:FINAL_ENTRY], "2 hours"), x=pws_data[[1]][START_ENTRY:FINAL_ENTRY], format="%I:%M %p")
    })
    
    graphs4 <- reactive({
      switch(input$graphType4,
             "Temperature" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[6]][START_ENTRY:FINAL_ENTRY], xlab="Time (last 12 hours)", ylab="Temperature (\u00B0 F)", type="h", col="#8db600", lwd = 3, xaxt="n"), 
             "Dew Point" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[23]][START_ENTRY:FINAL_ENTRY], xlab="Time (last 12 hours)", ylab="Temperature (\u00B0 F)", type="h", col="#8db600", lwd = 3, xaxt="n"), 
             "Humidity" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[7]][START_ENTRY:FINAL_ENTRY] , xlab="Time (last 12 hours)", ylab="Humidity (%)", type="h", col="#cc5500", lwd = 3, xaxt="n"), 
             "Pressure" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[5]][START_ENTRY:FINAL_ENTRY]*33.8639, xlab="Time (last 12 hours)", ylab="Pressure (millibars)", type="h", col="#cd5c5c", lwd = 3, xaxt="n"), 
             "Rain" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], (pws_data[[14]][START_ENTRY:FINAL_ENTRY]), xlab="Time (last 12 hours)", ylab="Rainfall (inches)", type="h", col="#5f9ea0", lwd = 3, xaxt="n"), 
             "Wind" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[11]][START_ENTRY:FINAL_ENTRY] , xlab="Time (last 12 hours)", ylab="Wind Speed (mph)", type="h", col="#007fff", lwd = 3, xaxt="n"), 
             "Wind Gusts" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[12]][START_ENTRY:FINAL_ENTRY] , xlab="Time (last 12 hours)", ylab="Wind Speed (mph)", type="h", col="#007fff", lwd = 3, xaxt="n"),
             "UV Index" = plot(pws_data[[1]][START_ENTRY:FINAL_ENTRY], pws_data[[21]][START_ENTRY:FINAL_ENTRY], xlab="Time (last 12 hours)", ylab="UV Index", type="h", col="#966fd6", lwd = 3, xaxt="n"))
      grid()
      axis.POSIXct(side=1, at=cut(pws_data[[1]][START_ENTRY:FINAL_ENTRY], "2 hours"), x=pws_data[[1]][START_ENTRY:FINAL_ENTRY], format="%I:%M %p")
    })
    
    # Render data
    output$weatherTab <- renderText(sprintf("Victor, NY %.0f\u00B0 F", out_temp))
    output$dataGraph1 <- renderPlot(graphs1())
    output$dataGraph2 <- renderPlot(graphs2())
    output$dataGraph3 <- renderPlot(graphs3())
    output$dataGraph4 <- renderPlot(graphs4())
    output$outDewPoint <- renderText(sprintf("%.0f\u00B0 F", out_dewpoint))
    output$alert <- renderText(displayAlert)
    output$date <- renderText(sprintf("Last pull from %s", format(date_time, tz="America/New_York",usetz=TRUE, format="%D %I:%M %p")))
    output$outTemp <- renderText(sprintf("%.0f\u00B0 F", out_temp))
    output$outFeels <- renderText(sprintf("Feels Like %.0f\u00B0 F", out_feels))
    output$outHumidity <- renderText(sprintf("%.0f%%", out_humidity))
    output$windSpeed <- renderText(sprintf("%.0f mph from %s", wind_speed, wind_direction))
    output$windGust <- renderText(sprintf("%.0f mph from %s", wind_gust, wind_direction))
    output$outPressure <- renderText(sprintf("%.2f mbar", out_pressure))
    output$solarData <- renderText(sprintf("%.0f %s", uv_index, uv_risk))
    output$dailyRain <- renderText(sprintf("%.2f in", daily_rain))
    output$rainLastHour <- renderText(rain_last_hour)
    
    # The Mean Standard Sea Level Pressure for Victor, NY is 1021 mbar
    time1 <- as.POSIXlt(pws_data[[1]][FINAL_ENTRY], format="%H:%M")
    time2 <- as.POSIXlt("08:00:00", format="%H:%M")
    time3 <- as.POSIXlt("20:00:00", format="%H:%M")
    
    icon_name <- ""
    icon_desc <- ""
    if(event_rain > 0.1) {
      icon_name <- "cloud-rain"
      icon_desc <- "Raining"
    } else {
      if(time2 <= time1 && time1 < time3) {
        # Display Daytime Indicators
        if((pws_data[[5]][FINAL_ENTRY] - pws_data[[5]][FINAL_ENTRY - 24]) <= -0.35) {
          icon_name <- "cloud-sun"
          icon_desc <- "Cloudy"
        } else {
          icon_name <- "sun"
          icon_desc <- "Sunny"
        }
      } else {
        # Display Nighttime Indicators
        if((pws_data[[5]][FINAL_ENTRY] - pws_data[[5]][FINAL_ENTRY - 24]) <= -0.35) {
          icon_name <- "cloud-moon"
          icon_desc <- "Cloudy"
        } else {
          icon_name <- "moon"
          icon_desc <- "Clear"
        }
      }
    }
    output$weatherIcon <- renderText(as.character(icon(icon_name, "fa-10x")))
    output$weatherDesc <- renderText(icon_desc)
    
    #output$testTable <- renderTable(pws_data)
    
    # Windchill should only be displayed when it has a noticeable value
    
    if(windchill <= -5) {
      output$windchillValue <- renderText(sprintf("%.0f\u00B0 F", windchill))
      output$windchillText <- renderText("Wind Chill")
    }
  } else {
    output$weatherTab <- renderText("??\u00B0 F Victor, NY")
    output$alert <- renderText("Unable to retrieve weather data. Try refreshing the page.")
  }
}