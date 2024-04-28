#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import bslib
#' @import plotly
#' @import gt
#' @importFrom tibble as_tibble
#' @importFrom bsicons bs_icon
#' @importFrom dplyr select filter summarise pull group_by arrange
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    page_navbar(
      id = "nav",
      bg = "#DA291C",
      title = span(
        img(src = "www/shinybricks.png", height = 80),
        "Shinybricks",
        style = "font-family: Silkscreen;"
      ),
      theme = custom_theme(),
      sidebar = sidebar(
        open = FALSE,
        conditionalPanel(
          "input.nav === 'Accueil'",
          card(
            card_image(
              file = "inst/app/www/shinybricks.png",
              href = "https://github.com/rstudio/shiny"
            ),
          ),
          tags$hr(),
          markdown("N'hésitez pas à nous contacter sur Github (voir l'onglet 🔗 **Liens**) si vous détectez le moindre problème !"),
          markdown(glue::glue("> *ShinyBricks* © **{Sys.Date() |> format('%Y') |> as.numeric()}**"))
        ),
        conditionalPanel(
          "input.nav === 'Analyse par thème'",
          markdown("**Sélection des thèmes**"),
          accordion(
            class = "p-1",
            open = FALSE,
            accordion_panel(
              "Onglet 1 & 2",
              icon = bs_icon("menu-app"),
              selectizeInput(
                "themes",
                "Thèmes",
                unique(sort(df_prices$theme)),
                multiple = TRUE,
                options = list(maxItems = 5),
                selected = top_5_themes()
              ),
            ),
          ),
          accordion(
            class = "p-1",
            open = FALSE,
            accordion_panel(
              "Onglet 3 & 4",
              icon = bs_icon("menu-app"),
              selectInput("theme", "Thème", unique(sort(df_prices$theme)), selected = "Minecraft")
            ),
          ),
        ),
        conditionalPanel(
          "input.nav === 'Analyse par an'",
          numericInput("year", "Date",
            value = Sys.Date() |> format("%Y") |> as.numeric(),
            min = 1994,
            max = Sys.Date() |> format("%Y") |> as.numeric(),
            step = 1
          )
        ),
        conditionalPanel(
          "input.nav === 'Analyse par set'",
          accordion(
            accordion_panel(
              "Recherche",
              icon = bs_icon("search"),
              selectInput(
                "set_theme",
                "Thème",
                unique(sort(df_prices$theme)),
                selected = unique(sort(df_prices$theme)) |> as_tibble() |> filter(value == "Icons") |> pull()
              ),
              selectInput("set_year", "Année", unique(sort(df_prices$year)), selected = "2020"),
              selectInput("set_name", "Nom du set", "Haunted House", selected = "Haunted House"),
              selectInput("set_number", "Numéro du set", "10273-1", selected = "10273-1"),
            ),
          ),
        ),
      ),
      nav_panel(
        "Accueil",
        icon = bs_icon("house-fill"),
        includeCSS("inst/app/www/style.css"),
        includeCSS("inst/app/www/font.css"),
        card(
          full_screen = TRUE,
          card_header("👋 Bienvenue sur ShinyBricks"),
          height = 200,
          htmltools::includeMarkdown("markdown/welcome.md"),
        ),
        layout_columns(
          value_box(
            title = "Nombre de sets disponibles",
            value = nrow(df_prices),
            showcase = bs_icon("basket"),
            theme = "secondary",
          ),
          value_box(
            title = "Prix moyen des sets",
            value = round(df_prices |> select(retail_price) |> summarise(mean_price = mean(retail_price)) |> pull(),2),
            showcase = bs_icon("currency-euro"),
            theme = "white",
          ),
          value_box(
            title = "Nombre moyen de pièces",
            value = round(df_prices |> select(pieces) |> summarise(mean_pieces = mean(pieces, na.rm = TRUE)) |> pull(),0),
            showcase = bs_icon("boxes"),
            theme = "secondary",
          ),
        ),
      ),
      nav_panel(
        "Analyse par thème",
        icon = bs_icon("columns-gap"),
        navset_card_tab(
          nav_panel(
            "Tendances",
            card(
              full_screen = TRUE,
              card_header(
                "📈 Evolution des thèmes par année",
                class = "d-flex justify-content-between",
                tooltip(
                  bs_icon("info-circle"),
                  "Par défaut, les 5 premiers thèmes (en terme de nombre de sets commercialisés) sont sélectionnés."
                )
              ),
              plotlyOutput("theme_plot")
            ),
          ),
          nav_panel(
            "Répartition",
            layout_columns(
              card(
                full_screen = TRUE,
                card_header(
                  bs_icon("bar-chart-line-fill"), "Nombre de sets par thème",
                ),
                card_body(
                  class = "p-0",
                  plotlyOutput("theme_barchart")
                )
              ),
              card(
                full_screen = TRUE,
                card_header(
                  bs_icon("percent"),
                  "Part des thèmes sélectionnés dans le total"
                ),
                card_body(plotlyOutput("theme_donut"))
              )
            )
          ),
          nav_panel("Tableau d'un thème", card(gt_output(outputId = "theme_table"), full_screen = TRUE)),
          nav_panel(
            "Analyse approfondie d'un thème",
            tags$h2(textOutput("theme_header")),
            tags$blockquote(textOutput("theme_blocktext")),
            layout_columns(
              card(
                card_header(
                  bs_icon("file-earmark-text"),
                  "Fiche d'information du thème"
                ),
                tags$ul(
                  tags$li(htmlOutput("theme_total_sets")),
                  tags$li(htmlOutput("theme_mean_rating")),
                  tags$li(htmlOutput("theme_mean_pieces")),
                  tags$li(htmlOutput("theme_price_range")),
                  tags$li(htmlOutput("theme_lifespan")),
                  tags$li(htmlOutput("theme_median_age")),
                  tags$li(htmlOutput("theme_group")),
                  tags$li(htmlOutput("theme_price_multiplier")),
                ),
              ),
              card(
                value_box(
                  title = "Prix moyen des sets à l'achat",
                  value = textOutput("theme_mean_price"),
                  showcase = bs_icon("currency-euro"),
                  theme = "secondary",
                ),
                value_box(
                  title = "Prix moyen des sets aujourd'hui",
                  value = textOutput("theme_mean_price_new"),
                  showcase = bs_icon("currency-euro"),
                  theme = "secondary",
                ),
              )
            ),
          ),
          nav_panel(
            "Nombre de sets par thème",
            df_prices |>
              group_by(theme) |>
              summarise(n = dplyr::n()) |>
              arrange(desc(n)) |>
              gt() |>
              tab_header(
                title = md("**Nombre de sets ![](https://upload.wikimedia.org/wikipedia/commons/2/24/LEGO_logo.svg){width=15 height=15} par thème.**"),
              ) |>
              tab_style(
                locations = cells_body(columns = theme),
                style = cell_text(weight = "bold")
              ) |>
              cols_label(
                theme = html(fontawesome::fa("empire"), "Thème"),
                n = html(fontawesome::fa("list"), "Nombre de Sets"),
              ) |>
              opt_interactive(
                use_compact_mode = TRUE,
                use_text_wrapping = FALSE
              )
          )
        )
      ),
      nav_panel(
        "Analyse par an",
        icon = bs_icon("calendar-range-fill"),
        navset_card_tab(
          nav_panel(
            "Répartition",
            card(
              full_screen = TRUE,
              card_header(
                "📊 Nombre de sets par an",
                class = "d-flex justify-content-between",
              ),
              plotlyOutput("year_barchart")
            )
          ),
          nav_panel(
            "Analyse approfondie d'une année",
            tags$h2(textOutput("year_header")),
            tags$blockquote(textOutput("year_blocktext")),
            layout_columns(
              card(
                card_header(
                  bs_icon("file-earmark-text"),
                  "Fiche d'information de l'année"
                ),
                tags$ul(
                  tags$li(htmlOutput("year_total_sets")),
                  tags$li(htmlOutput("year_mean_rating")),
                  tags$li(htmlOutput("year_mean_pieces")),
                  tags$li(htmlOutput("year_price_range")),
                  tags$li(htmlOutput("year_price_multiplier")),
                ),
              ),
              card(
                value_box(
                  title = "Prix moyen des sets à l'achat",
                  value = textOutput("year_mean_price"),
                  showcase = bs_icon("currency-euro"),
                  theme = "secondary",
                ),
                value_box(
                  title = "Prix moyen des sets aujourd'hui",
                  value = textOutput("year_mean_price_new"),
                  showcase = bs_icon("currency-euro"),
                  theme = "secondary",
                ),
              )
            )
          )
        )
      ),
      nav_panel(
        "Analyse par set",
        icon = bs_icon("box-seam-fill"),
        navset_card_tab(
          nav_panel(
            "Informations générales",
            layout_columns(
              card(
                full_screen = FALSE,
                card_header(
                  bs_icon("card-image"),
                  "Visualisation",
                  class = "d-flex justify-content-between",
                  tooltip(
                    bs_icon("info-circle"),
                    markdown("Cliquer sur l'image vous renverra sur la page [Brickset](https://brickset.com/) du set associé.")
                  )
                ),
                uiOutput("set_image_card"),
                card_body(
                  fill = FALSE,
                  div(
                    class = "p-3 border rounded d-flex justify-content-center",
                    p(
                      class = "fw-light text-muted",
                      htmlOutput("set_number_plus_name"),
                    )
                  ),
                ),
              ),
              card(
                full_screen = TRUE,
                card_header(bs_icon("card-text"), "Fiche du set"),
                class = "p-0",
                tags$ul(
                  tags$li(htmlOutput("set_pieces_number")),
                  tags$li(htmlOutput("set_figs_number")),
                  tags$li(htmlOutput("set_ppp")),
                  tags$li(htmlOutput("set_age_range")),
                ),
                actionButton("display_graph_prices", "Cards | Graph !", icon = icon("arrow-right-arrow-left")),
                uiOutput("supertest"),
              ),
            ),
          ),
          nav_panel(
            "Vue 3D",
            uiOutput("iframe_viewer"),
            htmlOutput("set_instructions")
          ),
          nav_panel(
            "Avis sur le set",
            layout_columns(
              col_widths = c(8, 4),
              card(
                card_header(
                  bs_icon("chat-dots-fill"), "Commentaires"
                ),
                tags$ul(
                  tags$div(htmlOutput("set_reviews"))
                ),
              ),
              card(
                full_screen = TRUE,
                card_header(
                  bs_icon("cloud-haze-fill"), "Nuages de mots"
                ),
                tags$ul(
                  tags$h4("Avec tous les mots :"),
                  tags$div(plotOutput("set_wordcloud_all")),
                  tags$h4("Adjectifs seulement :"),
                  tags$div(plotOutput("set_wordcloud_adj"))
                ),
              )
            ),
          ),
        ),
      ),
      nav_panel(
        "🏷️ Pricing",
        navset_card_tab(
          nav_panel(
            "Distribution des prix",
            card(
              pricing_hist_plot(df_prices),
              full_screen = TRUE
            )
          ),
          nav_panel("Prix VS Nombre de pièces", card(pricing_pieces_plot(df_prices))),
          nav_panel("Pricing par thème", card(pricing_table(df_prices), full_screen = TRUE)),
          nav_panel("Licences dérivées", card(pricing_licensed(df_prices), full_screen = TRUE))
        )
      ),
      nav_spacer(),
      nav_menu(
        title = "🔗 Liens",
        align = "right",
        nav_item(a(href = "https://github.com/CDucloux", bsicons::bs_icon("github"), "Corentin DUCLOUX")),
        nav_item(a(href = "https://github.com/HTilki", bsicons::bs_icon("github"), "Hassan TILKI"))
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "ShinyBricks"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
