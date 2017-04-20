# Sheridan Grant
# STAT 564 Ch 7

# Working Directory
setwd("~/Code/UW/stat-564/stat-564-2017/stan-practice")

# Package Handling (you read the comments; I reward you with a shitty pun)
packages <- c('rstan', 'rethinking')
if (length(packages) > 0) {
  installed <- rownames(installed.packages())
  for (i in 1:length(packages)) {
    if ((packages[i] %in% installed) == FALSE) {
      install.packages(packages[i])
    }
  }
  lapply(packages, require, character.only = TRUE)
}

# Global Options
options(digits=3)
par(mfrow=c(1,1))


data(rugged)
d <- rugged[complete.cases(rugged$rgdppc_2000),]
hist(d$rgdppc_2000) # Massive right skew
d$log_gdp <- log(d$rgdppc_2000) # Positive variables tend to need logging to deal with that right skew

d.A1 <- d[d$cont_africa == 1,] # Africa
d.A0 <- d[d$cont_africa == 0,] # Not Africa

# Fitting separate models
A1_dat <- list(N = dim(d.A1)[1], l_gdp = d.A1$log_gdp, rugged = d.A1$rugged)
fit.A1 <- stan(file = 'africa.stan', data = A1_dat, iter = 1000, chains = 2)
print(fit.A1)

plot(fit.A1)
plot(As.mcmc.list(fit.A1, pars = "beta"))
pairs(fit.A1, pars = 'beta')

A0_dat <- list(N = dim(d.A0)[1], l_gdp = d.A0$log_gdp, rugged = d.A0$rugged)
fit.A0 <- stan(file = 'africa.stan', data = A0_dat, iter = 1000, chains = 2)
print(fit.A0)

# Interaction term
inter_dat <- list(N = dim(d)[1], l_gdp = d$log_gdp, rugged = d$rugged, africa = d$cont_africa)
fit.inter <- stan(file = 'africa2.stan', data = inter_dat, iter = 1000, chains = 2)
print(fit.inter)
plot(fit.inter, show_density = TRUE, ci_level = 0.95, fill_color = "purple")
stan_hist(fit.inter)
