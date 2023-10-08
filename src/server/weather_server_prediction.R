library(shiny)

source("src/server/weather_server_helper.R", local = TRUE)
source("src/server/weather_server_data.R", local = TRUE)

server <- {
  # Predict the Weather based on the given index.
  predict_weather <- (function(predict_pos) {
    confidence <- 0.95 + 0.05 * (predict_pos / now_index)
    predict_time <- current_time_unformatted + as.difftime((predict_pos / 12), units = "hours")
    weather_desc <- ""

    # Gather Weather Trend Data
    weather_temp <- (get_weather_trend(temp_pos, predict_pos)
    * (predict_pos / 12)) + pws_data[[temp_pos]][now_index]

    pressure_factor <- 20 * (get_weather_trend(pressure_pos, predict_pos))
    wind_factor <- 20 * (get_weather_trend(wind_speed_pos, predict_pos))
    temp_factor <- 20 * (get_weather_trend(temp_pos, predict_pos))
    rain_factor <- 20 * (get_weather_trend(daily_rain_pos, predict_pos))
    solar_factor <- 10 * (get_weather_trend(solar_rad_pos, predict_pos))
    humidity_factor <- 10 * (get_weather_trend(humidity_pos, predict_pos))

    # Prediction Formula
    weather_formula <- (
      pressure_factor
      + wind_factor
        + temp_factor
        - rain_factor
        + solar_factor
        - humidity_factor
    ) * confidence

    # Grade Formula Result
    if (weather_formula <= 25) {
      # Rain Likely
      weather_desc <- weather_rain
    } else if (weather_formula <= 50) {
      # Clouds Likely
      weather_desc <- weather_cloudy
    } else if (weather_formula <= 75) {
      # Wind Likely
      weather_desc <- weather_windy
    } else {
      # Clear or Sunny
      if (morning_time <= predict_time && predict_time < evening_time) {
        weather_desc <- weather_sunny
      } else {
        weather_desc <- weather_clear
      }
    }

    # Return Predicted Data
    weather_icon <- get_weather_icon(weather_desc, predict_time)
    return(c(weather_desc, weather_icon, weather_temp))
  })


  # Get the current weather conditions.
  get_current_weather <- (function() {
    weather_desc <- get_weather_condition(now_index)
    weather_icon <- get_weather_icon(weather_desc, now_index)

    # Render current weather icons.
    output$weather_icon <- renderText(as.character(icon(
      weather_icon,
      size_current
    )))
    output$weather_tooltip <-
      renderText(as.character(icon(
        weather_icon,
        size_tooltip
      )))
    output$weather_desc <- renderText(weather_desc)
  })

  # Get tonight's predicted weather.
  get_weather_tonight <- (function(predict_pos) {
    data <- predict_weather(predict_pos)

    output$weather_icon_later <-
      renderText(as.character(icon(data[2], size_predict)))
    output$weather_desc_later <- renderText(data[1])
    temp_out <- renderText(
      sprintf(
        "Low %.0f\u00B0 F", as.double(data[3])
      )
    )
    output$out_high_later <- temp_out
  })

  # Get tomorrow's predicted weather.

  get_weather_tomorrow <- (function(predict_pos) {
    data <- predict_weather(predict_pos)

    output$weather_icon_1_day <-
      renderText(as.character(icon(data[2], size_predict)))
    output$weather_desc_1_day <- renderText(data[1])
    temp_out <- renderText(
      sprintf(
        "High %.0f\u00B0 F", as.double(data[3])
      )
    )
    output$out_high_1_day <- temp_out
  })
}
