#################
#TRABAJO PARCIAL#
#################

rm(list=ls(all=TRUE)) 

# Limpia consola
cat("\014")

## ANÁLISIS EXPLORATORIO DE DATOS ##

## A) CARGA DE DATOS

setwd("C:/Users/jeffd/Pictures/UPC/CICLO 5/Fundamentos de Data Science/TP/data")
hotel_bookings<-read.csv('hotel_bookings.csv', header=TRUE, sep=',',dec='.')

## B) INSPECCIONAR DATOS

#visualización de dataset original

View(hotel_bookings)
names(hotel_bookings)
str(hotel_bookings)

#viendo cuantos valores int y char hay

columnas_int <- sapply(hotel_bookings, is.integer)
cantidad_columnas_int <- sum(columnas_int)

columnas_char <- sapply(hotel_bookings, is.character)
cantidad_columnas_char <- sum(columnas_char)

## C) PRE-PROCESAR DATOS

#Limpieza de Datos
#viendo cuantos elementos vacios hay
sin_valor <- function(x){
  sum = 0
  for(i in 1:ncol(x))
  {
    cat("En la columna",colnames(x[i]),"total de valores NA:",colSums(is.na(x[i])),"\n")
  }
}
sin_valor(hotel_bookings)

#viendo si hay valores eb blanco
en_blanco <- function(x){
  sum = 0
  for(i in 1:ncol(x))
  {
    cat("En la columna",colnames(x[i]),"total de valores en blanco:",colSums(x[i]==""),"\n")
  }
}
en_blanco(hotel_bookings)

#viendo cuales filas contienen los valores de NA
filas_con_na <- hotel_bookings[is.na(hotel_bookings$children), ]
head(filas_con_na)

#viendo la media de la columna children para rellenar los valores que estan en NA
summary(hotel_bookings$children)

#Rellenando los valores de NA con la media hallada anteriormente
hotel_bookings$children <- ifelse(is.na(hotel_bookings$children), 0, hotel_bookings$children)

#verificando que ya no hay variables con NA en el dataset
sin_valor(hotel_bookings)

#Outliers
install.packages("dplyr",dependencies = TRUE)
library(dplyr)
boxplot.stats(hotel_bookings$required_car_parking_spaces)
boxplot(hotel_bookings$required_car_parking_spaces)

# Correccion metodo 1
fix_outliers <- function(x, removeNA = TRUE){
  #Calculamos los quantiles 1) por arriba del 5% y por debajo del 95%
  9
  quantiles <- quantile(x, c(0.05, 0.95), na.rm = removeNA)
  x[x<quantiles[1]] <- mean(x, na.rm = removeNA)
  x[x>quantiles[2]] <- median(x, na.rm = removeNA)
  x
}

#correccion metodo 2
replace_outliers <- function(x, removeNA = TRUE){
  qrts <- quantile(x, probs = c(0.25, 0.75), na.rm = removeNA)
  # si el outlier esta por debajo del cuartil 0.5 o por arriba de 0.95
  caps <- quantile(x, probs = c(.05, .95), na.rm = removeNA)
  # Calculamos el rango intercuartilico
  iqr <- qrts[2]-qrts[1]
  # Calculamos el 1.5 veces el rango intercuartiligo (iqr)
  altura <- 1.5*iqr
  #reemplazamos del vector los outliers por debajo de 0.05 y 0.095
  10
  x[x<qrts[1]-altura] <- caps[1]
  x[x>qrts[2]+altura] <- caps[2]
  x
}

## D) VISUALIZAR DATOS

#haciendo una copia del dataset manteniendo las columnas que consideramos necesarias

keeps<- c("hotel","arrival_date_month","arrival_date_year","children","babies","required_car_parking_spaces","is_canceled")
hotel_copy<-hotel_bookings[keeps]
head(hotel_copy)

#guardando el nuevo dataset como csv

write.csv(hotel_copy,"hotel_copy.csv",row.names=TRUE)

library(dplyr)
library(ggplot2)

## cONCLUSIONES PRELIMINARES ##

#a)
table(hotel_copy$hotel)

barplot(table(hotel_copy$hotel), main="Reservas realizadas por Hotel", 
        names= c("City Hotel", "Resort Hotel"))

#b)
ggplot(hotel_copy, aes(x = factor(arrival_date_year))) +
  geom_bar() +
  labs(x = "Año", y = "Número de reservas") +
  ggtitle("Número de reservas por año")
#c)
ggplot(hotel_copy, aes(x = factor(hotel_copy$arrival_date_month, levels = month.name))) +
  geom_bar() +
  labs(x = "Mes de llegada", y = "Número de reservas") +
  ggtitle("Número de reservas por mes")

#d)
table(hotel_copy$arrival_date_month)

#e)
reservas_con_ninos_o_bebes <- subset(hotel_copy, children > 0 | babies > 0)
cantidad_reservas_con_ninos_o_bebes <- nrow(reservas_con_ninos_o_bebes)
cat("El número de reservas que incluyen niños y/o bebés es:", cantidad_reservas_con_ninos_o_bebes, "\n")

#f)
# Crear un gráfico de barras que muestra la cantidad de reservas según la disponibilidad de estacionamiento
ggplot(hotel_copy, aes(x = required_car_parking_spaces, fill = as.factor(is_canceled))) +
  geom_bar(position = "dodge") +
  labs(title = "Relación entre demanda de Estacionamiento y Cancelación de Reservas",
       x = "Espacios de Estacionamiento Requeridos",
       y = "Número de Reservas",
       fill = "Cancelación de Reservas") +
  scale_fill_discrete(name = "Cancelación de Reservas", labels = c("No cancelado", "Cancelado"))

#g)
# Crear un gráfico de barras que muestra la cantidad de cancelaciones por mes
cancelaciones_por_mes <- hotel_copy %>%
  filter(is_canceled == 1) %>%
  group_by(arrival_date_month) %>%
  summarise(total_cancelaciones = n())

ggplot(cancelaciones_por_mes, aes(x = arrival_date_month, y = total_cancelaciones, fill = arrival_date_month)) +
  geom_bar(stat = "identity") +
  labs(title = "Cancelaciones de Reservas por Mes",
       x = "Mes de Llegada",
       y = "Número de Cancelaciones") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  scale_fill_discrete(name = "Mes")