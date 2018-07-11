project_name <- c("1population",
                  "2populations1",
                  "2populations2",
                  "2populations3",
                  "3populations",
                  "Admixture1event1",
                  "Admixture1event2",
                  "Admixture2events",
                  "Wild2samples")

# set location of DIYABC executable ( /!\ NOT THE GUI )
DIYABC_exe_name <- ("/home/miguel/Software/Population_Genetics_Software/diyabc/2.1.0/src-JMC-C++/general")

for (m in seq_along(project_name)){
  
  
  diyabc_command <- paste0(DIYABC_exe_name," -p data/DIYABC/",project_name[m],"/ -x > results/log/bin2txt.log")
  system( diyabc_command )
  reftable        <- read.table(paste0("data/DIYABC/",project_name[m],"/reftable.txt"),skip=5)
  reftable        <- reftable[-nrow(reftable),]
  
  reftable_header <- read.table(paste0("data/DIYABC/",project_name[m],"/first_records_of_the_reference_table_0.txt"),nrows = 1)
  #head(reftable)
  names(reftable) <- as.vector(t(reftable_header))
  
  
  
  number_of_stats <- 200
  stats_names <- as.vector(t(reftable_header[(length(reftable_header)-number_of_stats+1):length(reftable_header)]))
  length(stats_names)
  
  dim(reftable)
  save(stats_names,reftable,file=paste0("results/reftable_",project_name[m],".RData"))
  
  file.remove(paste0("data/DIYABC/",project_name[m],"/reftable.txt"))
  
  
}
