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

# Obteniendo cantidad de personas que sobrevivieron y no sobrevivieron
survivors <- data %>% 
  group_by(Survived) %>% 
  count() %>%
  ungroup()%>%
  mutate(Survived = c("No Sobrevivió", "Si Sobrevivió"))


# Waffle Plot
waffle(survivors, rows = 20, size = 1, colors = c("firebrick1", "forestgreen"), legend_pos = "bottom")+
  labs(title = "Gráfico de sobrevivientes del Titanic", subtitle = "1 cuadrado = 1 persona")

# obteniendo cantidad de sobrevivientes por clase.
survivors_by_class <- data %>% 
  group_by(Pclass, Survived) %>%
  count() %>%
  ungroup()%>%
  mutate(Survived = ifelse(Survived==0,"No Sobrevivió", "Si Sobrevivió"))

# Waffle Plot
iron(
  waffle(filter(survivors_by_class, Pclass==1) %>% select(-Pclass),
         rows = 10, size=1,
         colors = c("firebrick1", "forestgreen"),
         legend_pos = "none")+
    labs(title = "Gráfico de sobrevivientes del Titanic por clase",
         subtitle = "Primera clase"),
  waffle(filter(survivors_by_class, Pclass==2) %>% select(-Pclass),
         rows = 10, size=1,
         colors = c("firebrick1", "forestgreen"),
         legend_pos = "none")+ 
    labs(subtitle = "Segunda clase"),
  waffle(filter(survivors_by_class, Pclass==3) %>% 
           select(-Pclass), rows = 15, size=1, colors = c("firebrick1", "forestgreen"),
         xlab = "1 cuadrado = 1 persona", legend_pos = "bottom")+ labs(subtitle = "Tercera clase") )

# Obteniendo cantidad de sobrevivientes por sexo
survivors_by_sex <- data %>% 
  group_by(Sex, Survived) %>%
  count() %>%
  ungroup()%>%
  mutate(Survived = ifelse(Survived==0,"No Sobrevivió", "Si Sobrevivió"))

# Waffle Plot
iron(
  waffle(filter(survivors_by_sex, Sex=="male") %>% select(-Sex),
         rows = 10, size=1,
         colors = c("firebrick1", "forestgreen"),
         legend_pos = "none")+
    labs(title = "Gráfico de sobrevivientes del Titanic por sexo",
         subtitle = "Hombres"),
  waffle(filter(survivors_by_sex, Sex=="female") %>% select(-Sex),
         rows = 10, size=1,
         colors = c("firebrick1", "forestgreen"),
         legend_pos = "none")+ 
    labs(subtitle = "Mujeres"))

