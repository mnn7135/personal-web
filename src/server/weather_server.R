library(shiny)

source("src/server/weather_server_helper.R", local = TRUE)
source("src/server/weather_server_prediction.R", local = TRUE)
source("src/server/weather_server_data.R", local = TRUE)

# written by Michael N
#
# This file handles data associated with the back end of the weather.R page.
# It pulls data from the weather station using the Ambient Weather API, and
# displays current weather information. It also looks at general trends in
# the data over the previous 24 hours to make predictions about weather in the
# future.

server <- {
  
  # Ensure that there is data available from the station.
  if (!is.null(pws_data)) {
    # Get the icon and description for the current weather.
    get_current_weather()
    # Outdoor Information
    output$weather_tab <-
      renderText(sprintf(
        "Victor, NY %.0f\u00B0 F",
        out_temp
      ))
    output$out_dew_point <-
      renderText(sprintf("%.0f\u00B0 F", out_dewpoint))
    output$date <- renderText(sprintf(
      "Last pull from %s",
      format(
        date_time,
        tz = "America/New_York",
        usetz = TRUE,
        format = "%D %I:%M %p"
      )
    ))
    output$out_temp <- renderText(sprintf("%.0f\u00B0 F", out_temp))
    output$out_feels <-
      renderText(sprintf(
        "Feels Like %.0f\u00B0 F",
        out_feels
      ))
    output$out_humidity <-
      renderText(sprintf("%.0f%%", out_humidity))
    output$out_pressure <-
      renderText(sprintf("%.2f mbar", out_pressure))
    output$daily_rain <- renderText(sprintf("%.2f in", daily_rain))
    # Determine Wind Direction
    wind_direction <- get_wind_direction(wind_dir)
    output$wind_speed <-
      renderText(sprintf(
        "%.0f mph from %s", wind_speed,
        wind_direction
      ))
    output$wind_gust <-
      renderText(sprintf(
        "%.0f mph from %s", wind_gust,
        wind_direction
      ))
    # Get active alerts.
    output$alert <- renderText(get_active_alerts())
    # Determine hourly rain
    rain_last_hour <- ""
    if (hourly_rain >= 0.1) {
      rain_last_hour <- sprintf("%.2f in hourly", hourly_rain)
    }
    output$rain_last_hour <- renderText(rain_last_hour)
    # Determine UV Risk
    output$solar_data <-
      renderText(sprintf("%.0f %s", uv_index, get_uv_risk()))
    # Render labels and graphs
    graph1 <- reactive({
      make_graph(input$graph_type_1)
    })
    graph2 <- reactive({
      make_graph(input$graph_type_2)
    })
    graph3 <- reactive({
      make_graph(input$graph_type_3)
    })
    graph4 <- reactive({
      make_graph(input$graph_type_4)
    })
    output$graph_1 <- renderText(reactive({
      input$graph_type_1
    }))
    output$graph_2 <- renderText(reactive({
      input$graph_type_2
    }))
    output$graph_3 <- renderText(reactive({
      input$graph_type_3
    }))
    output$graph_4 <- renderText(reactive({
      input$graph_type_4
    }))
    output$data_graph_1 <- renderPlot(graph1())
    output$data_graph_2 <- renderPlot(graph2())
    output$data_graph_3 <- renderPlot(graph3())
    output$data_graph_4 <- renderPlot(graph4())
    # Weather Prediction
    get_weather_tonight(six_hour_index)
    get_weather_tomorrow(last_day_index)
    # Windchill should only be displayed when it has a noticeable value
    if (windchill <= -5) {
      output$windchill_value <-
        renderText(sprintf("%.0f\u00B0 F", windchill))
      output$windchill_text <- renderText("Wind Chill")
    }
    # Display sunrise/sunset information
    output$sunrise_time <- renderText(format(
      morning_time,
      tz = "America/New_York",
      usetz = TRUE,
      format = "%I:%M %p"
    ))
    output$sunset_time <- renderText(format(
      evening_time,
      tz = "America/New_York",
      usetz = TRUE,
      format = "%I:%M %p"
    ))
  } else {
    # Handle if there is no data to pull
    output$weather_tab <- renderText("??\u00B0 F Victor, NY")
    output$alert <- renderText("Unable to retrieve weather data.
                               Try refreshing the page.")
  }
}
