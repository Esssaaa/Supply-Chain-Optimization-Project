rm(list=ls())
# Yiran Sun

library(pracma)
require("RMySQL")

db <- RMySQL:: dbConnect(drv = RMySQL::MySQL(), dbname = "distribution", username = "root", password = "root")
dbListTables(db)
dc<-dbReadTable(db, 'ww_dcs')
stores <- dbReadTable(db,'ww_stores')

dcloc <- cbind(dc$lat,dc$lon)
sloc <- cbind(stores$lat,stores$lon)

ndc <- nrow(dcloc)
ns <- nrow(sloc)
loc <- c( )
head <- c( )
tail <- c( )
distance <- c( )
cc <- 0

for (i in 1:ndc){
  for (j in 1:ns){
    cc <- cc+1
    head[cc] <- dc$dc_id[i]
    tail[cc] <- stores$store_id[j]
    distance[cc] <- haversine(dcloc[i,],sloc[j,])
  }
}
mileageList <- cbind(head,tail,distance)


mileageList <- data.frame(mileageList)
colnames(mileageList) <- c('dc_id','store_id','mileage')

dbSendQuery(db, "SET GLOBAL local_infile = true;")
dbWriteTable(db, 'ww_mileage', mileageList, overwrite = TRUE, row.names = FALSE)




