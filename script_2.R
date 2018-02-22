df_OVNI <- read.csv("OVNIS.csv",stringsAsFactors = FALSE)

any(is.na(df_OVNI$State))
any(df_OVNI$State=="")

df_OVNI <- df_OVNI[!(df_OVNI$City == "" | is.na(df_OVNI$City)), ]

any(is.na(df_OVNI$State))
any(df_OVNI$State=="")

df_OVNI <- df_OVNI[!(df_OVNI$State == "" ), ]

any(df_OVNI$Shape=="")

df_OVNI <- df_OVNI[!(df_OVNI$Shape == "" ), ]

unique(df_OVNI$State)

df_OVNI <- df_OVNI[(df_OVNI$State %in% df_estados_validos$Abbreviation),]

unique(df_OVNI$State)

df_OVNI$Posted <- NULL
df_OVNI$Duration <- NULL
df_OVNI$Summary <- NULL
df_OVNI$X <- NULL

unique(df_OVNI$Shape)

require (sqldf)
OVNI_EUA_por_Tipo = sqldf("select Shape, count(*) Views  
                from df_OVNI group by Shape order by 2 desc")

OVNI_EUA_por_Tipo = sqldf("select Shape, count(*) Views  
                from df_OVNI group by Shape 
                having count(*) > 1000")

df_OVNI <- df_OVNI[(df_OVNI$Shape %in% OVNI_EUA_por_Tipo$Shape),]

df_OVNI <- df_OVNI[!(df_OVNI$Shape == "Unknown" ), ]

d <- strsplit(df_OVNI$Date...Time, ' ') 
e <- do.call(rbind.data.frame, d)
colnames(e) <- c("Sight_Date", "Sight_Time")
e <- data.frame(lapply(e, as.character), stringsAsFactors=FALSE)
df_OVNI <- cbind(df_OVNI, e)
df_OVNI$Date...Time <- NULL

df_OVNI$Sight_Weekday <- weekdays(as.Date(df_OVNI$Sight_Date, '%m/%d/%y'))

e <- do.call(rbind.data.frame, strsplit(df_OVNI$Sight_Date, '/'))
e <- data.frame(lapply(e, as.integer))
colnames(e) <- c("Sight_Month", "Sight_Day", "Sight_Year")
df_OVNI <- cbind(df_OVNI, e)
df_OVNI$Sight_Year <- NULL

setwd("C:\\Users\\Marcus\\Documents\\data_science")






