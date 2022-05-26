def jugadores():
    return """select nombre, goles, rank() over(order by goles desc) as goles_rank
               from Goleadores;
		      """
def asistencias():
    return """select nombre, asistencias, rank() over(order by asistencias desc) as asistencias_rank
               from Asistidores;
		      """
