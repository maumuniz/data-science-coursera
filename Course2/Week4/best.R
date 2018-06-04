best <- function(state, outcome) {
  ## Read outcome data
  hospData <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
  
  ## Check that state and outcome are valid
  if (sum(unique(hospData$State) == state) == 0){
    stop("invalid state")
  }
  validOutcomes <- c("heart attack", "heart failure","pneumonia")
  if (sum(unique(validOutcomes) == outcome) == 0){
    stop("invalid outcome")
  }
  idxOutcome <- which(validOutcomes==outcome)*6 + 5
  
  ## Return hospital name in that state with lowest 30-day death rate
  shortList <- hospData[c(2,7,idxOutcome)]
  shortList <- shortList[shortList[2] == state,]
  shortList[,3] = as.numeric(shortList[,3])
  shortList <- shortList[order(shortList$Hospital.Name),]

  minRate <- min(shortList[3], na.rm = TRUE)
  idxHospital<-which(shortList[3] == minRate)
  shortList$Hospital.Name[idxHospital[1]]
}