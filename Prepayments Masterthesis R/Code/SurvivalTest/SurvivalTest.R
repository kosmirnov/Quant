url <- "http://socserv.mcmaster.ca/jfox/Books/Companion/data/Rossi.txt"

Rossi <- read.table(url,header=TRUE
                    )
# 1. CPH-Regression on Rossi Table with time-constant covariates

mod.allison <- coxph(Surv(week,arrest) ~ fin + age + race + wexp + mar + paro + prio, Rossi)
summary(mod.allison)

plot(survfit(mod.allison), ylim=c(0.7,1), xlab="WEEKS", ylab="Proportion not rearrested" )

Rossi.fin <- with(Rossi, data.frame(fin=c(0, 1), age=rep(mean(age),2),race=rep(mean(race == "other"), 2),
                wexp=rep(mean(wexp == "yes"), 2), mar=rep(mean(mar == "not married"), 2),
                paro=rep(mean(paro == "yes"), 2), prio=rep(mean(prio), 2)))

plot(survfit(mod.allison, Rossi.fin), conf.int=TRUE,
     lty=c(1, 2), ylim=c(0.6, 1), xlab="Weeks",
     ylab="Proportion Not Rearrested")
legend("bottomleft", legend=c("fin = no", "fin = yes"), lty=c(1 ,2), inset=0.02)


# 2. Time Dependencies: Unfold the data from wide to long

source("unfold.R")
Rossi.2 <- unfold(Rossi, time="week", event="arrest", cov=11:62, cov.names="employed")

mod.allison.2 <- coxph(Surv(start, stop, arrest.time) ~
                        fin + age + race + wexp + mar + paro + prio + employed,
                        data=Rossi.2)
                       
summary(mod.allison.2)

# 3. Use lagged employment rates due to causality jail = no work anyways 
Rossi.3 <- unfold(Rossi, "week", "arrest", 11:62, "employed", lag=1)

mod.allison.3 <- coxph(Surv(start, stop, arrest.time) ~
                         fin + age + race + wexp + mar + paro + prio + employed,
                       data=Rossi.3)

summary(mod.allison.3)