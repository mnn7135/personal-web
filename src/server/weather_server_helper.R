library(shiny)

source("src/server/weather_server_data.R", local = TRUE)

server <- {
  # Determine the current weather icons to display.
  get_weather_icon <- (function(weather_condition, predict_time) {
    use_day_icon <-
      predict_time >= morning_time && predict_time < evening_time
    display_icon <- ""
    
    switch(
      weather_condition,
      Rain = {
        if (use_day_icon) {
          display_icon <- icon_rain_sun
        } else {
          display_icon <- icon_rain_moon
        }
      },
      Sunny = {
        display_icon <- icon_sunny
      },
      Clear = {
        display_icon <- icon_clear
      },
      Windy = {
        display_icon <- icon_windy
      },
      Cloudy = {
        if (use_day_icon) {
          display_icon <- icon_cloudy_sun
        } else {
          display_icon <- icon_cloudy_moon
        }
      }
    )
    return(display_icon)
  })
  
  # Determine the trend of the specified weather condition at a given time.
  get_weather_trend <- (function(data_pos, date_index) {
    numerator <- pws_data[[data_pos]][now_index]
    - pws_data[[data_pos]][date_index]
    
    denominator <- ((now_index - date_index))
    return(numerator / denominator)
  })
  
  # Determine the current weather condition description.
  get_weather_condition <- (function(predict_pos) {
    weather_condition <- ""
    predict_time <- pws_data[[time_pos]][predict_pos]
    if (hourly_rain > 0) {
      weather_condition <- weather_rain
    } else if (wind_speed >= 20) {
      weather_condition <- weather_windy
    } else {
      if (morning_time <= predict_time && predict_time < evening_time) {
        # Display Daytime Indicators
        if (uv_index > 3) {
          weather_condition <- weather_sunny
        } else {
          weather_condition <- weather_cloudy
        }
      } else {
        # Display Nighttime Indicators
        if (get_weather_trend(pressure_pos, predict_pos)
            <= -0.20) {
          weather_condition <- weather_cloudy
        } else {
          weather_condition <- weather_clear
        }
      }
    }
    return(weather_condition)
  })
  
  # Determine the direction of the wind from angle.
  get_wind_direction <- (function(wind_angle) {
    wind_direction <- ""
    if (wind_angle >= 348.75 &&
        wind_angle <= 360 || wind_angle < 11.25) {
      wind_direction <- "N"
    } else if (11.25 <= wind_angle && wind_angle < 33.75) {
      wind_direction <- "NNE"
    } else if (33.75 <= wind_angle && wind_angle < 56.25) {
      wind_direction <- "NE"
    } else if (56.25 <= wind_angle && wind_angle < 78.75) {
      wind_direction <- "ENE"
    } else if (78.75 <= wind_angle && wind_angle < 101.25) {
      wind_direction <- "E"
    } else if (101.25 <= wind_angle && wind_angle < 123.75) {
      wind_direction <- "ESE"
    } else if (123.75 <= wind_angle && wind_angle < 146.25) {
      wind_direction <- "SE"
    } else if (146.25 <= wind_angle && wind_angle < 168.75) {
      wind_direction <- "SSE"
    } else if (168.75 <= wind_angle && wind_angle < 191.25) {
      wind_direction <- "S"
    } else if (191.25 <= wind_angle && wind_angle < 213.75) {
      wind_direction <- "SSW"
    } else if (213.75 <= wind_angle && wind_angle < 236.25) {
      wind_direction <- "SW"
    } else if (236.25 <= wind_angle && wind_angle < 258.75) {
      wind_direction <- "WSW"
    } else if (258.75 <= wind_angle && wind_angle < 281.25) {
      wind_direction <- "W"
    } else if (281.25 <= wind_angle && wind_angle < 303.75) {
      wind_direction <- "WNW"
    } else if (303.75 <= wind_angle && wind_angle < 326.25) {
      wind_direction <- "NW"
    } else if (326.25 <= wind_angle && wind_angle < 348.75) {
      wind_direction <- "NNW"
    }
    return(wind_direction)
  })
  
  # Gets the max data point for the previous hour.
  get_data_max <- (function(data_pos) {
    data_max <- -200
    for (data_element in pws_data[[data_pos]][(now_index - 12):now_index]) {
      if (data_element > data_max) {
        data_max <- data_element
      }
    }
    return(data_max)
  })
  
  # Determine if there is any active weather alerts.
  get_active_alerts <- (function() {
    display_alert <- ""
    gust_max <- get_data_max(wind_gust_pos)
    wind_max <- get_data_max(wind_speed_pos)
    temp_max <- get_data_max(temp_pos)
    
    if (gust_max >= 46 && gust_max <= 57 ||
        wind_max >= 31 && wind_max >= 39) {
      display_alert <- "WIND ADVISORY"
    } else if (gust_max >= 58 || wind_max >= 40) {
      display_alert <- "HIGH WIND WARNING"
    } else if (temp_max < 105 && temp_max >= 100) {
      display_alert <- "HEAT ADVISORY"
    } else if (temp_max >= 105) {
      display_alert <- "EXCESSIVE HEAT WARNING"
    } else if (temp_max <= 50 &&
               wind_max >= 5 && windchill <= -25) {
      display_alert <- "WIND CHILL WARNING"
    } else if (temp_max <= 50 &&
               wind_max >= 5 && windchill <= -15 &&
               windchill > -25) {
      display_alert <- "WIND CHILL ADVISORY"
    } else if (hourly_rain >= 1 && gust_max >= 58) {
      display_alert <- "SEVERE THUNDERSTORM WARNING"
    } else if (hourly_rain >= 3) {
      display_alert <- "FLASH FLOOD WARNING"
    } else {
      display_alert <- "There are no current Warnings or Advisories."
    }
    return(display_alert)
  })
  
  # Determine the risk text for the UV index.
  get_uv_risk <- (function() {
    uv_risk <- ""
    if (uv_index <= 2) {
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
    return(uv_risk)
  })
  
  # Handle building data graphs and options.
  make_graph <- (function(input_type) {
    switch(
      input_type,
      "Temperature" = plot(
        pws_data[[1]][now_index:last_day_index],
        pws_data[[6]][now_index:last_day_index],
        xlab = "Time (last 24 hours)",
        ylab = "Temperature (\u00B0 F)",
        type = "h",
        col = "#8db600",
        lwd = 3,
        xaxt = "n"
      ),
      "Dew Point" = plot(
        pws_data[[1]][now_index:last_day_index],
        pws_data[[23]][now_index:last_day_index],
        xlab = "Time (last 24 hours)",
        ylab = "Dew Point (\u00B0 F)",
        type = "h",
        col = "#8db600",
        lwd = 3,
        xaxt = "n"
      ),
      "Humidity" = plot(
        pws_data[[1]][now_index:last_day_index],
        pws_data[[7]][now_index:last_day_index],
        xlab = "Time (last 24 hours)",
        ylab = "Humidity (%)",
        type = "h",
        col = "#cc5500",
        lwd = 3,
        xaxt = "n"
      ),
      "Pressure" = plot(
        pws_data[[1]][now_index:last_day_index],
        pws_data[[5]][now_index:last_day_index] * 33.8639,
        xlab = "Time (last 24 hours)",
        ylab = "Pressure (millibars)",
        type = "h",
        col = "#cd5c5c",
        lwd = 3,
        xaxt = "n"
      ),
      "Rain" = plot(
        pws_data[[1]][now_index:last_day_index],
        pws_data[[14]][now_index:last_day_index],
        xlab = "Time (last 24 hours)",
        ylab = "Rainfall (inches)",
        type = "h",
        col = "#5f9ea0",
        lwd = 3,
        xaxt = "n"
      ),
      "Wind" = plot(
        pws_data[[1]][now_index:last_day_index],
        pws_data[[11]][now_index:last_day_index],
        xlab = "Time (last 24 hours)",
        ylab = "Wind Speed (mph)",
        type = "h",
        col = "#007fff",
        lwd = 3,
        xaxt = "n"
      ),
      "Wind Gusts" = plot(
        pws_data[[1]][now_index:last_day_index],
        pws_data[[12]][now_index:last_day_index],
        xlab = "Time (last 24 hours)",
        ylab = "Wind Gust Speed (mph)",
        type = "h",
        col = "#007fff",
        lwd = 3,
        xaxt = "n"
      ),
      "UV Index" = plot(
        pws_data[[1]][now_index:last_day_index],
        pws_data[[21]][now_index:last_day_index],
        xlab = "Time (last 24 hours)",
        ylab = "UV Index",
        type = "h",
        col = "#966fd6",
        lwd = 3,
        xaxt = "n"
      )
    )
    grid()
    axis.POSIXct(
      side = 1,
      at = cut(pws_data[[1]][now_index:last_day_index],
               "3 hours"),
      x = pws_data[[1]][now_index:last_day_index],
      format = "%I:%M %p"
    )
  })
}
