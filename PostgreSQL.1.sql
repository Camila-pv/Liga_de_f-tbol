CREATE TABLE Club(
  id integer PRIMARY KEY,
  nombre varchar(30) NOT NULL,
  ciudad VARCHAR(30),
  pais VARCHAR(30),
  presupuesto INTEGER
);

CREATE TABLE Jugador(
  ID INTEGER PRIMARY KEY,
  edad SMALLINT,
  altura DECIMAL,
  peso DECIMAL,
  nacionalidad VARCHAR(30),
  nombre VARCHAR(30) not NULL,
  valor_mercado INTEGER,
  ID_club INTEGER REFERENCES Club(id)
);

CREATE TABLE Director_tecnico(
  ID INTEGER NOT NULL,
  nacionalidad VARCHAR(30),
  edad SMALLINT,
  nombre VARCHAR(30) NOT NULL,
  ID_CLUB INTEGER REFERENCES Club(id),
  PRIMARY key(id,nombre)
);

CREATE TABLE Entrenador(
  id INTEGER NOT NULL,
  area VARCHAR(30),
  nombre VARCHAR(30) NOT NULL,
  ID_club INTEGER REFERENCES Club(id),
  PRIMARY KEY(ID, nombre)
);

CREATE TABLE Posicion(
  ID_jugador INTEGER REFERENCES Jugador(id),
  Defensa VARCHAR(30),
  Portero VARCHAR(30),
  MedioCampista VARCHAR(30),
  Delantero VARCHAR(30)
);

CREATE TABLE Equipacion(
  numero_equipo SMALLINT,
  color_primario VARCHAR(30),
  color_secundario VARCHAR(30),
  numero_camiseta SMALLINT,
  ID_jugador INTEGER REFERENCES Jugador(id),
  talla SMALLINT,
  nombre_espalda VARCHAR(15),
  PRIMARY KEY(numero_camiseta)
);

CREATE TABLE Estadio(
  ID_club INTEGER REFERENCES Club(id),
  capacidad INTEGER,
  nombre VARCHAR(50),
  PRIMARY KEY(nombre)
);

CREATE TABLE Patrocinadores(
  ID_club INTEGER REFERENCES Club(id),
  marca VARCHAR(30),
  PRIMARY KEY(marca)
);

CREATE TABLE Estadisticas_jugador(
  ID_jugador INTEGER REFERENCES Jugador(id),
  goles SMALLINT,
  asistencias SMALLINT,
  porcentaje_pases SMALLINT,
  minutos_jugados INTEGER,
  tarjetas_amarillas SMALLINT,
  tarjetas_rojas SMALLINT,
  camisetas_vendidas INTEGER,
  porteria_imbatida SMALLINT,
  PRIMARY KEY(ID_jugador)
);

CREATE TABLE Estadisticas_Club(
  id_club INTEGER REFERENCES Club(ID),
  partidas_jugadas INTEGER,
  victorias INTEGER,
  empates INTEGER,
  derrotas INTEGER,
  goles_a_favor INTEGER,
  goles_en_conntra INTEGER
);

CREATE TABLE Liga(
  id_club INTEGER REFERENCES Club(ID),
  division INTEGER,
  pais varchar(30),
  confederacion VARCHAR(30)
);

CREATE TABLE Equipo_medico(
  id_club INTEGER REFERENCES Club(ID),
  especializacion VARCHAR(30),
  id integer PRIMARY KEY
);

CREATE TABLE Utileria(
  id_club integer REFERENCES Club(ID),
  id INTEGER PRIMARY KEY,
  nombre VARCHAR(15),
  area varchar(15)
);

CREATE TABLE Titulares(
  id_jugador INTEGER REFERENCES Jugador(ID),
  id INTEGER PRIMARY KEY,
  nombre_jugador VARCHAR(15) NOT NULL
);

CREATE TABLE Alineacion(
  id_jugadores_iniciales INTEGER,
  id_jugadoores_suplentes INTEGER,
  formacion varchar(30),
  id_tactica_ataque INTEGER,
  id_tactica_defensiva INTEGER
);

CREATE TABLE Suplentes(
  id_jugador INTEGER REFERENCES Jugador(id),
  id INTEGER PRIMARY KEY,
  nombre_jugador VARCHAR(15) NOT NULL
);


--INSERSIONES 
iNSERT into club(ID, nombre, ciudad, pais, presupuesto)
	Values(1001,'CD América de Cali','Cali', 'Colombia', 15000000),
    (1002,'Millonarios FC','Bogotá ', 'Colombia', 19000000),
    (1003,'Junior de Barranquilla','Barranquilla', 'Colombia', 24000000),
    (1004,'Deportes Tolima','Ibagué', 'Colombia', 22000000),
    (1005,'Atlético Nacional','Medellín', 'Colombia', 22000000),
    (1006,'Independiente Medellín','Medellín', 'Colombia', 15000000),
    (1007,'Deportivo Cali','Cali', 'Colombia', 14000000),
    (1008,'Independiente Santa Fe','Bogotá', 'Colombia', 14000000),
    (1009,'Once Caldas','Manizales', 'Colombia', 11000000),
    (1010,'Alianza Petrolera','Barrancabermeja ', 'Colombia', 9000000),
    (1011,'CD La Equidad Seguros SA','Bogotá', 'Colombia', 9000000),
    (1012,'Águilas Doradas','Rio negro', 'Colombia', 9000000),
    (1013,'Atlético Bucaramanga','Bucaramanga', 'Colombia', 8000000),
    (1014,'Jaguares de Córdoba','Cordoba', 'Colombia', 8000000),
    (1015,'Deportivo Pereira','Pereira', 'Colombia', 8000000),
    (1016,'Asociación Deportivo Pasto','Pasto', 'Colombia', 7000000),
    (1017,'Envigado FC','Envigado', 'Colombia', 6000000),
    (1018,'Cortuluá ','Cortuluá ', 'Colombia', 5000000),
    (1019,'Boyacá Patriotas FC','Patriotas', 'Colombia', 5000000),
    (1020,'AD Unión Magdalena','Santa Marta', 'Colombia', 4000000);
    

--TRIGGERS
create table users(
  id serial PRIMARY KEY,
  username TEXT not NULL,
  display_name text not NULL,
  tag_line text NULL
 );
 
create table user_change_log(
  entry_time TIMESTAMP with time zone,
  entry users
 );
 
create function log_user_change()
	returns TRIGGER
    language 'plpgsql'
as $$
begin 
	if new <> old then 
    	INSERT into user_change_log(entry_time,entry)
        	VALUES(now(),new);
    end IF;
    return NEW;
END;
$$;

create trigger user_changes
AFTER UPDATE on users
for each ROW
EXECUTE PROCEDURE log_user_change();

create table change_estadisticas(
  id SMALLINT not NULL,
  name VARCHAR(40) not NULL,
  users VARCHAR(40) not NULL,
  date TIMESTAMP with time zone
);

create or replace function insercion_estadisticas()
	returns trigger
    LANGUAGE 'plpgsql'
AS $$
begin 
	insert into change_estadisticas(id,name,users,date)
    	values(new.id,new.name,CURRENT_USER,now());
    return NEW;
END;
$$;

create trigger registro_estadisticas
	after insert 
    on estadisticas_jugador
    for each ROW
    EXECUTE FUNCTION insercion_estadisticas();
    
