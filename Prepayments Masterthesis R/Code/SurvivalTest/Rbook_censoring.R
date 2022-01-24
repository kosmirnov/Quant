library(survival)

cancer <- read.table("cancer.txt",header=T)
attach(cancer)
names(cancer)


plot(survfit(Surv(death,status)~treatment),
     col=c(1:4),ylab="Surivorship",xlab="Time")

tapply(death[status==1],treatment[status==1],mean)
tapply(death[status==1],treatment[status==1],var)

model1 <- survreg(Surv(death,status)~treatment,dist="exponential")
summary(model1)

model2 <- survreg(Surv(death,status)~treatment)
summary(model2)

anova(model1,model2)

## Grouping together
treat2 <-treatment
levels(treat2)
levels(treat2)[1:2] <- "DrugsAB"


model3 <- survreg(Surv(death,status)~treat2)
anova(model2,model3)

levels(treat2)[2:3] <- "placeboC"
model4 <-survreg(Surv(death,status)~treat2)
anova(model3,model4)
summary(model4)

tapply(predict(model4,type="response"),treat2,mean)
tapply(death[status==1],treat2[status==1],mean)