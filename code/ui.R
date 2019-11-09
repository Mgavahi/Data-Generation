# Import required library
library(shiny)
library(triangle)
library(dplyr)
library(DT)


shinyUI(fluidPage(
    # Header ----
    titlePanel(title = h2("Data Generation", align = "center"),
         windowTitle = "DataGeneration"),
    hr(),
    sidebarLayout(
        # Sidebar ----
        sidebarPanel(
            # Enter Name Variable ----
            textInput(
                inputId = "var_name",
                label = "Enter Name Variable",
                value = "My Variable"
            ),
            
            # Enter Number of rows ----
            numericInput(
                inputId = "row_num",
                label = "Enter Number of rows",
                value = "10",
                min = 1
            ),
            
            # Select Distribution ----
            selectInput(
                inputId = "dist_name",
                label = "Select Distribution",
                choices = c(
                    "Normal Distribution",
                    "Uniform Distribution",
                    "Triangular Distribution",
                    "Exponential Distribution",
                    "Random Distribution",
                    "Sequential Numbers"
                ),
                selected = 1
            ),
            # Select mean and sd normal 
            conditionalPanel(
                condition = "input.dist_name == 'Normal Distribution'",
                numericInput(
                    inputId = "mean_norm",
                    label = "Mean",
                    value = "0"
                ),
                numericInput(
                    inputId = "sd_norm",
                    label = "Sd",
                    value = "1"
                )
            ),
            # Select max and min uniform
            conditionalPanel(
                condition = "input.dist_name == 'Uniform Distribution'",
                numericInput(
                    inputId = "min_uni",
                    label = "Minimum",
                    value = "1"
                ),
                numericInput(
                    inputId = "max_uni",
                    label = "Maximum",
                    value = "5"
                )
            ),
            # Select max and min triangular
            conditionalPanel(
                condition = "input.dist_name == 'Triangular Distribution'",
                numericInput(
                    inputId = "min_tri",
                    label = "Minimum No",
                    value = "5"
                ),
                numericInput(
                    inputId = "max_tri",
                    label = "Maximum No",
                    value = "10"
                )
            ),
            # Select rate exponential
            conditionalPanel(
                condition = "input.dist_name == 'Exponential Distribution'",
                numericInput(
                    inputId = "rate_exp",
                    label = "Rate",
                    value = "1"
                )
            ),
            # Select max and min random
            conditionalPanel(
                condition = "input.dist_name == 'Random Distribution'",
                numericInput(
                    inputId = "min_ran",
                    label = "Minimum",
                    value = "1"
                ),
                numericInput(
                    inputId = "max_ran",
                    label = "Maximum",
                    value = "10"
                )
            ),
            # Select start sequential
            conditionalPanel(
                condition = "input.dist_name == 'Sequential Numbers'",
                numericInput(
                    inputId = "start_seq",
                    label = "Start No",
                    value = "2"
                )
            ),
        
            # Button ----
            # Customize color button
            tags$head(tags$style(
                HTML('#generate{background-color:#2EFE9A}')
            )),
            
            # Generate button
            actionButton(
                inputId = "generate",
                label = "Generate Data",
                icon = icon("check")
            ),
            hr(),
            # Author name ----
            helpText("Author: M.Gavahi"),
            helpText("Version: 1.0")
        ),
        
        # MainPanel ----
        mainPanel(# output table
            dataTableOutput("view"))
    )
))