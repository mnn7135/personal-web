library(shiny)

source("src/server/weather_server_helper.R", local = TRUE)
source("src/server/weather_server_data.R", local = TRUE)

server <- {
  # Predict the Weather based on the given index.
  predict_weather <- (function(predict_pos) {
    predict_diff <- ((now_index - predict_pos) / 12) * 3600
    predict_time <- current_time + predict_diff
    weather_desc <- ""
    
    weather_temp <- get_temp_trend(predict_pos)*abs(get_weather_trend(temp_pos, predict_pos)
                     * (predict_pos / 12)) + pws_data[[temp_pos]][now_index]
    
    wind_max <- get_data_max(wind_speed_pos, predict_pos)
    
    # Get Trend Data
    pressure_trend <- get_weather_trend(pressure_pos, predict_pos)
    temp_trend <- get_weather_trend(temp_pos, predict_pos)
    humidity_trend <- get_weather_trend(humidity_pos, predict_pos)
    
    # Compute Weather Trend Data
    pressure_factor <- 25
    if(pressure_trend > 0.25) {
      pressure_factor <- 35
    } else if(pressure_trend < -0.25) {
      pressure_factor <- -35
    }
    
    temp_factor <- 25
    if(temp_trend > 0.25) {
      temp_factor <- 25
    } else if(temp_trend < -0.25) {
      temp_factor <- -25
    }
    
    rain_factor <- 0
    if(daily_rain > 0) {
      rain_factor <- -25
    } else if(daily_rain > 0.25 && pressure_factor < 0) {
      rain_factor <- -50
    }
    
    humidity_factor <- 25
      if(humidity_trend > 0 && out_humidity > 75) {
        humidity_factor <- -25
        rain_factor <- rain_factor - 5
      }
    
    # Prediction Formula
    weather_formula <- (50
      + pressure_factor
      + temp_factor
      + rain_factor
      + humidity_factor
    )
    
    # Grade Formula Result
    if (weather_formula <= 25) {
      # Storm Likely
      weather_desc <- weather_storm
    } else if (weather_formula <= 35) {
      # Rain Likely
      weather_desc <- weather_rain
    } else if (weather_formula <= 50) {
      # Clouds Likely
      weather_desc <- weather_cloudy
    } else {
      # Clear or Sunny
      if (hour(morning_time) <= hour(predict_time) &&
          hour(predict_time) < hour(evening_time)) {
        weather_desc <- weather_sunny
      } else {
        weather_desc <- weather_clear
      }
    }
    
    if(wind_max > 15) {
      # Breeze Likely
      weather_desc <- weather_breezy
    } else if(wind_max > 25) {
      # Wind Likely
      weather_desc <- weather_windy
    }
    
    # Return Predicted Data
    weather_icon <- get_weather_icon(weather_desc, predict_diff)
    return(c(weather_desc, weather_icon, weather_temp))
  })
  
  # Get the current weather conditions.
  get_current_weather <- (function() {
    weather_desc <- get_weather_condition(now_index)
    weather_icon <- get_weather_icon(weather_desc, now_index)
    
    # Render current weather icons.
    output$weather_icon <- renderText(as.character(icon(weather_icon,
                                                        size_current)))
    output$weather_tooltip <-
      renderText(as.character(icon(weather_icon,
                                   size_tooltip)))
    output$weather_desc <- renderText(weather_desc)
  })
  
  # Get tonight's predicted weather.
  get_weather_tonight <- (function(predict_pos) {
    data <- predict_weather(predict_pos)
    
    output$weather_icon_later <-
      renderText(as.character(icon(data[2], size_predict)))
    output$weather_desc_later <- renderText(data[1])
    temp_out <- renderText(sprintf("Low %.0f\u00B0 F", as.double(data[3])))
    output$out_high_later <- temp_out
  })
  
  # Get tomorrow's predicted weather.
  
  get_weather_tomorrow <- (function(predict_pos) {
    data <- predict_weather(predict_pos)
    
    output$weather_icon_1_day <-
      renderText(as.character(icon(data[2], size_predict)))
    output$weather_desc_1_day <- renderText(data[1])
    temp_out <- renderText(sprintf("High %.0f\u00B0 F", as.double(data[3])))
    output$out_high_1_day <- temp_out
  })
}
