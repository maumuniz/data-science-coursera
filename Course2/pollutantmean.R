pollutantmean <-function(directory, pollutant, id=1:332){
  polVect = vector(mode="numeric", length=0L)
  for (i in 1:length(id)){
    x<-read.csv(paste(directory,"/",formatC(id[i],width=3,flag="0"),".csv", sep=""))
    polVect<-c(polVect,x[complete.cases(x[pollutant]),pollutant])
    
  }
  mean(polVect)
}
