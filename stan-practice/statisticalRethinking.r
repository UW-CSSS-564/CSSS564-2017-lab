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

setwd("C:/Users/Sheridan/Desktop/Code/UW/stat-564/stat-564-2017/stan-practice")

# 2.6

############################################################

globe.qa <- map(
  alist(
    l ~ dbinom(9, p),
    p ~ dunif(0,1)
  ),
  data = list(l = 3)
)

precis(globe.qa)

###########################################################

# Stan

# Bernoulli
water_dat <- list(N = 9,
                  l = c(1,0,1,1,0,1,1,0,1))

fit <- stan(file = 'rCode2_6.stan', data = water_dat, 
            iter = 1000, chains = 1)


# Binomial
water_dat_alt <- list(N = 9,
                      l = 3)

fit_alt <- stan(file = 'rCode2_6alt.stan', data = water_dat_alt,
                iter = 1000, chains = 4)