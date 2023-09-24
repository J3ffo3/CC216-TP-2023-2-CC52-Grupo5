## CC216-Fundamentos de Data Science
# TRABAJO PARCIAL
### 2023-02

## **Objetivo del trabajo**
El caso de uso que le estamos dando a esta información es para realizar un análisis sobre las reservas hechas en los distintos tipos de hoteles responder a ciertas preguntas acerca de la demanda de cada tipo de hotel teniendo en cuenta ciertos factores que pueden influir a la elección de los usuarios y en qué momentos es donde se dan los periodos de tiempo en los cuales se realizan la mayoría de las reservas. Esto puede ser beneficioso para diferentes hoteles para que sepan en qué momentos pueden llegar a tener más clientes y mejorar sus servicios para esos periodos de tiempo y que ofrecerle a los usuarios para que se decidan por hospedarse en su local.

## **Nombre de los alumnos participantes**
- U20191e742 - Alcalde Gonzalez Renato Alberto
- U202017033 - Datto Aponte Antonio Francisco
- U202124269 - Diaz Villanueva Jeffrey Ulises

## **Breve descripción del dataset**
El dataset se basa en una cantidad total de 119390 con 32 variables distintas con información acerca de un hotel resort y uno urbano.
Cuenta con 17 columnas de tipo integer, 14 de tipo char y 1 de tipo num.

- hotel: Representa el tipo de hotel: resort o urbano
- is _canceled: Representa si la reservación fue cancelada: 0 (no cancelada), 1 (cancelada)
- lead_time: Días que pasaron entre la reserva y el día de llegada del usuario
- arrival_date_year: Año de la llegada a la reservación
- arrival_date_month: Mes de la llegada a la reservación
- arrival_date_week_number: Número de semana de la llegada a la reservación
- arrival_date_day_of_month: Día del mes de la llegada a la reservación
- stays_in_weekend_nights: Número de noches del fin de semana que el usuario se quedó o reservó
- stay_in_week_nights: Número de noches de la semana que el usuario sequedó o reservó
- adults: Número de adultos que había en la reservación
- children: Número de niños que había en la reservación
- babies: Número de bebés que había en la reservación
- meal: Tipo de comida que se pidió para la reservación
- country: País de origen del hotel
- market_segmnet: Segmento del mercado
- distribution_channel: canal de distribución de reservas
- is_repeated_guest: Representa si el usuario ya ha reservado anteriormente: 0 (no), 1 (sí)
- previous_cancellations: Número de cancelaciones de reservas hechas por un usuario
- previous_booking_not_cancelled: Número de veces que el usuario no ha cancelado una reserva anteriormente
- reserved_room_type: Tipo de habitación reservada
- assigned_room_type: Tipo de habitación ofrecida al usuario
- booking_changes: Número de cambios en la reservación actual
- deposit_type: Tipo de depósito
- agent: ID de la agencia de viajes que hizo la reserva
- company: ID de la compañía responsable por el pago de la reservación
- days_in_waiting_list: Días en la lista de espera para las reservas
- costumer_type: Tipo de reserva
- adr: Tarifa diaria promedio
- required_car_parking_spaces: Aparcamientos requeridos en la reserva
- total_of_special_requests: Número de reservas especiales
- reservation_status: Estado de la reservación
- reservation_status_date: Dia del ultimo estado de la reservación   

## **Conclusiones**
1. Hay en total una cantidad de 79330 reservas hechas en “City Hotel” y 40060 en “Resort Hotel” por lo que podemos afirmar que el tipo de hotel que la gente prefiere hospedarse es en un “City Hotel”.
2. La demanda de reservas está aumentando con el tiempo, con algunas ocasiones donde disminuyen ligeramente.
3. La temporada de alta demanda de reservas es durante los meses de Julio y Agosto.
4. Los meses con menor demanda de reservas son Noviembre, diciembre y Enero.
5. Existen 9332 reservas que incluyen niños y/o bebés.
6. La disponibilidad de plazas de aparcamiento puede influir en la decisión de cancelar una reserva, pero no es el único factor determinante.
7. Los meses Agosto, Julio, Mayo, Junio y Abril tienen mayor índice de cancelaciones de reserva y puede estar relacionado con factores como: estaciones, días festivos o eventos.

## **Licencia**
Este trabajo está bajo la Licencia MIT.
