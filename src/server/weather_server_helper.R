library(shiny)

source("src/server/weather_server_data.R", local = TRUE)

server <- {
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
  # Determine if there is any active weather alerts.
  get_active_alerts <- (function() {
    display_alert <- ""
    if (wind_gust >= 46 && wind_gust <= 57 || wind_speed >= 31
        && wind_speed >= 39) {
      display_alert <- "WIND ADVISORY"
    } else if (wind_gust >= 58 || wind_speed >= 40) {
      display_alert <- "HIGH WIND WARNING"
    } else if (out_temp < 105 && out_temp >= 100) {
      display_alert <- "HEAT ADVISORY"
    } else if (out_temp >= 105) {
      display_alert <- "EXCESSIVE HEAT WARNING"
    } else if (out_temp <= 50
        && wind_speed >= 5 && windchill <= -25) {
      display_alert <- "WIND CHILL WARNING"
    } else if (out_temp <= 50 
        && wind_speed >= 5 && windchill <= -15
        && windchill > -25) {
      display_alert <- "WIND CHILL ADVISORY"
    } else if (hourly_rain >= 1 && wind_gust >= 58) {
      display_alert <- "SEVERE THUNDERSTORM WARNING"
    } else if (hourly_rain >= 3) {
      display_alert <- "FLASH FLOOD WARNING"
    } else {
      display_alert <- "No active weather alerts."
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
        pws_data[[1]][now_index:tomorrow_index],
        pws_data[[6]][now_index:tomorrow_index],
        xlab = "Time (last 24 hours)",
        ylab = "Temperature (\u00B0 F)",
        type = "h",
        col = "#8db600",
        lwd = 3,
        xaxt = "n"
      ),
      "Dew Point" = plot(
        pws_data[[1]][now_index:tomorrow_index],
        pws_data[[23]][now_index:tomorrow_index],
        xlab = "Time (last 24 hours)",
        ylab = "Dew Point (\u00B0 F)",
        type = "h",
        col = "#8db600",
        lwd = 3,
        xaxt = "n"
      ),
      "Humidity" = plot(
        pws_data[[1]][now_index:tomorrow_index],
        pws_data[[7]][now_index:tomorrow_index],
        xlab = "Time (last 24 hours)",
        ylab = "Humidity (%)",
        type = "h",
        col = "#cc5500",
        lwd = 3,
        xaxt = "n"
      ),
      "Pressure" = plot(
        pws_data[[1]][now_index:tomorrow_index],
        pws_data[[5]][now_index:tomorrow_index] * 33.8639,
        xlab = "Time (last 24 hours)",
        ylab = "Pressure (millibars)",
        type = "h",
        col = "#cd5c5c",
        lwd = 3,
        xaxt = "n"
      ),
      "Rain" = plot(
        pws_data[[1]][now_index:tomorrow_index],
        pws_data[[14]][now_index:tomorrow_index],
        xlab = "Time (last 24 hours)",
        ylab = "Rainfall (inches)",
        type = "h",
        col = "#5f9ea0",
        lwd = 3,
        xaxt = "n"
      ),
      "Wind" = plot(
        pws_data[[1]][now_index:tomorrow_index],
        pws_data[[11]][now_index:tomorrow_index],
        xlab = "Time (last 24 hours)",
        ylab = "Wind Speed (mph)",
        type = "h",
        col = "#007fff",
        lwd = 3,
        xaxt = "n"
      ),
      "Wind Gusts" = plot(
        pws_data[[1]][now_index:tomorrow_index],
        pws_data[[12]][now_index:tomorrow_index],
        xlab = "Time (last 24 hours)",
        ylab = "Wind Gust Speed (mph)",
        type = "h",
        col = "#007fff",
        lwd = 3,
        xaxt = "n"
      ),
      "UV Index" = plot(
        pws_data[[1]][now_index:tomorrow_index],
        pws_data[[21]][now_index:tomorrow_index],
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
      at = cut(pws_data[[1]][now_index:tomorrow_index],
               "3 hours"),
      x = pws_data[[1]][now_index:tomorrow_index],
      format = "%I:%M %p"
    )
  })
}
