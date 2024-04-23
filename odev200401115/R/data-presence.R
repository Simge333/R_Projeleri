#'@export
veri_ithali<-function(){
  library(readxl)
  library(RSQLite)

  # Excel dosyas??n?? oku
  veri <- read_excel("online_retail.xlsx")

  # SQLite veritaban??na ba??lan
  con <- dbConnect(SQLite(), dbname = "Vize_Q2_200401115_Strazimiri_Tesnim.sqlite")

  # Verileri SQLite veritaban??na aktar
  dbWriteTable(con, "Fatura_Ucreti", veri,overwrite=TRUE)
  dbListTables(con)

  data <- dbReadTable(con, "Fatura_Ucreti")

  return(data)
}

#'@export
numeric<-function(data){


  data$InvoiceDate <- as.numeric(data$InvoiceDate)
  # Tarih sütununu POSIXct türüne dönüştürme
  data$InvoiceDate <- as.POSIXct(strptime(data$InvoiceDate, "%m/%d/%Y %H:%M"))

  return(data)

}
#'@param data
#'@export

grafik_olusturma<-function(data){
  library(ggplot2)
  library(dplyr)


  # Ürünlerin fiyatlarına ve ülkelerine göre gruplayıp ortalama fiyatları hesaplayalım
  average_price_by_country <- data %>%
    group_by(Country) %>%
    summarise(AveragePrice = mean(Price, na.rm = TRUE))

  # Ülkeye göre ortalama fiyatları sıralayalım
  average_price_by_country <- average_price_by_country %>%
    arrange(desc(AveragePrice))

  # Çubuk grafik oluşturalım
  a<-ggplot(average_price_by_country, aes(x = reorder(Country, AveragePrice), y = AveragePrice)) +
    geom_bar(stat = "identity", fill = "skyblue") +
    labs(x = "Ülke", y = "Ortalama Fiyat", title = "Ülkeye Göre Ortalama Fiyatlar") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))

  return(print(a))


}
