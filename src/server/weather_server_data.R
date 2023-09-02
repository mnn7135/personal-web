library(shiny)

server <- {
  # This class defines all constants and values to be used by weatherServer
  # related functions.
  # Text Descriptions
  WEATHER_SUNNY <- "Sunny"
  WEATHER_CLEAR <- "Clear"
  WEATHER_CLOUDY <- "Cloudy"
  WEATHER_WINDY <- "Windy"
  WEATHER_RAIN <- "Rain"
  # Font Awesome Icons
  ICON_SUNNY <- "sun"
  ICON_CLEAR <- "moon"
  ICON_CLOUDY_SUN <- "cloud-sun"
  ICON_CLOUDY_MOON <- "cloud-moon"
  ICON_WINDY = "wind"
  ICON_RAIN = "cloud-rain"
  # Icon Sizes
  SIZE_TOOLTIP <- "fa-1x"
  SIZE_PREDICT <- "fa-5x"
  SIZE_CURRENT <- "fa-10x"
  # Prediction Factors
  PREDICTION_FACTOR_TONIGHT <- 0.25
  PREDICTION_FACTOR_TOMORROW <- 0.20
  # Indexes for displaying or predicting weather.
  NOW_INDEX <- 288 # Most recent data
  TONIGHT_INDEX <- 252 # Furthest point back for displaying 6-hour changes.
  TOMORROW_INDEX <- 1 # Furthest point back for displaying 24-hour changes.
  PREDICT_INDEX <- 4 # Furthest point back for predicting weather with buffer.
  # Handle App level server configurations for fetching data.
  Sys.setenv(AW_API_KEY =
               "9258f994d53042ca9bcbe7f5cc44dfbbfa366e4ca4ac43c19a33268a6e060cb6")
  Sys.setenv(AW_APPLICATION_KEY =
               "78a34a92bffc4cc8962e87525a8a35f843e1d5dda7a94c3f88114283d16389ed")
  Sys.setenv(GITHUB_PAT = "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")
  pws_data = fetch_device_data("E8:DB:84:E4:03:97")$content
  date_time <- pws_data[[1]][NOW_INDEX]
  # Times for use in determining icons/prediction formulas.
  CURRENT_TIME <-
    as.POSIXlt(pws_data[[1]][NOW_INDEX], format = "%H:%M")
  MORNING_TIME <- as.POSIXlt("07:00:00", format = "%H:%M") # 7 AM
  NOON_TIME <- as.POSIXlt("12:00:00", format = "%H:%M") # 12 PM
  EVENING_TIME <- as.POSIXlt("19:00:00", format = "%H:%M") # 7 PM
  # Check to make sure data was retrieved.
  if (!is.na(date_time)) {
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
    windchill <- 35.74 + (0.6215 * out_temp)
    - (35.75 * wind_speed ^ 0.16) + (0.4275 * out_temp * wind_speed ^ 0.16)
  }
}
