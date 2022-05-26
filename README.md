# Liga_de_futbol
Base de datos de una liga de fútbol


**¿Comó ejecutar el codigo?**

Paso 1.
Depurar unicamente la zona de los create y alter table del DDL hasta donde esta debidamente indicado dentro de la base.

Paso 2.
Depurar la zona de inserciones del DDL que esta debidamente indicada, preferiblemente archivo por archivo para mayor eficiencia.

Paso 3. 
Depurar la zona de los roles, corriendo uno por uno para mejor entendimiento.

Paso 4.
Depurar la seccion de las vistas, de las cuales podran salir consultas valiosas.

Paso 5.
Depurar el trigger paso a paso, corriendo primero la tabla, en segundo la funcion y por ultimo el trigger.

Paso 6. 
Ya podra realizar las consultas que desee, y tendra unos ejemplos en la parte final.

**Problemática**

Esta propuesta busca facilitar la búsqueda de información por parte de los usuarios que necesiten o quieran por su propia cuenta, obtener datos acerca de su liga de preferencia. Hoy en día hay muchos usuarios dentro del mundo del futbol que quisieran obtener una gran cantidad de datos para realizar un buen análisis sobre su equipo o sobre algún jugador, ya sea solo para adquirir conocimiento o para algún otro tema que incluya un objetivo monetario para esta persona, como lo es el mundo de las apuestas, o también si se necesitan sacar datos para los mismos funcionarios del club para manejar el tema de las finanzas e igualmente para los funcionarios de las propias ligas. En cuanto al mundo de las apuestas, existen muchas personas que basan su economía en esta actividad, ya sea por parte de las casas de apuestas como también de sus usuarios, el hecho de tener una base de datos que contenga cada estadística del club y sus jugadores permitirá una mejor predicción y facilitara el hecho de sacar un indicador de multiplicación para las apuestas de cada partido.
Como segunda problemática a superar, actualmente cada equipo de futbol mueve mucho dinero fuera de sus partidos, la realización de esta propuesta busca facilitar para los usuarios la búsqueda de cualquier producto que quieran adquirir que esté relacionado con el club, ya sean sus camisetas, sus sudaderas, sus equipaciones, o también las boletas de los partidos, sin tener que salir del lugar donde encuentran las estadísticas y resultados del club. Todo al alcance de un clic desde la comodidad ya sea de su celular, computador o tableta.


**Planos iniciales**

   En la imagen anterior se puede evidenciar la primera creación y estructuración de la base de datos. Donde inicialmente contábamos con 16 tablas las cuales son: jugador, director técnico, entrenador, club, posición, equipación, estadio, patrocinadores, estadísticas jugador, estadísticas club, liga, equipo médico, equipo utilería, alineación, suplentes y titulares, cada uno con sus respectivos atributos.

    
**Diseño**

En las siguientes dos subsecciones se encuentran los modelos de datos que definen como se modela la estructura lógica y conceptual de la base de datos de la liga de futbol colombiana. Estos modelos son entidades importantes para introducir la abstracción en una base de datos, como se conectan entre sí, como se procesan y almacenan dentro del sistema. También ayudan a evitar la redundancia de datos porque es más fácil implementar la normalización 3NF.
    
**Diseño Conceptual(Diagrama entidad relación)**
    En el modelo conceptual fue diseñado en la plataforma ERDPlus, el modelo de datos identifica las relaciones de más alto nivel entre las diferentes entidades. Incluye las entidades importantes y las relaciones entre ellas, como lo son club, jugador, estadísticas jugador, estadísticas club, entrenador, director técnico entre otras.
        ![disenoConceptual](https://user-images.githubusercontent.com/72886478/170491403-5b71bcba-07c7-4f26-8f13-3ecb92044ff2.jpg)

**Diseño Lógico(Diagrama relacional)**
    En el modelo de datos lógico fue diseñado en PGModeler, el modelo describe los datos con el mayor detalle posible, independientemente de cómo se implementarán físicamente en la base de datos. Incluye todas las tablas y atributos que se relacionan entre ellos, cada atributo está especificado con su tipo y en caso particular de ser llave primaria o llave foránea.
        ![disenoLogico](https://user-images.githubusercontent.com/72886478/170491419-77841e69-7389-46cb-a9f9-90cf83b7ea95.jpg)

**Normalización**
    Para la edición del plano inicial de las tablas tuvimos en cuenta la normalización 3NF que se estructura de la siguiente forma:\\
  Reglas para 1NF
      - Cada registro debe ser único, sin filas duplicadas
      - Cada celda debe contener un valor, debe verificar que no existan atributos multivalor
      Todo nuestro modelo ya estaba normalizado en 1NF, por lo cual no tuvimos que hacer nunguna modificación en este aspecto, ya que cumplia las condiciones.
  Regla para 2NF
      - Debe satisfacer 1NF 
      - Si la clave principal (PK) de una tabla consta de uno y solo una columna, automáticamente satisface 2NF\\
      Si hay una clave principal compuesta, cada columna no clave debe depender de toda la llave. Se deben eliminar dependencias paciales de la llave.
      Existian unas tablas en nuestro modelo que no tenian llave primaria como la tabla estadisticas club, lo cual resolvimos creando el atributi id estadisticas club porque los demas atributos no eran los apropiados para ser llave primaria de esta tabla.\\
           
       
  Reglas para 3NF
      - Satisfacer 2NF
      - Sin dependencias transitivas: Las columnas no claves (que no forman parte de la PK), no pueden depender de otras columnas que tampoco sean no clave.\\
      En nuestro caso en especifico incialmente teniamos una tabla llamada uniforme con los siquientes atributos: id club, tipo de uniforme, color primario, color secundario
       Note que hay una dependencia transitiva entre los colores, el tipo y el id del club , ya que un club tiene dos tipos de uniformes y varios colores pueden ser de muchos clubs y tipos de uniforme. Por lo que decidimos crear dos tablas, uniforme visitante y uniforme local el cual solucional el problema de transitividad.
            
           
**Diseño físico**
Teniendo en cuenta en plano inicial, el diseños logico y conceptual, luego de añadirle la normalización, se obtuvo el siguiente diseño:

En el cual se evidencian 18 tablas con sus llaves primarias y llaves foraneas, donde dos son las principales(jugador y club) que se derivan las demas(contrato jugador, director tecnico, estadio etc..) entre esas tablas estan estadisticas del jugador y estadisticas del club, que son las que se puede lograr un mayor analisis por sus atributostan representativos para los clubs de la liga colombiana de futbol. 
![modelo](https://user-images.githubusercontent.com/72886478/170491576-44dc505a-c744-4d2b-bfc6-f05f71945b95.png)


**Inserción Datos**
Web scraping, es una técnica utilizada mediante Python para extraer información de sitios web, en nuestro caso en específico extrajimos los datos de TransferMarket. El web scraping está muy relacionado con la indexación de la web, la cual indexa la información de la web utilizando la librería requests, se enfoca más en la transformación de datos sin estructura en la web (como el formato HTML) en datos estructurados que pueden ser almacenados y analizados en la base de datos liga, en una archivo CSV. El uso que le dimos a esta herramienta fue la extracción de los datos de las tablas principales y con mayor cantidad de datos que era muy complicado e ineficiente extraerlos a mano ya que gracias a su capacidad de generar grandes cantidades de datos para crear contenidos de calidad pudimos extraer con éxito todos los datos para poder hacer un mayor análisis.
    
Luego de extraer los datos continuamos con la insercción de ellos mediante la siguiente imagen, la cual leia archivos csv donde se almacenaban gran cantidad de datos.
    
 
    
**Consultas**


  **Consulta 1 - Información de los clubes**

  **Consulta 2 - Información de los jugadores**
 
  **Consulta 3 - Información de las  estadisticas de cada uno de los jugadores.**
    
  **Consulta 4 - Los 13 máximos goleadores del torneo.**
Se crea una vista llamada Goleadores con el producto cartesiano entre las tablas jugador y estadísticas jugador, donde la llave foránea es id jugador . En la vista se puede ver los atributos nombre, id jugador y goles. Luego se hace un Rank y order by de los mejores goleadores de todos los clubs, es decir los jugadores que hallan hecho más goles y se ordena de forma decreciente. Gracias a la consulta podemos ver que el mejor goleador de todoa los clubs es Luis Carlos Ruiz con el cual cuanta con 10 goles.
    
  **Consulta 5 - Los 13 máximos asistidores del torneo.**
   Se creó una vista llamada Asistidores con el producto cartesiano entre las tablas jugador y estadísticas jugador , donde la llave foránea es id jugador. En la vista se selecciona los atributos nombre, id jugador y asistencias .Luego se hace un Rank y order by de las mejores asistencias de todos los clubs, es decir los jugadores que hallan hecho más asistencias y se ordena de forma decreciente. Gracias a la consulta podemos ver que la mejor asistencia es de Juan Sebastián Villota con 7 asistencias y los siguientes 12 jugadores que siguen ocupan el segundo lugar en el ranking con 4 asistencias.
    
  **Consulta 6 - Los colores caracteristicos de cada club.**
    Creamos un inner join entre las tablas club y uniforme local, donde la llave foránea es club id.Esta consulta nos permite ver el nombre del club y los colores principales y secundarios del uniforme local de cada club de la liga.

   **Consulta 7 - Presupuesto disponible para cada uno de los directores tecnicos.**
     Creamos una vista llamada Directores técnicos presupuesto en donde se creaba un inner join entre las tablas director técnico y club con llave foránea en el atributo id club. La vista nos permite ver el nombre, nacionalidad y presupuesto en miles de cada director técnico, luego haciendo un Rank y order by pudimos obtener el ranking del los directores técnicos que tienen mejores presupuestos , cómo lo es Juan Cruz Real con un presupuesto de 2413, Hernan Herrera con 2238 y Hernán Torres con 2148.
     
   **Consulta 8 - Jugadores más influyentes.**
     Creamos una vista llamada jugadores influyentes en donde se hace un producto cartesiano entre las tablas jugador y estadoisticas jugador, donde la llave foranea es id jugador y se selecciona los atributos nombre, id y puntos por partido de cada uno de los jugadores. Adicinalmente se creo un rank y orden by para que se seleccionaran los jugadores mas influyentes de todos los clubs.
     
**Visualización**
Las siguientes visualizaciones fueron creadas con Dash y con las consultas de la sección anterior  
Goleadores
    Consulta 1, ranking de los mejores goleadores de todos los clubs de la liga colombiana de fútbol.
    
    

Asistidores
    Consulta 2, ranking de los mejores asistidores de todos los clubs de la liga colombiana de fútbol.
    
  



