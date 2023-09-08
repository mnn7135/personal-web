library(shiny)

# written by Michael N
#

tagList(
  div(tags$h1(hr(), style = "font-size: 45px;")),
  tags$h1(
    fluidRow(
      column(
        9,
        strong(div(align = "center", "Personal Web | Quick Links")),
        hr(),
        fluidRow(
          column(2),
          column(2, div(
            tags$a(
              href = "https://www.bing.com/",
              target = "_blank",
              img(
                src = "bing.jpg",
                height = 180,
                length = 180
              )
            )
          )),
          column(1),
          column(2, div(
            tags$a(
              href = "https://www.google.com/",
              target = "_blank",
              img(
                src = "google.jpg",
                height = 180,
                length = 180
              )
            )
          )),
          column(1),
          column(2, div(
            tags$a(
              href = "https://www.rit.edu/",
              target = "_blank",
              img(
                src = "ritp.jpg",
                height = 180,
                length = 180
              )
            )
          )),
          column(2),
        ),
        hr(),
        fluidRow(
          column(2),
          column(2, div(
            tags$a(
              href = "https://github.com/mnn7135/",
              target = "_blank",
              img(
                src = "git.jpg",
                height = 180,
                length = 180
              )
            )
          )),
          column(1),
          column(2, div(
            tags$a(
              href = "https://www.linkedin.com/in/michael-nersinger/",
              target = "_blank",
              img(
                src = "lin.jpg",
                height = 180,
                length = 180
              )
            )
          )),
          column(1),
          column(2, div(
            tags$a(
              href = "https://trello.com/",
              target = "_blank",
              img(
                src = "trello.jpg",
                height = 180,
                length = 180
              )
            )
          )),
          column(2),
        ),
        hr(),
        fluidRow(
          column(2),
          column(2, div(
            tags$a(
              href = "https://stackoverflow.com/",
              target = "_blank",
              img(
                src = "stack.jpg",
                height = 180,
                length = 180
              )
            )
          )),
          column(1),
          column(2, div(
            tags$a(
              href = "https://www.firstinspires.org/robotics/frc",
              target = "_blank",
              img(
                src = "first.jpg",
                height = 180,
                length = 180
              )
            )
          )),
          column(1),
          column(2, div(
            tags$a(
              href = "https://www.indeed.com/?from=gnav-homepage",
              target = "_blank",
              img(
                src = "indeed.jpg",
                height = 180,
                length = 180
              )
            )
          )),
          column(2),
        )
      ),
      column(
        3,
        strong(div("Contact Details")),
        hr(),
        tags$h3(
          strong("Michael Nersinger"),
          hr(),
          "BS Software Engineering @ RIT",
          br(),
          "History Minor",
          br(),
          hr(),
          "Research Intern @ GTRI",
          br(),
          hr(),
          strong("Email"),
          hr(),
          "mnn7135@rit.edu",
          br(),
          hr(),
          strong("Languages"),
          hr(),
          fluidRow(
            column(6, div("Java"
            )),
            column(6, div("Python"
          ))),
          hr(),
          fluidRow(
            column(6, div("R"
            )),
            column(6, div("REACT"
            ))),
          hr(),
          fluidRow(
            column(6, div("C"
            )),
            column(6, div("JavaScript"
            ))),
          br(),
          hr(),
          strong("Other"),
          hr(),
          fluidRow(
            column(6, div("AWS Cloud"
            )),
            column(6, div("PostgreSQL"
            ))),
          hr(),
          fluidRow(
            column(4),
            column(4, div("Scrum"
            )),
            column(4)),
          hr(),
        ),
      ),
    ),
  )
)
