#' Crée un graphique interactif représentant les prix d'un ensemble sous forme de lollipop.
#'
#' Cette fonction prend un dataframe contenant les informations sur les ensembles et crée un graphique interactif représentant les différents prix (prix de détail, prix actuel pour une boîte ouverte, prix actuel pour une boîte scellée) d'un ensemble spécifique, identifié par son numéro de set.
#'
#' @param df_prices Le dataframe contenant les informations sur les ensembles.
#' @param input_set_number Le numéro de set pour lequel générer le graphique.
#' @return Un graphique interactif représentant les prix de l'ensemble spécifié.
#' @importFrom ggplot2 ggplot geom_segment geom_point theme_minimal scale_x_discrete scale_y_continuous aes labs
#' @export
set_prices_lollipops <- function(df_prices, input_set_number) {
  df_lollipops <- df_prices |>
    filter(set_number == input_set_number) |>
    select(retail_price, value_used, value_new) |>
    tidyr::pivot_longer(
      c(retail_price, value_used, value_new),
      names_to = "price_types",
      values_to = "price_values"
    )
  ggplot_lollipops <- ggplot(df_lollipops,
                             aes(
                               x = factor(price_types,
                                          c(
                                            "retail_price", "value_used", "value_new"
                                          )),
                               y = price_values,
                               text = paste("<b>Prix : </b>", price_values, "€")
                             )) +
    geom_segment(
      aes(
        x = price_types,
        xend = price_types,
        y = 0,
        yend = price_values
      ),
      color = "gray",
      linetype = "dashed"
    ) +
    geom_point(color = "#DA291C", size = 3) +
    theme_minimal() +
    labs(x = "", y = "") +
    scale_x_discrete(
      labels = c(
        "Prix de détail",
        "Prix actuel \n(boite ouverte)",
        "Prix actuel \n(boite scellée)"
      )
    ) +
    scale_y_continuous(labels = scales::dollar_format(suffix = " €", prefix = ""))
  return(
    ggplotly(ggplot_lollipops, tooltip = "text") |>
      layout(
        yaxis = list(title = ""),
        xaxis = list(title = "", zeroline = FALSE),
        font = list(family = "PT Sans"),
        hoverlabel = list(
          bordercolor = "lightgrey",
          # Couleur de la bordure du tooltip
          font = list(family = "PT Sans", color = "white")
        ),
        margin = list(
          l = 40,
          r = 40,
          b = 40,
          t = 40
        )
      ) |>
      style(hoverinfo = "none", traces = 1) |>
      config(displayModeBar = FALSE)
  )
}
