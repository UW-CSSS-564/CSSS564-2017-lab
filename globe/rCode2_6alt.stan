data {
  int<lower=1> N;
  int l;
}
parameters {
  real<lower=0, upper=1> p;
}
model {
  p ~ uniform(0, 1);
  l ~ binomial(N, p);
}
