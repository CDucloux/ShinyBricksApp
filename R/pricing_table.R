#' Analyse du pricing par thème.
#'
#' Cette fonction prend un dataframe contenant les prix de vente au détail et effectue une analyse du pricing par thème. Elle calcule le prix minimum, médian, moyen et maximum pour chaque thème.
#'
#' @param df_prices Le dataframe contenant les prix de vente au détail.
#' @param theme_input Le thème pour lequel l'analyse du pricing doit être effectuée.
#' @return Un tableau interactif présentant l'analyse du pricing par thème.
#' @importFrom dplyr group_by summarise
#' @importFrom gt tab_header opt_align_table_header fmt_currency cols_label tab_style opt_interactive
#' @export
pricing_table <- function(df_prices, theme_input){
  return(
    df_prices |>
      group_by(theme) |>
      summarise(
        min = min(retail_price),
        median = median(retail_price),
        mean = mean(retail_price),
        max = max(retail_price)
      ) |>
      gt() |>
      tab_header(
        title = md("💰 **Analyse du pricing par thème.**"),
      ) |>
      opt_align_table_header(align = "center") |>
      fmt_currency(
        currency = "euro",
        placement = "right",
        incl_space = TRUE
      ) |>
      cols_label(
        theme = html(fontawesome::fa("empire"), "Thème"),
        min = "Prix Minimum",
        median = "Prix Médian",
        mean = "Prix Moyen",
        max = "Prix Maximum"
      ) |>
      tab_style(
        locations = cells_body(columns = theme),
        style = cell_text(weight = "bold")
      ) |>
      opt_interactive(
        use_filters = TRUE,
        use_compact_mode = TRUE,
        use_text_wrapping = FALSE
      )
  )
}
