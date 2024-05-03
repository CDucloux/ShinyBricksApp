# 🧱 ShinyBricks

> **ShinyBricks** est une plateforme d'analyse *LEGO* qui permet d'étudier les prix de sets *LEGO* à leur sortie, leur prix actuel, l'évolution des thèmes, des informations sur les licences, etc.

<p align="center" width="100%">
  <a href="https://corentin-ducloux.shinyapps.io/ShinyBricks/">
    <img src="imgs/shinybricks.png" width="40%" height="40%">
  </a>
</p>


## La collecte des données : 


|                                                  | Source                                       | Méthode    | Données récoltées |
|--------------------------------------------------|----------------------------------------------|------------|-------------------|
| [<img src="imgs/brickset_logo.jpg" width="40" height="40">](https://brickset.com/)         | [Brickset](https://brickset.com/)            | `API`      | Informations sur tous les sets |
| [<img src="imgs/brickeconomy_logo.jpeg" width="40" height="40">](https://www.brickeconomy.com) | [Brickeconomy](https://www.brickeconomy.com) | `Scraping` | Prix actuel des sets |


La récupération des données s'est faite en deux temps : 
- Grâce au *wrapper* sur **R** développé par [Jason Bryer](https://github.com/jbryer/brickset), l'utilisation de l'API de **Brickset** est très intuitive. Il suffit d'appeler `brickset::getSets(year)` pour récupérer l'ensemble des sets d'une année spécifique. Nous l'avons fait pour les sets de l'année 1994 à 2024, soit *30 ans de briques* !
- À l'aide du numéro de set et du package [`httr2`](https://httr2.r-lib.org/), nous avons réussi à scraper le site **Brickeconomy** et ainsi récupérer les prix actuels (neuf/occasion) de chaque set LEGO®, une information clé pour notre application.

Les données extraites sont stockés sous format *.parquet* 🧱 et *.feather* 🪶 et ont donc l'avantage d'être très légères.


## Application

**ShinyBricks** a été créée avec [`shiny`](https://shiny.posit.co/) et [`bslib`](https://rstudio.github.io/bslib/) ce qui nous a permis de lui donner une interface utilisateur **(UI)** moderne.

Elle est accessible en cliquant [ici](https://corentin-ducloux.shinyapps.io/ShinyBricks/) ou sur le logo ci-dessus !

Pour ce qui est du contenu de l'application, les graphiques ont été réalisés avec [`plotly`](https://plotly.com/r/) et les tableaux avec [`gt`](https://gt.rstudio.com/).

**ShinyBricks** contient plusieurs onglets et de nombreuses fonctionnalités :
  - Une analyse par thème
  - Une analyse par an
  - Une analyse par set (caractéristiques, vue 3D, notices, avis...)
  - Un aperçu des stratégies de pricing adoptées

<details>
    <summary> 🎬 Démonstration </summary>
    <hr>
    <img 
        src="imgs/ShinyBricksAppDemo.gif"
        width="100%" 
        height="100%">
</details>

## Installation

Pour cloner le repo en premier lieu :

``` bash
git clone "https://github.com/CDucloux/ShinyBricksApp.git"
```

Puis dans votre console **R**:

``` r
shiny::runApp()
```

Ou directement depuis le terminal :

```shell
cd ~/ShinyBricksApp
Rscript.exe app.R
```

ou 

```shell
cd ~/ShinyBricksApp
Rscript app.R
```
