library("abcrf")    # for ABC with random forests


model1 <- "1population"
model2 <- "2populations1"
model3 <- "2populations2"
model4 <- "3populations"
model5 <- "Admixture2events"
model6 <- "Wild2samples"

load(file=paste0("results/reftable_",model1,".RData"))
reftable_model1 <- reftable
load(file=paste0("results/reftable_",model2,".RData"))
reftable_model2 <- reftable
load(file=paste0("results/reftable_",model3,".RData"))
reftable_model3 <- reftable
load(file=paste0("results/reftable_",model4,".RData"))
reftable_model4 <- reftable
load(file=paste0("results/reftable_",model5,".RData"))
reftable_model5 <- reftable
load(file=paste0("results/reftable_",model6,".RData"))
reftable_model6 <- reftable

sims_per_scenario <- 60000

reftable_stats <- rbind(reftable_model1[1:sims_per_scenario,t(stats_names)],
                        reftable_model2[1:sims_per_scenario,t(stats_names)],
                        reftable_model3[1:sims_per_scenario,t(stats_names)],
                        reftable_model4[1:sims_per_scenario,t(stats_names)],
                        reftable_model5[1:sims_per_scenario,t(stats_names)],
                        reftable_model6[1:sims_per_scenario,t(stats_names)])

modelindex <- as.factor(c(rep.int(1,sims_per_scenario),
                          rep.int(2,sims_per_scenario),
                          rep.int(3,sims_per_scenario),
                          rep.int(4,sims_per_scenario),
                          rep.int(5,sims_per_scenario),
                          rep.int(6,sims_per_scenario)))

statsobs <- read.table("results/statobs.txt",header=T)

rm(reftable_model1,reftable_model2,reftable_model3,
   reftable_model4,reftable_model5,reftable_model6)
gc()

dim(reftable_stats)

model.rf <- abcrf(modelindex~.,
                  data.frame(modelindex,reftable_stats),
                  ntree=800,
                  paral=T)

model.rf$prior.err

gc()

plot(model.rf,
     data.frame(modelindex,reftable_stats),
     obs=statsobs)

err.abcrf(model.rf,
          training=data.frame(modelindex,reftable_stats),
          paral=T)

model_selection_result <- predict(object         = model.rf,
                                  obs            = rbind(statsobs,statsobs),
                                  training       = data.frame(modelindex,reftable_stats),
                                  ntree          = 800,
                                  paral          = T,
                                  paral.predict  = T)
(model_selection_result)


gc()

save(model.rf,
     model_selection_result,
     file="results/AntofagastaModelChoice3.RData")
load(file="results/AntofagastaModelChoice3.RData")
