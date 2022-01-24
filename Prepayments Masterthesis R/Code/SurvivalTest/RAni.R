library(survival)
mydata <- read.csv("survival_unemployment.csv")
attach(mydata)

# Define variables

time <- spell
event <- event
x<- cbind(logwage,ui,age)
group <-ui

# descriptive statistics
summary(time)
summary(event)
summary(x)
summary(group)

#1. KPM statistics
kmsurvival <- survfit(Surv(time,event)~1)
summary(kmsurvival)
plot(kmsurvival, xlab="time", ylab="cum. Survival Prob.")

#1.1 Grouped KPM
kmsurvgroup <- survfit(Surv(time,event)~group)
summary(kmsurvgroup)
plot(kmsurvgroup, xlab="time", ylab="cum. Survival Prob.")

#2. CPH
cph <- coxph(Surv(time,event)~x)
summary(cph)

