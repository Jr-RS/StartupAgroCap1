#install.packages("httr")

library(httr)
library(jsonlite)


api_key <- "a5d5e206a89e10d64cc65740be76cf95"

cidade <- "Santos"
pais <- "BR"

url <- paste0("http://api.openweathermap.org/data/2.5/weather?q=", cidade, ",", pais, "&appid=", api_key, "&units=metric")
print(url)

response <- GET(url)
print(response)

if (response$status_code == 200) {
   data <- fromJSON(content(response, "text"))
  
  # Exibir dados principais do tempo
  cat('***************\n')
  cat("Previsão do Tempo para a cidade de", cidade, "agora:\n")
  cat("Temperatura: ", data$main$temp, "°C\n")
  cat("Sensação Térmica: ", data$main$feels_like, "°C\n")
  cat("Umidade: ", data$main$humidity, "%")
  cat('\n***************')

} else {
  print("Erro na requisição")
}