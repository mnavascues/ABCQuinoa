# set location of DIYABC executable ( /!\ NOT THE GUI )
DIYABC_exe_name <- ("/home/miguel/Software/Population_Genetics_Software/diyabc/2.1.0/src-JMC-C++/general")


DIYABCporject <- "Model_1pop_2017_7_25-1"
Rproject      <- "Model_1pop"

DIYABCporject <- "Model_2pop_2017_7_25-1"
Rproject      <- "Model_2pop"

DIYABCporject <- "Model_3pop_topo1_2017_7_25-1"
Rproject      <- "Model_3pop_topo1"
DIYABCporject <- "Model_3pop_topo2_2017_7_25-1"
Rproject      <- "Model_3pop_topo2"
DIYABCporject <- "Model_3pop_topo3_2017_7_25-1"
Rproject      <- "Model_3pop_topo3"

DIYABCporject <- "Model_Admix1_topo1_2017_7_25-1"
Rproject      <- "Model_Admix1_topo1"
DIYABCporject <- "Model_Admix1_topo2_2017_7_25-1"
Rproject      <- "Model_Admix1_topo2"
DIYABCporject <- "Model_Admix1_topo3_2017_7_25-1"
Rproject      <- "Model_Admix1_topo3"

DIYABCporject <- "Model_Admix2_topo1_2017_7_27-1"
Rproject      <- "Model_Admix2_topo1"
DIYABCporject <- "Model_Admix3_topo1_2017_7_27-1"
Rproject      <- "Model_Admix3_topo1"
DIYABCporject <- "Model_Admix4_topo1_2017_7_27-1"
Rproject      <- "Model_Admix4_topo1"

DIYABCporject <- "Model_Admix1_topo1_popsize1_2017_7_27-1"
Rproject      <- "Model_Admix2_topo1_popsize1"
DIYABCporject <- "Model_Admix1_topo1_popsize2_2017_7_27-1"
Rproject      <- "Model_Admix2_topo1_popsize2"




diyabc_command <- paste0(DIYABC_exe_name," -p data/DIYABC/",DIYABCporject,"/ -x > results/log/bin2txt.log")
system( diyabc_command )
reftable        <- read.table(paste0("data/DIYABC/",DIYABCporject,"/reftable.txt"),skip=5)
reftable        <- reftable[-nrow(reftable),]

reftable_header <- read.table(paste0("data/DIYABC/",DIYABCporject,"/conf.th.tmp"))
#head(reftable)
names(reftable) <- as.vector(t(reftable_header))

stats_names <- as.vector(t(reftable_header[(length(reftable_header)-147):length(reftable_header)]))
#length(stats_names)


dim(reftable)
save(stats_names,reftable,file=paste0("results/reftable_",Rproject,".RData"))





