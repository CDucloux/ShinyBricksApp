#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @import bslib
#' @import pkgload
#' @importFrom dplyr filter select pull
#' @noRd
app_server <- function(input, output, session) {
  observeEvent(input$set_theme, {
    years <- df_prices |>
      filter(theme == input$set_theme) |>
      select(year) |>
      unique() |>
      pull()
    updateSelectInput(session, "set_year", choices = years, selected = years[1])
  })

  observeEvent(input$set_year, {
    names <- df_prices |>
      filter(theme == input$set_theme & year == input$set_year) |>
      select(name) |>
      unique() |>
      pull()
    updateSelectInput(session, "set_name", choices = names, selected = names[1])
  })

  observeEvent(input$set_name, {
    set_numbers <- df_prices |>
      filter(theme == input$set_theme & year == input$set_year & name == input$set_name) |>
      select(set_number) |>
      unique() |>
      pull()
    updateSelectInput(session, "set_number", choices = set_numbers, selected = set_numbers[1])
  })

  show_plot <- reactiveVal(TRUE) # pour le boutton

  observeEvent(input$display_graph_prices, {
    show_plot(!show_plot())
  })

  output$supertest <- renderUI({
    if (show_plot()) {
      plotlyOutput("set_prices_lollipops", height = "285px")
    } else {
      card(
        value_box(
          title = "Prix de détail",
          value = textOutput("set_retail_price"),
          showcase = bs_icon("currency-euro", size = "0.75em"),
          theme = "secondary",
          height = "5em"
        ),
        value_box(
          title = "Prix ~ condition : usé",
          value = textOutput("set_value_used"),
          showcase = bs_icon("currency-euro", size = "0.75em"),
          theme = "secondary",
          height = "5em"
        ),
        value_box(
          title = "Prix ~ condition : neuf",
          value = textOutput("set_value_new"),
          showcase = bs_icon("currency-euro", size = "0.75em"),
          theme = "secondary",
          height = "5em"
        ),
      )
    }
  })

  output$theme_plot <- renderPlotly(top_10_lineplot(df_prices, input$themes))
  output$theme_barchart <- renderPlotly(top_themes_barchart(df_prices, input$themes))
  output$theme_donut <- renderPlotly(grand_total_themes_donut(df_prices, input$themes))
  output$theme_table <- render_gt(expr = gt_tbl <- theme_table(df_prices, input$theme))
  output$theme_header <- renderText({
    paste("LEGO", input$theme)
  })
  output$theme_blocktext <- renderText({
    theme_blocktext(df_prices, input$theme)
  })
  output$theme_total_sets <- renderText({
    theme_total_sets(df_prices, input$theme)
  })
  output$theme_mean_rating <- renderText({
    theme_mean_rating(df_prices, input$theme)
  })
  output$theme_mean_pieces <- renderText({
    theme_mean_pieces(df_prices, input$theme)
  })
  output$theme_price_range <- renderText({
    theme_price_range(df_prices, input$theme)
  })
  output$theme_median_age <- renderText({
    theme_median_age(df_prices, input$theme)
  })
  output$theme_group <- renderText({
    theme_group(df_prices, input$theme)
  })
  output$theme_price_multiplier <- renderText({
    theme_price_multiplier(df_prices, input$theme)
  })
  output$theme_mean_price <- renderText({
    theme_mean_price(df_prices, input$theme)
  })
  output$theme_mean_price_new <- renderText({
    theme_mean_price_new(df_prices, input$theme)
  })
  output$theme_lifespan <- renderText({
    theme_lifespan(df_prices, input$theme)
  })

  output$year_header <- renderText({
    paste("LEGO en", input$year)
  })
  output$year_blocktext <- renderText({
    year_blocktext(df_prices, input$year)
  })
  output$year_total_sets <- renderText({
    year_total_sets(df_prices, input$year)
  })
  output$year_mean_rating <- renderText({
    year_mean_rating(df_prices, input$year)
  })
  output$year_mean_pieces <- renderText({
    year_mean_pieces(df_prices, input$year)
  })
  output$year_price_range <- renderText({
    year_price_range(df_prices, input$year)
  })
  output$year_price_multiplier <- renderText({
    year_price_multiplier(df_prices, input$year)
  })
  output$year_mean_price <- renderText({
    year_mean_price(df_prices, input$year)
  })
  output$year_mean_price_new <- renderText({
    year_mean_price_new(df_prices, input$year)
  })
  output$year_general_plot <- renderPlotly(year_general_plot(df_prices,
    by = input$groupby,
    var = input$variable,
    by_df = by_df,
    var_df = var_df
  ))
  output$year_barchart <- renderPlotly(year_barchart(df_prices, years = 1994:2024))

  output$set_retail_price <- renderText({
    set_retail_price(df_prices, input$set_number)
  })
  output$set_value_new <- renderText({
    set_value_new(df_prices, input$set_number)
  })
  output$set_value_used <- renderText({
    set_value_used(df_prices, input$set_number)
  })
  output$set_number_plus_name <- renderText({
    glue::glue("<i>Set n°{input$set_number} : {set_name(df_prices, input$set_number)}</i>")
  })
  output$set_pieces_number <- renderText({
    set_pieces_number(df_prices, input$set_number)
  })
  output$set_figs_number <- renderText({
    set_figs_number(df_prices, input$set_number)
  })
  output$set_ppp <- renderText({
    set_ppp(df_prices, input$set_number)
  })
  output$set_age_range <- renderText({
    set_age_range(df_prices, input$set_number)
  })
  output$set_prices_lollipops <- renderPlotly(set_prices_lollipops(df_prices, input$set_number))
  output$set_image_card <- renderUI({
    image_url <- set_image(df_prices, input$set_number)
    brickset_page <- set_page(df_prices, input$set_number)
    if (is.na(image_url)) {
      value_box(
        "Attention",
        value = "Aucune image disponible pour ce set !",
        showcase = bs_icon("exclamation-triangle-fill"),
        theme = "bg-gradient-orange-red"
      )
    } else {
      card_image(
        class = "mx-auto", # classe qui permet de centrer une image dans une card
        file = image_url,
        height = "240px",
        width = "15em",
        href = brickset_page
      )
    }
  })

  output$iframe_viewer <- renderUI({
    if (check_link(input$set_number) == "HTTP 200 OK.") {
      card(
        class = "mx-auto",
        full_screen = TRUE,
        tags$iframe(
          src = get_3D_link(input$set_number),
          scrolling = TRUE,
          height = "500em"
        )
      )
    } else {
      value_box(
        "Attention",
        value = "Vue 3D indisponible pour ce set !",
        showcase = bs_icon("exclamation-triangle-fill"),
        theme = "bg-gradient-orange-red"
      )
    }
  })
  output$set_reviews <- renderText({
    create_reviews_html(df_reviews, input$set_number)
  })
  output$set_wordcloud_all <- renderPlot({
    get_wordcloud_all(df_reviews, input$set_number)
  })
  output$set_wordcloud_adj <- renderPlot({
    get_wordcloud_adj(df_reviews, input$set_number)
  })
  output$set_instructions <- renderText({
    display_instructions(df_instructions, input$set_number)
  })
}
