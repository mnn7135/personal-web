library(shiny)

source("src/server/weather_server_helper.R", local = TRUE)
source("src/server/weather_server_data.R", local = TRUE)

server <- {
  icon_name <- ""
  icon_desc <- ""
  # Get the current weather conditions.
  get_current_weather <- (function() {
    if (hourly_rain > 0) {
      icon_name <- icon_rain
      icon_desc <- weather_rain
    } else if (wind_speed >= 20) {
      icon_name <- icon_windy
      icon_desc <- weather_windy
    } else {
      if (morning_time <= current_time && current_time < evening_time) {
        # Display Daytime Indicators
        if (uv_index > 3) {
          icon_name <- icon_sunny
          icon_desc <- weather_sunny
        } else {
          icon_name <- icon_cloudy_sun
          icon_desc <- weather_cloudy
        }
      } else {
        # Display Nighttime Indicators
        if ((pws_data[[5]][now_index]
             - pws_data[[5]][tomorrow_index]) <= -0.20) {
          icon_name <- icon_cloudy_moon
          icon_desc <- weather_cloudy
        } else {
          icon_name <- icon_clear
          icon_desc <- weather_clear
        }
      }
    }
    # Render current weather icons.
    output$weather_icon <- renderText(as.character(icon(icon_name,
                                                        size_current)))
    output$weather_tooltip <-
      renderText(as.character(icon(icon_name,
                                   size_tooltip)))
    output$weather_desc <- renderText(icon_desc)
    
    return(c(icon_name, icon_desc))
  })
  # Current weather icon displayed.
  icon_data <- get_current_weather()
  icon_name <- icon_data[1]
  icon_desc <- icon_data[2]
  # Predict the weather based on a specific index to compare to as well as
  # a confidence interval.
  predict_weather_tonight <- (function(index, confidence) {
    icon_temp <- ""
    desc_temp <- ""
    hour_count <- index / 12
    if ((pws_data[[11]][now_index]
         - pws_data[[11]][index]) / hour_count
        + pws_data[[11]][now_index] >= 20 / confidence) {
      icon_temp <- icon_windy
      desc_temp <- weather_windy
    } else if ((pws_data[[5]][now_index]
                - pws_data[[5]][index]) / hour_count
               >= prediction_factor_tonight / confidence) {
      icon_temp <- icon_cloudy_moon
      desc_temp <- weather_cloudy
    } else if ((pws_data[[5]][now_index]
                - pws_data[[5]][index]) / hour_count
               <= -prediction_factor_tonight / confidence) {
      if ((pws_data[[7]][now_index]
           - pws_data[[7]][index]) / hour_count >= 20
          || pws_data[[7]][now_index] >= 85) {
        icon_temp <- icon_rain
        desc_temp <- weather_rain
      } else {
        icon_temp <- icon_cloudy_moon
        desc_temp <- weather_cloudy
      }
    } else {
      if (icon_name == "cloud-moon") {
        icon_temp <- icon_cloudy_sun
        desc_temp <- weather_cloudy
      } else if (icon_name == "moon") {
        icon_temp <- icon_sunny
        desc_temp <- weather_sunny
      } else {
        icon_temp <- icon_name
        desc_temp <- icon_desc
      }
    }
    temp_trend <- 0.66
    if (morning_time <= current_time && current_time < noon_time) {
      # Likely to warm up a lot in the next 6 hours.
      temp_trend <- -0.66
    } else {
      # Likely to cool down a lot in the next 6 hours.
      temp_trend <- 0.66
    }
    output$weather_icon_later <-
      renderText(as.character(icon(icon_temp, size_predict)))
    output$weather_desc_later <- renderText(desc_temp)
    temp_out <- renderText(
      sprintf(
        "Low %.0f\u00B0 F", (pws_data[[6]][now_index] - pws_data[[6]][index]) 
        / prediction_factor_tonight * temp_trend + pws_data[[6]][now_index]
      )
    )
    output$out_high_later <- temp_out
  })
  predict_weather_tomorrow <- (function(index, confidence) {
    icon_temp <- ""
    desc_temp <- ""
    hour_count <- index / 12
    if ((pws_data[[11]][now_index]
         - pws_data[[11]][index]) / hour_count
        + pws_data[[11]][now_index] >= 20 / confidence) {
      icon_temp <- icon_windy
      desc_temp <- weather_windy
    } else if ((pws_data[[5]][now_index]
                - pws_data[[5]][index]) / hour_count
               >= prediction_factor_tomorrow / confidence) {
      icon_temp <- icon_cloudy_sun
      desc_temp <- weather_cloudy
    } else if ((pws_data[[5]][now_index]
                - pws_data[[5]][index]) / hour_count
               <= -prediction_factor_tomorrow / confidence) {
      if ((pws_data[[7]][now_index]
           - pws_data[[7]][index]) / hour_count >= 20
          || pws_data[[7]][now_index] >= 85) {
        icon_temp <- icon_rain
        desc_temp <- weather_rain
      } else {
        icon_temp <- icon_cloudy_sun
        desc_temp <- weather_cloudy
      }
    } else {
      if (icon_name == "cloud-moon") {
        icon_temp <- icon_cloudy_sun
        desc_temp <- weather_cloudy
      } else if (icon_name == "moon") {
        icon_temp <- icon_sunny
        desc_temp <- weather_sunny
      } else {
        icon_temp <- icon_name
        desc_temp <- icon_desc
      }
    }
    temp_trend <- 0.66
    if (morning_time <= current_time && current_time < noon_time) {
      # Likely to warm up a lot in the next 6 hours.
      temp_trend <- 0.66
    } else {
      # Likely to cool down a lot in the next 6 hours.
      temp_trend <- -0.66
    }
    output$weather_icon_1_day <-
      renderText(as.character(icon(icon_temp, size_predict)))
    output$weather_desc_1_day <- renderText(desc_temp)
    temp_out <- renderText(
      sprintf(
        "High %.0f\u00B0 F", (pws_data[[6]][now_index] - pws_data[[6]][index])
        / prediction_factor_tomorrow * temp_trend + pws_data[[6]][now_index]
      )
    )
    output$out_high_1_day <- temp_out
  })
}
