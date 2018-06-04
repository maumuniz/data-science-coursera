rankall <- function(outcome, num = "best") {
  ## Read outcome data
  hospData <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
  
  ## Check that state and outcome are valid
  validOutcomes <- c("heart attack", "heart failure","pneumonia")
  if (sum(unique(validOutcomes) == outcome) == 0){
    stop("invalid outcome")
  }
  idxOutcome <- which(validOutcomes==outcome)*6 + 5
  
  ## For each state, find the hospital of the given rank
  shortList <- hospData[c(2,7,idxOutcome)]
  shortList[,3] <- as.numeric(shortList[,3])
  shortList <- shortList[order(shortList[2],shortList[3],shortList[1]),]
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  shortList <- shortList[complete.cases(shortList),]
  
  if (num == "best"){
    idxHospital <- 1
  }else if (num == "worst"){
    idxHospital <- 0
  }else{
    idxHospital <- num
  }
  
  stateRank <- data.frame(hospital=tapply(shortList[,1], shortList[2], 
                                          function(elm) elm[if(idxHospital==0) length(elm) else idxHospital]),
                          state=unique(shortList[2]))
  
  stateRank
  
  }