#' Trace un graphique en ligne pour les dix thèmes les plus populaires au fil des années.
#'
#' Cette fonction trace un graphique en ligne montrant l'évolution du nombre de sets pour les dix thèmes les plus populaires au fil des années.
#'
#' @param df_prices Le dataframe contenant les données sur les prix des sets.
#' @param themes Un vecteur contenant les noms des thèmes à inclure dans le graphique.
#' @return Un graphique en ligne montrant l'évolution du nombre de sets pour les thèmes sélectionnés.
#' @export
#'
#' @importFrom dplyr filter group_by summarise
#' @importFrom plotly plot_ly layout config
top_10_lineplot <- function(df_prices, themes) {
  return(
    df_prices |>
      filter(theme %in% themes) |>
      group_by(year, theme) |>
      summarise(number_of_sets = n()) |>
      plot_ly(
        x = ~ year,
        y = ~ number_of_sets,
        color = ~ theme,
        type = "scatter",
        mode = "line",
        hovertemplate = paste("<b>Année</b> : %{x}",
                              "<br><b>Nombre de Sets</b> : %{y}")
      ) |>
      layout(
        hovermode = "x",
        hoverlabel = list(
          bordercolor = "lightgrey",
          font = list(family = "PT Sans", color = 'white')
        ),
        font = list(family = "PT Sans"),
        xaxis = list(title = "", zeroline = FALSE),
        yaxis = list(title = "", zeroline = FALSE),
        showlegend = TRUE,
        legend = list(
          orientation = "h",
          title = list(text = "<b> Thème(s) : </b>")
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
