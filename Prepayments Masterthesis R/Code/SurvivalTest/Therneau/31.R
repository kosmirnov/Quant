## Therneau in R

pbc <- pbc

fit.pbc <- coxph(Surv(time,status==2)~age+edema+log(bili)+log(protime)+log(albumin), data=pbc)
summary(fit.pbc)

fit.pbcbili <- coxph(Surv(time,status==2)~log(bili),pbc)
summary(fit.pbcbili)

# Does the model acutally fit?

group <- 1*(pbc$bili>1.1)+1*(pbc$bili >3.3)
cfit <- survfit(Surv(time, status==2)~group, data=pbc)
plot(cfit, mark.time = F, fun="cloglog")# clog survival data

