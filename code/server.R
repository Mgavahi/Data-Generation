# Import required library
library(shiny)
library(triangle)
library(magrittr)
library(DT)

shinyServer(function(input, output) {
    tableInput <- eventReactive(input$generate, {
        # dataframe rnorm ----
        df_rnorm <-
            rnorm(
                n = input$row_num,
                mean = input$mean_norm,
                sd = input$sd_norm
            ) %>%
            data.frame() %>%
            round(digits = 2)
        colnames(df_rnorm)[1] <- input$var_name
        
        # dataframe runif ----
        df_runif <-
            runif(
                n = input$row_num,
                min = input$min_uni,
                max = input$max_uni
            ) %>%
            data.frame() %>%
            round(digits = 2)
        colnames(df_runif)[1] <- input$var_name
        
        # dataframe rtiangular ----
        df_rtri <-
            rtriangle(n = input$row_num,
                      input$min_tri,
                      input$max_tri) %>%
            data.frame() %>%
            round(digits = 2)
        colnames(df_rtri)[1] <- input$var_name
        
        # dataframe rexponential ----
        df_rexp <- rexp(n = input$row_num,
                        rate = input$rate_exp) %>%
            data.frame() %>%
            round(digits = 2)
        colnames(df_rexp)[1] <- input$var_name
        
        # dataframe random ----
        df_rrand <-
            sample(
                x = c(input$min_ran:input$max_ran),
                size = input$row_num,
                replace = TRUE
            ) %>%
            data.frame() %>%
            round(digits = 2)
        colnames(df_rrand)[1] = input$var_name
        
        # dataframe sequential ----
        df_seq <-
            seq(from = input$start_seq,
                to = input$start_seq + input$row_num - 1) %>%
            data.frame()
        colnames(df_seq)[1] = input$var_name
        
        switch (
            input$dist_name,
            "Normal Distribution" = df_rnorm,
            "Uniform Distribution" = df_runif,
            "Triangular Distribution" = df_rtri,
            "Exponential Distribution" = df_rexp,
            "Random Distribution" = df_rrand,
            "Sequential Numbers" = df_seq
        )
    })
    
    # Output table ----
    output$view <- renderDataTable(server = FALSE,
                                   ## Download all data
                                   datatable(
                                       data = tableInput(),
                                       extensions = c("Scroller", "Buttons"),
                                       options = list(
                                           deferRender = TRUE,
                                           scrollY = 400,
                                           scroller = TRUE,
                                           dom = "Blfrtip",
                                           buttons = list(
                                               "copy",
                                               list(
                                                   extend = "collection",
                                                   buttons = c("excel",
                                                               "csv",
                                                               "pdf"),
                                                   text = "Download Data"
                                               )
                                           ),
                                           pageLength = 10
                                       )
                                   ))
    
})
