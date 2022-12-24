library(shiny)

tagList(div(tags$h1(
  strong("Welcome!"),
  hr(), style="font-size: 80px;"
  )),
  tags$h1(
    fluidRow(
      column(9, strong(div("Updates")),
             hr(),
             "December 24th, 2022 - Refined weather page and cleaned up the site.",
             hr(),
             "September 24th, 2022 - Cleaned up website appearance."
      ),
      column(3, strong(div("Contact Details")),
             hr(),
             "Questions? Feel free to reach out!",
             br(),
             div(img(src="michael.jpg", height=250, length=250)),
             tags$h3(
             "Michael Nersinger",
        br(),
        "Software Engineering Student",
        br(),
        hr(),
        strong("Discord"),
        hr(),
        "Wulvlox#8580",
        br(),
        hr(),
        strong("Other"),
        hr(),
        tags$a(href="https://www.linkedin.com/in/michael-nersinger/", target="_blank", "Michael's Linkedin"),
        br(),
        tags$a(href="https://github.com/mnn7135", target="_blank", "Michael's GitHub"),
      ),
    ),
  ),
  )
)