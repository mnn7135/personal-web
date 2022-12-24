library(shiny)

tagList(div(tags$h1(
  strong("Welcome to My Homepage!"),
  hr(), style="font-size: 45px;"
  )),
  tags$h1(
    fluidRow(
      column(9, strong(div("Updates")),
             hr(),
             "December 24th, 2022 - Refined weather page and cleaned up the site.",
             hr(),
             "September 24th, 2022 - Cleaned up website appearance.",
             hr(),
             strong(div("Quick Links")),
             hr(),
             fluidRow(
               column(4, div(tags$a(href="https://www.bing.com/", target="_blank", img(src="bing.jpg", height=150, length=150))),
               ),
               column(4, div(tags$a(href="https://www.google.com/", target="_blank", img(src="google.jpg", height=150, length=150))),
               ),
               column(4, div(tags$a(href="https://www.nationstates.net/nation=wolffoxia", target="_blank", img(src="ns.jpg", height=150, length=150))),
               ),
             ),
             hr(),
             fluidRow(
               column(2, div(),
               ),
               column(4, div(tags$a(href="https://github.com/mnn7135/", target="_blank", img(src="git.jpg", height=150, length=150))),
               ),
               column(4, div(tags$a(href="https://twitter.com/wulvlox/", target="_blank", img(src="twit.jpg", height=150, length=150))),
               ),
               column(2, div(),
               ),
             )
      ),
      column(3, strong(div("Contact Details")),
             hr(),
             "Questions? Feel free to reach out!",
             hr(),
             div(img(src="michael.jpg", height=250, length=250)),
             hr(),
             tags$h3(
             "Michael Nersinger",
        hr(),
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