# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file
#remotes::install_version("rsconnect", "0.8.29")
# Note : la version 0.8.29 est nécessaire pour déployer
# renv déconne, je ne comprends pas pourquoi.

install.packages("pkgload", repos = "http://cran.us.r-project.org")

library(pkgload)

pkgload::load_all(export_all = FALSE,helpers = FALSE,attach_testthat = FALSE)
options( "golem.app.prod" = TRUE)
ShinyBricks::run_app() # add parameters here (if any)
