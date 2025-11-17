pop <- rgamma(10000,1,0.1)

xbar <- NULL
for(i in 1:10000) {
  my_sample <- sample(pop,50)
  xbar <- c(xbar,mean(my_sample))
}
hist(xbar)

