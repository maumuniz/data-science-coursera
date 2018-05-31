corr<-function(directory,threshold=0){
  corrN <- vector("numeric",0L)
  listComp <- complete(directory)
  listComp <- listComp[listComp[2]>threshold,1]
  if(length(listComp)!=0){
    for (i in 1:length(listComp)){
      x<-read.csv(paste(directory,"/",formatC(listComp[i],width=3,flag="0"),".csv", sep=""))
      y<-x[complete.cases(x),]
      corrN <- c(corrN,cor(y[2],y[3]))
    }
  }
  corrN
}