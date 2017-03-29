data {
  int<lower=1> N;
  int w[N];
}
parameters {
  real<lower=0, upper=1> p;
}
model {
  p ~ uniform(0, 1);
  w ~ bernoulli(p);
}
