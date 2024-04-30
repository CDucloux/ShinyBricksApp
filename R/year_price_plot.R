#' Trace un graphique en ligne montrant l'évolution du prix de vente moyen des sets au fil des années.
#'
#' Cette fonction trace un graphique en ligne montrant l'évolution du prix de vente moyen des sets pour chaque année, en fonction de la catégorie.
#'
#' @param df_prices Le dataframe contenant les données sur les prix des sets.
#' @return Un graphique en ligne montrant l'évolution du prix de vente moyen des sets pour chaque année, en fonction de la catégorie.
#' @export
#'
#' @importFrom dplyr filter group_by summarise mutate
#' @importFrom plotly plot_ly layout config add_trace
#' @importFrom glue glue
year_price_plot <- function(df_prices) {
  return(
    df_prices |>
      group_by(year, category) |>
      summarise(retail_price = mean(retail_price, na.rm = T)) |>
      plot_ly(
        x = ~ year,
        y = ~ retail_price,
        color = ~ category,
        type = "scatter",
        mode = "line",
        hovertemplate = paste(
          "<b>Année</b> : %{x}",
          "<br><b>Prix de vente moyen des sets</b> : %{y}"
        )
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
          summarise(mean_total_retail_price = mean(retail_price, na.rm = T)),
        x = ~ year,
        y = ~ mean_total_retail_price
      )
  )
}
