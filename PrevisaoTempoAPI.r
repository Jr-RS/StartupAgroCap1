#install.packages("httr")
library(httr)
library(jsonlite)

api_key <- "SUA_CHAVE_API"
cidade <- "Santos"
pais <- "BR"

url <- paste0("http://api.openweathermap.org/data/2.5/weather?q=", cidade, ",", pais, "&appid=", api_key, "&units=metric")
response <- GET(url)

if (response$status_code == 200) {
  data <- fromJSON(content(response, "text"))

  cat('***************\n')
  cat("Previsão do Tempo para a cidade de", cidade, "agora:\n")
  cat("Temperatura: ", data$main$temp, "°C\n")
  cat("Sensação Térmica: ", data$main$feels_like, "°C\n")
  cat("Umidade: ", data$main$humidity, "%")
  cat('\n***************')

} else {
  print("Erro na requisição")
}