setwd("C:\\Users\\Marcus\\Documents\\data_science")

install.packages('mongolite')

library (mongolite)

m <- mongo("ovnis", url = "mongodb://localhost:27017/ovni")

df_OVNI <- m$find ('{}')

write.csv(rbind(df_OVNI), file = "OVNIs_Preparados.csv")
