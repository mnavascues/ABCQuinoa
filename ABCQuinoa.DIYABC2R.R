setwd("/home/miguel/Work/Research/Quinoa/")

DIYABC_exe_name <- ("/home/miguel/Software/Population_Genetics_Software/diyabc/2.1.0/src-JMC-C++/general")


DIYABCporject <- "Model1pop_2017_7_21-1"
Rproject      <- "Model1pop"
DIYABCporject <- "Model2pop_2017_7_12-1"
Rproject      <- "Model2pop"
DIYABCporject <- "Model3pop_2017_7_12-1"
Rproject      <- "Model3popTopo1"
DIYABCporject <- "Model3popTopo2_2017_7_21-1"
Rproject      <- "Model3popTopo2"
DIYABCporject <- "Model3popTopo3_2017_7_21-1"
Rproject      <- "Model3popTopo3"
DIYABCporject <- "ModelAdmixture_2017_7_12-1"
Rproject      <- "ModelAdmixture1"
DIYABCporject <- "ModelAdmixtureTopo2_2017_7_23-1"
Rproject      <- "ModelAdmixture1Topo2"
DIYABCporject <- "ModelAdmixtureTopo3_2017_7_23-1"
Rproject      <- "ModelAdmixture1Topo3"
DIYABCporject <- ""
Rproject      <- ""


  
diyabc_command <- paste0(DIYABC_exe_name," -p ",DIYABCporject,"/ -x > bin2txt.log")
system( diyabc_command )
reftable        <- read.table(paste0(DIYABCporject,"/reftable.txt"),skip=5)
reftable        <- reftable[-nrow(reftable),]

reftable_header <- read.table(paste0(DIYABCporject,"/conf.th.tmp"))
#head(reftable)
names(reftable) <- as.vector(t(reftable_header))

stats_names <- reftable_header[(length(reftable_header)-197):length(reftable_header)]
#length(stats_names)


dim(reftable)
save(stats_names,reftable,file=paste0("reftable_",Rproject,".RData"))





