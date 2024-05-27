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
          column(3, div(
            tags$a(
              href = "https://www.rit.edu/",
              target = "_blank",
              img(
                src = "ritp.jpg",
                height = 180,
                length = 180,
                style = "border-radius: 25px;"
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
                length = 180,
                style = "border-radius: 25px;"
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
                length = 180,
                style = "border-radius: 25px;"
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
                length = 180,
                style = "border-radius: 25px;"
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
                length = 180,
                style = "border-radius: 25px;"
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
                length = 180,
                style = "border-radius: 25px;"
              )
            )
          )),
          column(2),
        )
      )
    ),
  )
)
