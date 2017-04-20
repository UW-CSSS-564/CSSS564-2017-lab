data {
  int<lower=1> N;
  vector[N] l_gdp;
  vector[N] rugged;
}
parameters {
  vector[2] beta;
  real<lower=0> sigma;
}
model {
  beta[1] ~ normal(8, 100);
  beta[2] ~ normal(0, 1);
  sigma ~ uniform(0, 10);
  l_gdp ~ normal(beta[1] + beta[2] * rugged, sigma);
}
