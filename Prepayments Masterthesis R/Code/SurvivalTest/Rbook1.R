# Rbook Survival 1. Chapter: MC Simulation

rnos <- runif(100) # creat uniform distribution

which(rnos<=.1)[1]

death1 <-numeric(30)
for (i in 1:30){
  rnos <- runif(100) # creat uniform distribution
  death1[i] <- which(rnos<=.1)[1]
}
death1

1/mean(death1)

death2 <-numeric(30)
for (i in 1:30){
  rnos <- runif(100) # creat uniform distribution
  death2[i] <- which(rnos<=.2)[1]
}
death2

1/mean(death2)

death <- c(death1,death2)
factory <- factor(c(rep(1,30),rep(2,30)))
plot(factory,death,xlab="factory",ylab="age at failure",col="wheat3")


