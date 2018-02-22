setwd('C:/Users/Marcus/Documents/data_science')
getwd()

install.packages('httr') 
install.packages('XML')

library(httr) 
library(XML)

df_OVNI  <- data.frame()
mes_corrente = 9
ano_corrente = 1997
ano_mes_corrente = (ano_corrente * 100) + mes_corrente

while (ano_mes_corrente  <= 201709) {
  site <- paste("http://www.nuforc.org/webreports/ndxe", as.character(ano_mes_corrente), ".html")
  site <- gsub (" ", "", site)
  html2 <- GET(site)
  parsed <- suppressMessages(htmlParse(html2, asText=TRUE))
  tableNodes <- getNodeSet(parsed, "//table")
  tb <- readHTMLTable(tableNodes[[1]])
  df_OVNI <- rbind(df_OVNI,tb)
  if (mes_corrente == 12)
  {
    mes_corrente <- 1
    ano_corrente <- ano_corrente + 1
    ano_mes_corrente <- (ano_corrente * 100) + mes_corrente
  }
  else
  {
    mes_corrente <- mes_corrente + 1
    ano_mes_corrente <- ano_mes_corrente + 1 
  }
  print(ano_mes_corrente)
}

write.csv(rbind(df_OVNI), file = "OVNIS.csv")

df_OVNI <- read.csv("OVNIS.csv",stringsAsFactors = FALSE)

dim(df_OVNI)

install.packages('sqldf')

library(zipcode)

OVNI_EUA_por_Estado = sqldf("select State, count(*) Views  
                          from df_OVNI 
                          group by state
                          order by 2 desc")

View(OVNI_EUA_por_Estado)

OVNI_EUA_por_Cidade = 
  sqldf("select state as state, city as city,count(*) Views  
        from df_OVNI 
        where state <> ''
        and city not like '%Canada%'
        group by state, city
        having count(*) >= 10
        order by 3 desc")

View(OVNI_EUA_por_Cidade)

OVNI_CA = sqldf("select Shape, City, count(*) Views  
                from df_OVNI 
                where State = 'CA'
                group by Shape, City 
                having count(*) > 10
                order by 3 desc")

View(OVNI_CA)

OVNI_EUA_por_Tipo = sqldf("select State, Shape, count(*) Views  
                from df_OVNI 
                          where state in ('CA', 'FL', 'WA', 'TX')
                          and shape in ('Light', 'Circle', 'Fireball', 'Sphere')
                          group by state, shape
                          order by 3 desc")

View(OVNI_EUA_por_Tipo)

install.packages('ggplot2')

library(ggplot2)

library(readr)

install.packages('tidyverse')

library(tidyverse)

ggplot(OVNI_EUA_por_Tipo, aes(x = State, y = Views)) +
  geom_col(aes(fill = Shape))

install.packages('sqldf')

install.packages('zipcode')

library(zipcode)

data(zipcode)

d <- merge(OVNI_EUA_por_Cidade, zipcode, by=c("state","city"))

install.packages("ggmap")
library(ggmap)


us<-map_data('state')

ggplot(d,aes(longitude,latitude)) +
  geom_polygon(data=us,aes(x=long,y=lat,group=group),color='gray',fill=NA,alpha=.35)+
  geom_point(aes(color = Views),size=.15,alpha=.25) +
  xlim(-125,-65)+ylim(20,50)

ca <- map_data('state', 'california')
d = d[d$state == 'CA' ,]

ggplot(d,aes(longitude,latitude)) +
  geom_polygon(data=ca,aes(x=long,y=lat,group=group),color='gray',fill=NA,alpha=.35)+
  geom_point(aes(color = Views),size=.15,alpha=.25) +
  xlim(-125,-110)+ylim(30,45)

any(is.na(df_OVNI$State))
any(df_OVNI$State=="")

df_OVNI <- df_OVNI[!(df_OVNI$City == "" | is.na(df_OVNI$City)), ]

any(is.na(df_OVNI$State))
any(df_OVNI$State=="")

df_OVNI <- df_OVNI[!(df_OVNI$State == "" ), ]

any(df_OVNI$Shape=="")

df_OVNI <- df_OVNI[!(df_OVNI$Shape == "" ), ]

unique(df_OVNI$State)

df_estados_validos <- read.csv("states.csv",stringsAsFactors = FALSE)










