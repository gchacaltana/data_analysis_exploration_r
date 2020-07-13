# Análisis Exploratorio Titanic
# Gonzalo Chacaltana

# Instalando paquetes para dataset
if (packageVersion("devtools") < 1.6) {
  install.packages("devtools")
}
devtools::install_github("paulhendricks/titanic")

# Instalando paquetes
install.packages("rlang")
install.packages("stringi") 
install.packages("curl")
install.packages("tidyverse")
install.packages("ggplot2")
devtools::install_github("hrbrmstr/waffle")

# Cargando librerias.
library(ggplot2)
library(waffle)
library(tidyverse)
library(titanic)

# Almacenamos el dataset en la variable data
data <-titanic_train

# Mostramos primeros 6 registros del data frame
knitr::kable(head(titanic_train))

# Mostramos tipos de variables del data frame
str(Titanic)

# Resumen de las variables del data frame
summary(Titanic)
