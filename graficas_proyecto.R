setwd("/Users/Laboratorios EICT/Documents/graficas")
x<-read.table("estadisticas_jugador.csv",header = TRUE, sep=';',dec = ',')
View(x)

hist(x$partidos_jugados, main = "Histograma de las apariciones por jugador", xlab="Partidos Jugados",ylab="Frecuencia",col="blue")

png(file = "02.png")
proporciones <- c(167, 110,82, 78, 78) # creamos un vector con proporciones
etiquetas <- c("Primero", "Segundo", "Tercero", "Cuarto", "Quinto") # vector con etiquetas
pct <- round(proporciones/sum(proporciones)*100)
etiquetas <- paste(etiquetas, pct) # Añadimos porcentajes a etiquetas
etiquetas <- paste(etiquetas,"%",sep="") # Añadimos el símbolo de %

pie(proporciones,labels = etiquetas,
    col=rainbow(length(etiquetas)),
    main="Jugadores con mas convocatorias")

# Añadimos un cuadro con leyendas
legend("topleft", c("Carlos Arboleda","Javier Lopez","Cristian Arrieta","Juan Sebastian Villota","Juan Pablo Nieto"), cex = 0.8,
       fill = rainbow(length(proporciones)))

dev.off() # Guardamos diagrama
