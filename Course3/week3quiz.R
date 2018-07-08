#quiz1

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile = "housing06.csv")
housing <- read.csv("housing06.csv")
agricultureLogical<-housing$ACR==3 & 
  housing$AGS==6
which(agricultureLogical)

#quiz2
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl,destfile = "jeff.jpg",mode="wb")
pic <- readJPEG("jeff.jpg",native = TRUE)
quantile(pic,probs = c(0.3,0.8))

#quiz3
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl,destfile = "GDP.csv")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl,destfile = "edStats.csv")
GDP <- read.csv("GDP.csv", skip = 4, nrows = 190)
eStat <- read.csv("edStats.csv")

#quiz4
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl,destfile = "GDP.csv")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl,destfile = "edStats.csv")
GDP <- read.csv("GDP.csv", skip = 4, nrows = 190)
eStat <- read.csv("edStats.csv")
GDP <- read.csv("GDP.csv", skip = 4, nrows = 190)
eStat <- read.csv("edStats.csv")
names(GDP)[c(1,2,4,5)]<-c("CountryCode","Rank","Name","GDP")
GDP <- select(GDP,CountryCode,Rank,Name,GDP)
mergData <- merge(GDP, eStat, by="CountryCode")
country_by_income<-group_by(mergData,Income.Group)
summarise(country_by_income,mean(Rank))

#quiz5
gLvl <-  quantile(country_by_income$Rank,seq(0, 1, 0.2) ,na.rm = TRUE)
quantcountry<-mutate(mergData,quantileGDP=cut(country_by_income$Rank,breaks = gLvl))
quantcountry<-quantcountry[quantcountry$Income.Group=="Lower middle income",]
country_by_quant<-group_by(quantcountry,quantileGDP)
summarise(country_by_quant,n())