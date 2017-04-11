data {
  int<lower=1> N;
  int l[N];
}
parameters {
  real<lower=0, upper=1> p;
}
model {
  p ~ uniform(0, 1);
  l ~ bernoulli(p);
}
