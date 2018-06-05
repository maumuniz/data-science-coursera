#quiz1
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,"comm06.csv")
houseData <- data.table(read.csv("comm06.csv"))
strsplit(names(houseData),split = "wgtp")[123]

#quiz2
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl,"GDP.csv")
GDP <- data.table(read.csv("GDP.csv",skip = 4,nrows = 190))
GDP <- GDP[,list(X,X.1,X.3,X.4)]
GDP <- setNames(GDP,c("countrycode","rank","name","nGDP"))
GDP[,mean(as.numeric(gsub(",","",GDP$nGDP)))]

#quiz3
GDP[,grep("^United",name)]

#quiz4
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl,"edStat.csv")
edStat <- data.table(read.csv("edStat.csv"))
length(edStat[,grep("Fiscal year(.*)June",Special.Notes)])

#quiz5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
dateStock <- index(amzn)
dateStock <- ymd(dateStock)
sum(year(dateStock)==2012)
sum(year(dateStock)==2012 & wday(dateStock)==2)



