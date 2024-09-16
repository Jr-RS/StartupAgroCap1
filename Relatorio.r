#install.packages("dplyr")
#install.packages("ggplot2")
library(dplyr)
library(ggplot2)

caminho_arquivo <- "C:/Users/junior.silva/OneDrive - Ibratan Ilimitada/Documentos/pessoal/fiap/git/StartupAgroCap1/relatorio.csv"
dados <- read.csv(caminho_arquivo, sep = ";")

head(dados)

estatisticas_basicas <- dados %>%
  summarise(
    Total_AreaTotal = sum(AreaTotal, na.rm = TRUE),
    Total_AreaUtilizavel = sum(AreaUtilizavel, na.rm = TRUE),
    Percentual_AreaUtilizavel = (sum(AreaUtilizavel, na.rm = TRUE) / sum(AreaTotal, na.rm = TRUE)) * 100,
    Total_NumeroMudas = sum(NumeroMudas, na.rm = TRUE),
    Total_Fertilizante = sum(Fertilizante, na.rm = TRUE),
    Total_Pragas = sum(Pragas, na.rm = TRUE)
  )

print(estatisticas_basicas)


# Calcular estatísticas básicas por cultura
estatisticas_por_cultura <- dados %>%
  group_by(Cultura) %>%
  summarise(
    Total_AreaTotal = sum(AreaTotal, na.rm = TRUE),
    Total_AreaUtilizavel = sum(AreaUtilizavel, na.rm = TRUE),
    Percentual_AreaUtilizavel = (sum(AreaUtilizavel, na.rm = TRUE) / sum(AreaTotal, na.rm = TRUE)) * 100,
    Total_NumeroMudas = sum(NumeroMudas, na.rm = TRUE),
    Total_Fertilizante = sum(Fertilizante, na.rm = TRUE),
    Total_Pragas = sum(Pragas, na.rm = TRUE),
    Media_NumeroMudas = mean(NumeroMudas, na.rm = TRUE),
    Desvio_NumeroMudas = sd(NumeroMudas, na.rm = TRUE)
  )

# Separar estatísticas para Eucalipto e Melancia
estatisticas_eucalipto <- filter(estatisticas_por_cultura, Cultura == "Eucalipto")
estatisticas_melancia <- filter(estatisticas_por_cultura, Cultura == "Melancia")

# Gerar o texto explicativo
texto_explicativo <- paste0(
  "\n\nObrigado por inserir os dados de suas áreas de plantio. Com base nas informações fornecidas, aqui está uma análise dos seus campos e os insumos necessários para o cultivo:\n\n",
  
  "1. **Área Total e Área Utilizável**:\n",
  "   Para plantar eucalipto, a área total das suas plantações é de ", round(estatisticas_eucalipto$Total_AreaTotal, 2), 
  " metros quadrados, somando todos os registros da cultura eucalipto. Já para a plantação de melancias, a área total é de ", round(estatisticas_melancia$Total_AreaTotal, 2), " metros quadrados.\n",
  "   A área utilizável média (a área que pode ser efetivamente plantada) é de ", round(estatisticas_eucalipto$Total_AreaUtilizavel, 2), 
  " metros quadrados, que representa ", round(estatisticas_eucalipto$Percentual_AreaUtilizavel, 2), "% da área total para a plantação de eucaliptos, enquanto para melancias, a área utilizável é de ", 
  round(estatisticas_melancia$Total_AreaUtilizavel, 2), " metros quadrados, representando ", round(estatisticas_melancia$Percentual_AreaUtilizavel, 2), "% da área total.\n\n",
  
  "2. **Número de Mudas**:\n",
  "   O número total de mudas necessárias para plantar suas áreas estimadas é de ", round(estatisticas_eucalipto$Total_NumeroMudas, 2), " mudas para a plantação de eucalipto e ",
  round(estatisticas_melancia$Total_NumeroMudas, 2), " mudas para a plantação de melancias. O desvio padrão das mudas entre os registros é de ", round(estatisticas_eucalipto$Desvio_NumeroMudas, 2), 
  " para eucalipto e ", round(estatisticas_melancia$Desvio_NumeroMudas, 2), " para melancias.\n\n",
  
  "3. **Fertilizante e Controle de Pragas**:\n",
  "   Em média, você precisará de ", round(estatisticas_eucalipto$Total_Fertilizante, 2), " kg de fertilizante para plantar toda a área de eucaliptos, e ",
  round(estatisticas_melancia$Total_Fertilizante, 2), " kg para melancias.\n",
  "   Quanto ao controle de pragas, a média estimada é de ", round(estatisticas_eucalipto$Total_Pragas, 2), " litros de produto para o eucalipto e ",
  round(estatisticas_melancia$Total_Pragas, 2), " litros para melancias, o que representa uma diferença de ",
  abs(round(((estatisticas_melancia$Total_Pragas - estatisticas_eucalipto$Total_Pragas) / estatisticas_eucalipto$Total_Pragas) * 100, 2)), "% entre as duas culturas.\n\n",
  
  "### Recomendações:\n",
  "   - Considere que o desvio padrão oferece uma ideia da variabilidade nas suas áreas de plantio e insumos necessários. Quanto maior o desvio, maior é a diferença entre as áreas ou insumos entre os diferentes registros.\n",
  "   - Planeje os insumos (fertilizantes e controle de pragas) com base na área utilizável e no número total de mudas.\n",
  "   - Ajuste as necessidades com base na cultura específica (Melancia ou Eucalipto), já que cada uma requer diferentes quantidades de mudas e insumos.\n\n",
  
  "Por fim, use essas informações para otimizar o plantio, estimar o tempo de trabalho, os custos e os recursos necessários para garantir o sucesso da colheita."
)

cat(texto_explicativo)