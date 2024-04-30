#' Trace un graphique montrant l'évolution du nombre de sets par année et par catégorie.
#'
#' Cette fonction trace un graphique en ligne montrant l'évolution du nombre de sets par année et par catégorie.
#'
#' @param df_prices Le dataframe contenant les données sur les prix des sets.
#' @return Un graphique en ligne montrant l'évolution du nombre de sets par année et par catégorie.
#' @export
#'
#' @importFrom dplyr group_by summarise mutate
#' @importFrom plotly plot_ly add_trace layout config
year_sets_plot <- function(df_prices) {
  return(
    df_prices |>
      group_by(year, category) |>
      summarise(nb_sets = n()) |>
      plot_ly(
        x = ~ year,
        y = ~ nb_sets,
        color = ~ category,
        type = "scatter",
        mode = "line",
        hovertemplate = paste("<b>Année</b> : %{x}",
                              "<br><b>Nombre de sets</b> : %{y}")
      ) |>
      layout(
        hovermode = "x",
        hoverlabel = list(
          bordercolor = "lightgrey",
          # Couleur de la bordure du tooltip
          font = list(family = "PT Sans", color = 'white')
        ),
        font = list(family = "PT Sans"),
        xaxis = list(title = "",
                     zeroline = FALSE),
        yaxis = list(title = "", zeroline = FALSE),
        showlegend = TRUE,
        legend = list(
          orientation = "h",
          title = list(text = "<b> Catégorie(s) : </b>")
        ),
        margin = list(
          l = 40,
          r = 40,
          b = 40,
          t = 40
        )
      ) |>
      config(displayModeBar = FALSE) |>
      add_trace(
        data = df_prices |>
          mutate(category = "Total") |>
          group_by(year, category) |>
          summarise(nb_sets = n()),
        x = ~ year,
        y = ~ nb_sets
      )
  )
}
