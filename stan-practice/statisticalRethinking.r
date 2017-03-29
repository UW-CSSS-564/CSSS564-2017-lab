# Sheridan Grant
# STAT 564 Stan Practice

# Package Handling (you read the comments; I reward you with a shitty pun)
packages <- c('rethinking', 'rstan')
installed <- rownames(installed.packages())
for (i in length(packages)) {
  if ((packages[i] %in% installed) == FALSE) {
    install.packages(packages[i])
  }
}
lapply(packages, require, character.only = TRUE)

rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

# 2.6
globe.qa <- map(
  alist(
    w ~ dbinom(9, p),
    p ~ dunif(0,1)
  ),
  data = list(w = 6)
)

precis (globe.qa)

water_dat <- list(N = 9,
                  w = c(1,0,1,1,0,1,1,0,1))

fit <- stan(file = 'rCode2_6.stan', data = water_dat, 
            iter = 1000, chains = 4)