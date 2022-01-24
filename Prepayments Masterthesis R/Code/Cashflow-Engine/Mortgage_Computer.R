
setwd("C:/Users/Kons/OneDrive/MASTERARBEIT/R/Cashflow-Engine")

vol <- 400000000
SMM <- 0.02
N <- 357
i=0.08125/12

ammo <- matrix(NA,N,4)

names <- c("Month","Outstanding Balance","SMM","Mortgage Payment")

colnames(ammo) <- names

ammo[1,1] <- 1
ammo[1,2] <- vol
ammo[1,3] <- SMM
ammo[1,4] <- ammo[1,2]*(i*(1+i)^(N-ammo[1,1]+1))/((1+i)^(N-ammo[1,1]+1)-1)


