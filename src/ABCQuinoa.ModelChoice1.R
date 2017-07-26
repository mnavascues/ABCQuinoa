library("abcrf")    # for ABC with random forests

model1 <- "Model_1pop"
model2 <- "Model_2pop"
model3 <- "Model_3pop_topo1"
model4 <- "Model_3pop_topo2"
model5 <- "Model_3pop_topo3"
model6 <- "Model_Admix1_topo1"
model7 <- "Model_Admix1_topo2"
model8 <- "Model-Admix1_topo3"

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
load(file=paste0("results/reftable_",model7,".RData"))
reftable_model7 <- reftable
load(file=paste0("results/reftable_",model8,".RData"))
reftable_model8 <- reftable


reftable_stats <- rbind(reftable_model1[1:9999,t(stats_names)],
                        reftable_model2[1:9999,t(stats_names)],
                        reftable_model3[1:3333,t(stats_names)],
                        reftable_model4[1:3333,t(stats_names)],
                        reftable_model5[1:3333,t(stats_names)],
                        reftable_model6[1:3333,t(stats_names)],
                        reftable_model7[1:3333,t(stats_names)],
                        reftable_model8[1:3333,t(stats_names)])

modelindex <- as.factor(c(rep.int(1,9999),
                          rep.int(2,9999),
                          rep.int(3,9999),
                          rep.int(4,9999)))

statsobs <- read.table("results/statobs.txt",header=T)

rm(reftable_model1,reftable_model2,reftable_model3,
   reftable_model4,reftable_model5,reftable_model6,
   reftable_model7,reftable_model8)
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
     file="ModelChoice1.RData")

