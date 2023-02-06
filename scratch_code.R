library(tidymodels)
library(ongoal)

# ------------------------------------------------------------------------------

source("_common.R")

tidymodels_prefer()
theme_set(theme_bw())

# ------------------------------------------------------------------------------

set.seed(1)
on_goal %>%
  filter(season == "20152016") %>%
  sample_n(500) %>%
  plot_rink(alpha = 3/4, cex = 2)

# ------------------------------------------------------------------------------

one_season <-
  on_goal %>%
  filter(season == "20152016")

one_season %>%
  ggplot(aes(x = game_time, y = abs(coord_x))) +
  geom_point(alpha = 1/5) +
  geom_smooth()

# one_season %>%
#   ggplot(aes(y = player)) +
#   geom_bar()

one_season %>%
  count(player) %>%
  arrange(desc(n))

one_season %>%
  count(player) %>%
  ggplot(aes(x = n)) +
  geom_histogram() +
  scale_x_log10()

one_season %>%
  mutate(rounded = round(distance)) %>%
  group_by(rounded) %>%
  summarize(prop = mean(on_goal == "yes"),
            n = n(),
            .groups = "drop") %>%
  ggplot(aes(x = rounded, y = prop, size = n)) +
  geom_point()

# ------------------------------------------------------------------------------

my_metrics <- metric_set(accuracy, roc_auc, f_meas)

ctrl <- control_resamples(save_pred = TRUE)
nhl_glm_splines <-
  nhl_wflow %>%
  fit_resamples(resamples = nhl_rs, control = ctrl, metrics = my_metrics)
nhl_glm_splines

# ------------------------------------------------------------------------------

library(doParallel)
cl <- makePSOCKcluster(parallel::detectCores(logical = FALSE))
registerDoParallel(cl)

# ------------------------------------------------------------------------------

parsnip_addin()









