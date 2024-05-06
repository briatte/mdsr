# `>` More Data Science with R

> [François Briatte](https://f.briatte.org/)  
> Spring 2024. __Work VERY MUCH in progress.__

A follow-up to an [introduction to data science][dsr] with [R][r], [RStudio][rstudio], and the [`{tidyverse}`][tidyverse] packages, still aimed at social scientists. This course requires some prior training in introductory statistics and regression modelling.

[dsr]: https://github.com/briatte/dsr
[r]: https://www.r-project.org/
[rstudio]: https://posit.co/products/open-source/rstudio/
[tidyverse]: https://www.tidyverse.org/

__N.B.__ -- the current repo does not include the full set of datasets used during the semester, which are all publicly available. Future versions will include the full data and slides.

## 1. Software

- R and RStudio
- R Markdown notebooks
- Code execution

A session to get started again with R and RStudio, this time through __R Markdown notebooks__, which are dynamic documents that can combine text and images with code as well as plots and other kinds of results.

`>` Demo: __[LGBTI inclusivity in OECD countries][d1]__

[d1]: https://github.com/briatte/mdsr/tree/master/mdsr-01-software

## 2. Revisions

- The `tidyverse` package bundle
- More R Markdown
- Data pivots

A general-revisions session that covers data wrangling and visualization with various packages of the `tidyverse` bundle. Now is the right time to take a look at cheatsheets and similar material.

`>` Demo: __[U.S. life expectancy][d2]__ (code by Kieran Healy)

[d2]: https://github.com/briatte/mdsr/tree/master/mdsr-02-revisions

## 3. SQL databases

- Row-wise operations and complex joins with `dplyr`
- SQL databases with `dbplyr`
- Regular expressions (regex) with `stringr`

A session focused on advanced data wrangling. __SQL databases__, in particular, is what you will need when in need for speed and/or out-of-memory calculation on very (possibly _very very_) large data.

`>` Demo: __[Government cabinet composition][d3]__ (ParlGov data, code by Holger Döring)

[d3]: https://github.com/briatte/mdsr/tree/master/mdsr-03-databases

## 4. Web scraping

- HTTP with `httr`
- XPath with `rvest` and `xml2`
- API endpoints

Another session focused on advanced data wrangling. __Web scraping__ is what you will need if your data are trapped online into Web pages.

`>` Demo: __[Locating nuclear reactors worldwide][d4]__ (data from the IAEA)

[d4]: https://github.com/briatte/mdsr/tree/master/mdsr-04-web-scraping

## 5. Linear models

- Model estimation and manipulation with `broom`
- Linear diagnostics with `performance`

Mostly revisions of what was covered in the [introductory course][dsr].

`>` Demo: __[Worldwide fertility rates][d5]__ (QOG/World Bank data)

[d5]: https://github.com/briatte/mdsr/tree/master/mdsr-05-linear-models

## 6. Panel data

- Panel data structure
- Fixed-effects estimation with `fixest` and `plm`
- Cluster-robust standard errors (CRSEs)

`>` Demo: __[Worldwide fertility rates][d5]__ (QOG/World Bank data)

[d6]: https://github.com/briatte/mdsr/tree/master/mdsr-06-panel-data

## 7. Survey data

- Survey weighting
- Survey-weighted operations with `survey` and `srvyr`
- Generalized linear models (GLMs)

`>` Demo: __[EU skepticism and migration][d7]__ (ESS data, code by Holger Döring)

[d7]: https://github.com/briatte/mdsr/tree/master/mdsr-07-survey-data

## 8. Feedback

Feedback on your first drafts, and recommendations for the coming weeks.

## 9. Multilevel data

- Multilevel (hierarchical) data
- Multilevel (mixed) model estimation with `lme4`

`>` Demo: __[EU skepticism and migration, continued][d9]__ (ESS data, code by Holger Döring)

[d9]: https://github.com/briatte/mdsr/tree/master/mdsr-09-multilevel-data

## 10. Machine learning in R

- Machine learning essentials
- Decision trees and random forests
- The `tidymodels` package bundle

`>` Demo: __[White Trump voters][d7]__ (CCES data, code by Steven Miller)

[d10]: https://github.com/briatte/mdsr/tree/master/mdsr-10-machine-learning

## 11. Machine learning in Python

- Jupyter notebooks and Google Colab
- Text mining basics
- Example algorhithms from the `scikit-learn` library

`>` Demo: __[Trump tweets][d11]__ (Twitter data, code by Bernhard Rieder)

[d11]: https://github.com/briatte/mdsr/tree/master/mdsr-11-python

## 12. Dashboards

- The `flexdashboard` package
- Maps with `sf` and Leaflet
- General wrap-up

`>` Demo: __[Worldwide air pollution][d12]__ (World Bank data, code by Paul Moraga)

[d12]: https://github.com/briatte/mdsr/tree/master/mdsr-12-dashboards

---

# Packages

```r
pkg_data <- c("countrycode", "rsdmx", "RSQLite", "sf", "tidyverse")
# ... also installs {DBI} and {rvest}, inter alia
pkg_models <- c("easystats", "lme4", "plm", "fixest", "tidymodels")
# ... installs a lot of essentials, such as {performance}
pkg_tables <- c("broom", "broom.mixed", "DT", "modelsummary", "texreg")
pkg_varia <- c("flexdashboard", "leaflet")

# install.packages("remotes")
for (i in c(pkg_data, pkg_models, pkg_tables, pkg_varia)) {
  remotes::install_cran(i)
}
```
