top_10_lineplot <- function(df_prices, themes){
  return(
    df_prices |>
           filter(theme %in% themes) |>
           group_by(year, theme) |> 
           summarise(
             number_of_sets = n()
           ) |> 
           plot_ly(
             x = ~year,
             y = ~number_of_sets, 
             color = ~theme,
             type = "scatter",
             mode = "line",
             #line = list(shape = 'spline', smoothing = 1.3),
             hovertemplate = paste(
               "<b>Année</b> : %{x}",
               "<br><b>Nombre de Sets</b> : %{y}"
             )
           ) |>
           layout(
             hovermode = "x",
             hoverlabel = list(
               bordercolor = "lightgrey", # Couleur de la bordure du tooltip
               font = list(family = "PT Sans", color = 'white')
             ),
             font = list(family = "PT Sans"),
             xaxis = list(
               title = "",
               zeroline = FALSE
               ),
             yaxis = list(title = "", zeroline = FALSE),
             showlegend = TRUE,
             legend = list(
               orientation = "h",
               title=list(text="<b> Thème(s) : </b>")
              ),
             margin = list(l = 40, r = 40, b = 40, t = 40)
           ) |> 
      config(displayModeBar = FALSE)
  )
      #add_markers(frame = ~year, ids = ~number_of_sets) |> 
      #animation_opts(1000, easing = "elastic", redraw = FALSE) |> 
      #animation_button(
        #x = 1, xanchor = "right", y = 0, yanchor = "bottom"
    #)
}
