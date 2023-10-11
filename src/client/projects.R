library(shiny)

# written by Michael N
#

tagList(
  div(tags$h1(hr(), style = "font-size: 45px;")),
  tags$h1(
    div(align = "center", strong("Personal Web | Software Projects")),
    hr()
  ),
  tags$h3(fluidRow(
    column(
      6,
      strong("SWEN 262 - Muze Music Library System"),
      hr(),
      "Java |",
      br(),
      br(),
      "This class project required us to create the Muze Music Library ",
      "System, a library for storing music, artists, and albums that ",
      "contain songs. The main objective of the project was to use design ",
      "pattern on a team project. The main subsystem I focused on was ",
      "importing library data from csv files and later on from an online ",
      "database of music that can be accessed using API GETs to populate ",
      "user libraries and a local saved database. This also meant that a ",
      "save system was needed as well, which I implemented with writing to ",
      "a csv file. The design patterns that I gained the most experience ",
      "with were the Factory, Composite, and Proxy patterns. It was also ",
      "great to work on a project that made us of API to retrieve data, ",
      "which I would use for further projects including this website. The ",
      "project went well in both part 1 and the part 2 revision. I was ",
      "satisfied with my ability to identify and justify what patterns ",
      "would work well.",
      hr()
    ),
    column(
      6,
      strong("SWEN 340 - Hardware LED Project"),
      hr(),
      "C | ",
      tags$a(
        href = "https://github.com/mnn7135/LED_Final", target =
          "_blank", "GitHub Repository"
      ),
      br(),
      br(),
      "This class project was an individual assignment. We were tasked to ",
      "create a system that could accept commands and control LEDs both ",
      "through remote commands and physical buttons on the breadboard when ",
      "toggled to local mode. This had to be done through the use of hardware ",
      "interrupts by looking at documentation provided by the board ",
      "manufacturer and through programming in C. The highlights of this ",
      "project were that the demo went perfectly and I made sure that all of ",
      "my code was properly documented and adhered to good software design ",
      "(i.e. Single Responsibility Principle for .c files where appropriate).",
      br(),
      br(),
      br(),
      br(),
      br(),
      hr()
    )
  )),
  tags$h3(
    fluidRow(
      column(
        6,
        strong("SWEN 356 - TuitionWaster RShiny App"),
        hr(),
        "R and RShiny |",
        br(),
        br(),
        "For this project, we were tasked to build an app to display what ",
        "RIT students had wasted their tuition on, and what they could have ",
        "purchased with that money. In a five person team, we used Vanilla ",
        "Scrum with an initial Sprint 0 to plan what technology we would use, ",
        "and the high-level architecture of our system. This project required ",
        "us to implement some sort of DevOps/Automated Deployment system to ",
        "enhance the project beyond simply using an agile framework. We ",
        "settled on using R and RShiny to reduce the difficulty of ",
        "implementation, and we made use of GitHub Actions to automatically ",
        "deploy our website to RShiny apps. At the end, our group received ",
        "great marks from peers, notably because our website was interactive ",
        "during our demo presentation.",
        hr()
      ),
      column(
        6,
        strong("CSCI 140 - Reddit Place"),
        hr(),
        "Java |",
        br(),
        br(),
        "This class project required us to re-create the Reddit Place tile ",
        "board, with a server-side and client-side implantation, in a ",
        "full-stack application (backend and PTUI/GUI). In addition, we added ",
        "improvements such as a variety of bots that place tiles randomly or ",
        "in patterns. This project was developed for a CS course and ",
        "therefore the approach we used was mostly code-and-fix. We did ",
        "however make use of peer reviews to refine our code and make it ",
        "better. This project was developed alongside two other students. ",
        "Overall, we performed well with our project due to its base ",
        "quality and the added enhancements.",
        br(),
        br(),
        br(),
        hr()
      )
    )
  )
)
