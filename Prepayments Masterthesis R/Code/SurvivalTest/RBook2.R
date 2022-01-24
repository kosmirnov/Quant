seedlings <- read.table("seedlings.txt",header=T)

# Kaplan-Meyer parametric regression, no censoring

library(survival)
status <- 1*(death>0)

plot(survfit(Surv(death,status)~1),ylab="Survivorship",xlab="Weeks",col=4)

model <- survfit(Surv(death,status)~cohort)
summary(model)

#use COXPH

model1 <- coxph(Surv(death,status)~strata(cohort)*gapsize)
summary(model1)

model2 <- coxph(Surv(death,status)~strata(cohort)+gapsize)
summary(model2)

anova(model1,model2)

rm(status)
detach(seedlings)
# Parametric vs. non-parametric

cancer <- read.table("cancer.txt",header=T)
attach(cancer)
names(cancer)

