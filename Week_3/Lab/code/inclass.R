set.seed(1)
pop <- rgamma(10000,1,0.1)
hist(pop)

ss <- 100
##samp <- sample(pop,ss)
##xbar <- mean(samp)

M <- 1000
xbars <- numeric(M)
for(i in 1:M) {
  samp <- sample(pop,ss)
  xbars[i] <- mean(samp)
  
}
hist(xbars)

mean(xbars) ## E(xbar)
mean(pop) ## mu

sd(xbars) ## SD(xbar)
sd(pop)/sqrt(ss) ## sigma/sqrt(n)
