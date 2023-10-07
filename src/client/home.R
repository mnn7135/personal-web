library(shiny)

# written by Michael N
#

tagList(
  div(tags$h1(hr(), style = "font-size: 45px;")),
  tags$h1(
    fluidRow(
      column(
        8,
        strong(div(align = "center", "Personal Web | Quick Links")),
        hr(),
        fluidRow(
          column(2),
          column(4, div(
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
          column(5, div(
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
        ),
        hr(),
        fluidRow(
          column(2),
          column(3, div(
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
          column(3, div(
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
          column(2)
        ),
        hr(),
        fluidRow(
          column(2),
          column(3, div(
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
          column(2),
          column(3, div(
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
          column(2)
        ),
        hr(),
        fluidRow(
          column(2),
          column(3, div(
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
          column(2),
          column(3, div(
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
          column(2),
        )
      ),
      column(
        4,
        strong(div("Contact Details")),
        hr(),
        tags$h3(
          strong("Michael Nersinger"),
          hr(),
          "Software Engineering BS at RIT",
          br(),
          "History Minor",
          br(),
          hr(),
          "Research Intern at GTRI",
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
            column(6, div("Python"
            )),
            column(1),
            column(5, div("Java"
            ))),
          hr(),
          fluidRow(
            column(6, div("REACT"
            )),
            column(1),
            column(5, div("R"
            ))),
          hr(),
          fluidRow(
            column(6, div("C"
            )),
            column(1),
            column(5, div("JS"
            ))),
          hr(),
          br(),
          strong("Other"),
          hr(),
          fluidRow(
            column(6, div("AWS"
            )),
            column(1),
            column(5, div("SQL"
            ))),
          hr(),
          fluidRow(
            column(12, div("Scrum"
            ))),
          hr(),
        ),
      ),
    ),
  )
)
