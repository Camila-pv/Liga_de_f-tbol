def jugadores():
    return """select nombre, goles, rank() over(order by goles desc) as goles_rank
               from Goleadores;
		      """
def asistencias():
    return """select nombre, asistencias, rank() over(order by asistencias desc) as asistencias_rank
               from Asistidores;
		      """
              
def presupuesto_dt():
    return """select nombre, presupuesto_en_miles, rank() over(order by presupuesto_en_miles desc) as dt_presupuesto_rank
              from Directores_Tecnicos_Presupuesto;
		      """
