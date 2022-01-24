#Diagnostics
url <- "http://socserv.mcmaster.ca/jfox/Books/Companion/data/Rossi.txt"

Rossi <- read.table(url,header=TRUE)

# run cox regression on significant parameters

mod.allison.4 <- coxph(Surv(week, arrest) ~ fin + age + prio, data=Rossi)

cox.zph(mod.allison.4) #strong evidence that age is non-proportional --> violates assumption
#plot it
par(mfrow=c(2, 2))
plot(cox.zph(mod.allison.4))
# Systematic departures from a horizontal line are indicative of non-proportional hazards. Like in age #
# build linear dependency between age and time
source("unfold.R")
Rossi.2 <- unfold(Rossi, time="week", event="arrest", cov=11:62, cov.names="employed")
mod.allison.5 <- coxph(Surv(start, stop, arrest.time) ~ fin + age + age:stop + prio, data=Rossi.2)
mod.allison.5
cox.zph(mod.allison.5)
#There is no evidence of non-proportional hazards for the remaining covariates.
# time effect on age is linearly decreasing


#1.2 Stratification...Classify:
library(car)
Rossi$age.cat <- recode(Rossi$age, " lo:19=1; 20:25=2; 26:30=3; 31:hi=4 ")
xtabs(~ age.cat, data=Rossi)
# Run startified regression. Covariate now drops out

mod.allison.6 <- coxph(Surv(week, arrest) ~ fin + prio + strata(age.cat), data=Rossi)
mod.allison.6
# no evidence of non-proportional hazards
cox.zph(mod.allison.6)

# check if individual observations infleunce the estimation
dfbeta <- residuals(mod.allison.4, type="dfbeta")
par(mfrow=c(2, 2))
for (j in 1:3)
{plot(dfbeta[, j], ylab=names(coef(mod.allison.4))[j])
  abline(h=0, lty=2)}
# looks good even tough age has some strange observations

# 3. Non Linearity#
# 3.1. check with martingale residuals
res <- residuals(mod.allison.4, type="martingale")
X <- as.matrix(Rossi[, c("age", "prio")]) # matrix of covariates


par(mfrow=c(2, 2))
 for (j in 1:2) { # residual plots
  plot(X[, j], res, xlab=c("age", "prio")[j], ylab="residuals")
  abline(h=0, lty=2)
  lines(lowess(X[, j], res, iter=0))
 }

b <- coef(mod.allison.4)[c(2,3)] # regression coefficients
for (j in 1:2) { # component-plus-residual plots
   plot(X[, j], b[j]*X[, j] + res, xlab=c("age", "prio")[j],
  ylab="component+residual")
  abline(lm(b[j]*X[, j] + res ~ X[, j]), lty=2)
  lines(lowess(X[, j], b[j]*X[, j] + res, iter=0))
   }