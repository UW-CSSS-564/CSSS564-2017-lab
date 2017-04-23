# Sheridan Grant
# STAT 564 Stan Practice

# Package Handling (you read the comments; I reward you with a shitty pun)
packages <- c('rstan')
installed <- rownames(installed.packages())
for (i in length(packages)) {
  if ((packages[i] %in% installed) == FALSE) {
    install.packages(packages[i])
  }
}
lapply(packages, require, character.only = TRUE)

rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

schools_dat <- list(J = 8, 
                    y = c(28,  8, -3,  7, -1,  1, 18, 12),
                    sigma = c(15, 10, 16, 11,  9, 11, 10, 18))

fit <- stan(file = '8schools.stan', data = schools_dat, 
            iter = 1000, chains = 4)

# model <- stan_demo()