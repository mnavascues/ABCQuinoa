library("abcrf")    # for ABC with random forests


model1 <- "1population"
model2 <- "2populations1"
model3 <- "2populations2"
model4 <- "3populations"


load(file=paste0("results/reftable_",model1,".RData"))
reftable_model1 <- reftable
load(file=paste0("results/reftable_",model2,".RData"))
reftable_model2 <- reftable
load(file=paste0("results/reftable_",model3,".RData"))
reftable_model3 <- reftable
load(file=paste0("results/reftable_",model4,".RData"))
reftable_model4 <- reftable

sims_per_scenario <- 100000

reftable_stats <- rbind(reftable_model1[1:sims_per_scenario,t(stats_names)],
                        reftable_model2[1:sims_per_scenario,t(stats_names)],
                        reftable_model3[1:sims_per_scenario,t(stats_names)],
                        reftable_model4[1:sims_per_scenario,t(stats_names)])

modelindex <- as.factor(c(rep.int(1,sims_per_scenario),
                          rep.int(2,sims_per_scenario),
                          rep.int(3,sims_per_scenario),
                          rep.int(4,sims_per_scenario)))

statsobs <- read.table("results/statobs.txt",header=T)

rm(reftable_model1,reftable_model2,reftable_model3,
   reftable_model4)
gc()

dim(reftable_stats)

model.rf <- abcrf(modelindex~.,
                  data.frame(modelindex,reftable_stats),
                  ntree=1000,
                  paral=T)

model.rf$prior.err

plot(model.rf,
     data.frame(modelindex,reftable_stats),
     obs=statsobs)

err.abcrf(model.rf,
          training=data.frame(modelindex,reftable_stats),
          paral=T)

model_selection_result <- predict(object         = model.rf,
                                  obs            = rbind(statsobs,statsobs),
                                  training       = data.frame(modelindex,reftable_stats),
                                  ntree          = 1000,
                                  paral          = T,
                                  paral.predict  = T)
(model_selection_result)


save(model.rf,
     model_selection_result,
     file="results/AntofagastaModelChoice1.RData")
load(file="results/AntofagastaModelChoice1.RData")
