#' Trace un graphique à barres pour le nombre de sets par année.
#'
#' Cette fonction trace un graphique à barres montrant le nombre total de sets pour chaque année spécifiée.
#'
#' @param df_prices Le dataframe contenant les données sur les prix des sets.
#' @param years Vecteur contenant les années à inclure dans le graphique. Par défaut, toutes les années de 2014 à 2024 sont incluses.
#' @return Un graphique à barres montrant le nombre total de sets pour chaque année spécifiée.
#' @export
#'
#' @importFrom dplyr group_by filter summarise arrange
#' @importFrom plotly plot_ly layout config
year_barchart <- function(df_prices, years = 2014:2024) {
  return(
    df_prices |>
      group_by(year) |>
      filter(year %in% years) |>
      summarise(number_of_sets = n()) |>
      arrange(desc(year)) |>
      plot_ly(
        x = ~ as.factor(year),
        y = ~ number_of_sets,
        alpha = 0.85,
        type = "bar",
        marker = list(color = "#DA291C", opacity = 0.85),
        hovertemplate = paste(
          "<b>Année</b> : %{x}",
          "<br><b>Nombre total de sets</b> : %{y}",
          "<extra></extra>"
        )
      ) |>
      layout(
        yaxis = list(
          title = "",
          ticksuffix = "  ",
          zeroline = FALSE
        ),
        xaxis = list(title = "", zeroline = FALSE),
        font = list(family = "PT Sans"),
        hoverlabel = list(
          bordercolor = "lightgrey",
          # Couleur de la bordure du tooltip
          font = list(family = "PT Sans", color = 'white')
        ),
        margin = list(
          l = 40,
          r = 40,
          b = 40,
          t = 40
        )
      ) |>
      config(displayModeBar = FALSE)
  )
}
