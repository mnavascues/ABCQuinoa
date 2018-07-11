library("abcrf")    # for ABC with random forests

model <- "Admixture2events"
load(file=paste0("results/reftable_",model,".RData"))

#names(reftable)[which(is.na(names(reftable)))] <- "NA"
params_names <- names(reftable)[2:22]

number_of_sims <- 200000

reftable_stats  <- reftable[1:number_of_sims,stats_names]
reftable_params <- reftable[1:number_of_sims,params_names]

statsobs <- read.table("results/statobs.txt",header=T)

rm(reftable)
gc()

dim(reftable_stats)
dim(reftable_params)



(params_names)



log_transform <- c(T,T,T,T,T,T,
                   F,F,T,F,F,F,
                   F,T,F,T,F,T,
                   T,F,T)

params_of_interest<-c(T,T,T,F,F,T,
                      F,F,T,T,F,T,
                      F,T,F,F,F,F,
                      T,T,F)

for (i in seq_along(params_names)){

  if(params_of_interest[i]){
    if (log_transform[i]){
      parameter <- log10(reftable_params[,params_names[i]])
      main_title <- paste0("log10(",params_names[i],")")
    } else {
      parameter <- reftable_params[,params_names[i]]
      main_title <- params_names[i]
    }
    
    RFmodel <- regAbcrf(formula = parameter~.,
                        data    = data.frame(parameter, reftable_stats),
                        ntree   = 500,
                        paral   = T)
    # pdf(file=paste0("results/RFmodel_",params_names[i],".pdf"))
    # 
    # abba <- 5
    # plot(x = RFmodel)
    # (abba)
    # (abba)
    # 
    # err.regAbcrf(object   = RFmodel,
    #              training = data.frame(parameter, reftable_stats),
    #              paral    = T)
    # dev.off()
    
    
    posterior <- predict(object    = RFmodel,
                         obs       = rbind(statsobs,statsobs),
                         training  = data.frame(parameter, reftable_stats),
                         quantiles = c(0.025,0.5,0.975),
                         paral     = T)
    (posterior)
    
    pdf(file=paste0("results/Antofagasta.posterior_",params_names[i],".pdf"))
    
    densityPlot(object    = RFmodel,
                obs       = rbind(statsobs,statsobs),
                training  = data.frame(parameter, reftable_stats),
                main      = main_title,
                paral     = T)
    (posterior)
    lines(density(parameter), col="grey")
    
    dev.off()
    
    save(parameter,RFmodel,posterior,
         file=paste0("results/Antofagasta.posterior_",params_names[i],".RData"))
    
    
  }
    

}




