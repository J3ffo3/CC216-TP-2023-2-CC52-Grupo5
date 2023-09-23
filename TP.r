file = 'hotel_bookings.csv'
hotel_bookings<-read.csv(file,header=TRUE, sep=',',dec=',')
View(hotel_bookings)

#LIMPIEZA DE DATOS

keeps<- c("hotel", "arrival_date_year" ,"arrival_date_month", "children", "babies", "required_car_parking_spaces", "is_canceled")
hotel_copy<-hotel_bookings[keeps]
head(hotel_copy)

#viendo cuantos elementos vacíos hay
sin_valor <- function(x){
  sum = 0
  for(i in 1:ncol(x))
  {
    cat("En la columna",colnames(x[i]),"total de valores NA:",colSums(is.na(x[i])),"\n")
  }
}
sin_valor(hotel_copy)

#viendo si hay valores eb blanco
en_blanco <- function(x){
  sum = 0
  for(i in 1:ncol(x))
  {
    cat("En la columna",colnames(x[i]),"total de valores en blanco:",colSums(x[i]==""),"\n")
  }
}
en_blanco(hotel_copy)

#viendo cuáles filas contienen los valores de NA
filas_con_na <- hotel_copy[is.na(hotel_copy$children), ]
head(filas_con_na)

#viendo la media de la columna children para rellenar los valores que estan en NA
str(hotel_copy)
summary(hotel_copy$children)

#Rellenando los valores de NA con la media hallada anteriormente
hotel_copy$children <- ifelse(is.na(hotel_copy$children), 0, hotel_copy$children)

#verificando que ya no hay variables con NA en el dataset
sin_valor(hotel_copy)

#A

barplot(table(hotel_copy$hotel), main="Reservas realizadas por Hotel", 
        names= c("City Hotel", "Resort Hotel"))

#B

ggplot(hotel_copy, aes(x = factor(arrival_date_year))) +
  geom_bar() +
  labs(x = "Año", y = "Número de reservas") +
  ggtitle("Número de reservas por año")


#C & D

ggplot(hotel_copy, aes(x = factor(hotel_copy$arrival_date_month, levels = month.name))) +
  geom_bar() +
  labs(x = "Mes de llegada", y = "Número de reservas") +
  ggtitle("Número de reservas por mes")

#E

reservas_con_ninos_o_bebes <- subset(hotel_copy, children > 0 | babies > 0)
cantidad_reservas_con_ninos_o_bebes <- nrow(reservas_con_ninos_o_bebes)
cat("El número de reservas que incluyen niños y/o bebés es:", cantidad_reservas_con_ninos_o_bebes, "\n")

#F
ggplot(hotel_copy, aes(x = required_car_parking_spaces, fill = as.factor(is_canceled))) +
  geom_bar(position = "dodge") +
  labs(title = "Relación entre demanda de Estacionamiento y Cancelación de Reservas",
       x = "Espacios de Estacionamiento Requeridos",
       y = "Número de Reservas",
       fill = "Cancelación de Reservas") +
  scale_fill_discrete(name = "Cancelación de Reservas", labels = c("No cancelado", "Cancelado"))

#G

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

