covid<-read.csv("C:/Users/thitran82/Dropbox/STA 6233- Advanced R Programming/Visualization Project/COVID_Misinformation_2020-04-25.csv", stringsAsFactors = F)
str(covid)

#Convert string to date

covid$Publication_Date<-as.Date(covid$Publication_Date,format="%d-%b-%y")
covid$Entry_Date<-as.Date(covid$Entry_Date,format="%d-%b-%y")

save(covid, file="C:/Users/thitran82/Dropbox/STA 6233- Advanced R Programming/Visualization Project/Covid_Fake.RData")
load(url("https://github.com/thitran82/COVID19_FakeNews_Visualization/Covid_Fake.RData"))
