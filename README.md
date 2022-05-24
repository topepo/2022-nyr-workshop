# 2022-nyr-workshop

License: Attribution-NonCommercial-ShareAlike 4.0 International

This repository contains code and notes for the tidymodels workshop.

To get the packages, use:

```r
install.packages(c("tidymodels", "shinymodels", "xgboost", "glmnet", "embed", "remotes"))

# For the data:
remotes::install_github("topepo/ongoal")
```

You should also have the RStudio IDE installed. 

## Slides

* [*Introduction*](https://topepo.github.io/2022-nyr-workshop/1-introduction.html) - why tidymodels? example data, tidyverse review.

* [*Models*](https://topepo.github.io/2022-nyr-workshop/2-models.html) - what is the model?, data splitting, basic R models, parsnip introduction, some broom.

* [*Feature engineering*](https://topepo.github.io/2022-nyr-workshop/3-features.html) - recipes introduction, 

* [*Resampling*](https://topepo.github.io/2022-nyr-workshop/4-resampling.html) - why resample, cross-validation, `fit_resamples()`, shinymodels.

* [*Model tuning*](https://topepo.github.io/2022-nyr-workshop/5-tuning.html) - tuning parameters, grids, grid search, glmnet, boosting, parallel processing, test set evaluation. 
