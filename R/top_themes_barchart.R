#' Trace un graphique à barres pour les thèmes les plus populaires.
#'
#' Cette fonction trace un graphique à barres montrant le nombre total de sets pour les thèmes sélectionnés.
#'
#' @param df_prices Le dataframe contenant les données sur les prix des sets.
#' @param themes Un vecteur contenant les noms des thèmes à inclure dans le graphique.
#' @return Un graphique à barres montrant le nombre total de sets pour les thèmes sélectionnés.
#' @export
#'
#' @importFrom dplyr filter group_by summarise arrange
#' @importFrom plotly plot_ly layout config
top_themes_barchart <- function(df_prices, themes) {
  return(
    df_prices |>
      filter(theme %in% themes) |>
      group_by(theme) |>
      summarise(number_of_sets = n()) |>
      arrange(desc(number_of_sets)) |>
      plot_ly(
        x = ~ number_of_sets,
        y = ~ theme,
        alpha = 0.85,
        type = "bar",
        marker = list(color = "#DA291C", opacity = 0.85),
        hovertemplate = paste(
          "<b>Thème</b> : %{y}",
          "<br><b>Nombre total de sets</b> : %{x}",
          "<extra></extra>"
        )
      ) |>
      layout(
        yaxis = list(
          title = "",
          categoryorder = "total ascending",
          ticksuffix = "  "
        ),
        xaxis = list(title = "", zeroline = FALSE),
        font = list(family = "PT Sans"),
        hoverlabel = list(
          bordercolor = "lightgrey",
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
