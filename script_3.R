install.packages('mongolite') 
library (mongolite)

mongod --dbpath C:/Users/Marcus/Documents/data_science/data/db

m <- mongo("ovnis", url = "mongodb://localhost:27017/ovni")

inserted_OVNIs <- m$insert(df_OVNI)

m$find ('{"City": "Phoenix" }')

ca <- m$find ('{"State": "CA" }')

dim(ca)
head(ca)
View(ca)

