library(shiny)

# historyServer.R - written by Michael N.
server <- {
  name <- reactive({input$nname})
  demo <- reactive({input$ndemo})
  lead <- reactive({input$nlead})
  
  turn <- reactiveVal(0)
  year <- reactiveVal(-10000)
  
  play_wealth <- reactiveVal(0)
  play_fame <- reactiveVal(0)
  play_progress <- reactiveVal(0)
  
  output$natdetails <- renderText(sprintf("The stage of history is set, and the curtains open on %s, led by %s. Where will the %s people stand in the river flows of history?", 
                                          name(), lead(), demo()))
  
  output$wealth <- renderText(play_wealth())
  output$fame <- renderText(play_fame())
  output$progress <- renderText(play_progress())
  
  
  formatYear <- reactive({
    if(year() < 0) {
      sprintf("%s BCE", abs(year()))
    } else {
      sprintf("%s CE", year())
    }
  })
  
  output$year <- renderText(formatYear())
  output$turn <- renderText(turn())
  
  observeEvent(input$nextTurn, {
      turn(turn() + 1)
      if(turn() >= 3) {
        year(year() + 500)
      } else {
        switch(turn(),
          "1" = year(-9750),
          "2" = year(-8250),
        )
      }
  })
}