complete<-function(directory,id=1:332){
  for (i in 1:length(id)){
    x<-read.csv(paste(directory,"/",formatC(id[i],width=3,flag="0"),".csv", sep=""))
    if(i==1){
      compCases <- data.frame(id=id[i],nobs=sum(complete.cases(x)))
    }else{
      compCases <- rbind(compCases,c(id[i],sum(complete.cases(x))))
    }
  }
  compCases
}