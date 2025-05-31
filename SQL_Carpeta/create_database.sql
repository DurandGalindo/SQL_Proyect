--Creación de la base de datos
CREATE DATABASE bd_banca_indicadores_diarios;
--Uso de la base de datos
USE bd_banca_indicadores_diarios;
--Creación de la tabla Sucursales
CREATE TABLE sucursal
(
	id_sucursal INT IDENTITY(1,1) ,
	codigo VARCHAR(10) UNIQUE NOT NULL,
	nombre VARCHAR(155) NOT NULL,
	ciudad VARCHAR(50) NOT NULL,
	region VARCHAR(100) NOT NULL,
	direccion VARCHAR(255) NOT NULL,
	estado VARCHAR(25) NOT NULL,
	telefono VARCHAR (25) NULL

	CONSTRAINT pk_id_sucursal PRIMARY KEY (id_sucursal),
	CONSTRAINT uniq_nombre UNIQUE (nombre)
);


--Creación de la tabla horas
CREATE TABLE horas
(
	id_horas INT IDENTITY (1,1),
	dia VARCHAR(25) NOT NULL,
	hora_inicio DATE NOT NULL,
	hora_final DATE NOT NULL

	CONSTRAINT pk_id_horas PRIMARY KEY (id_horas),
);


--Creación de la tabla responsables 
CREATE TABLE responsables 
(
	id_responsable INT IDENTITY (1,1),
	cod_empleado CHAR (6) UNIQUE NOT NULL,
	cargo VARCHAR (100) NOT NULL,
	unidad VARCHAR(100) NOT NULL,
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE NULL

	CONSTRAINT pk_id_responsable PRIMARY KEY (id_responsable),
	CONSTRAINT uniq_cod_empleado UNIQUE (cod_empleado)
);


--Creacion de la tabla horarios
CREATE TABLE horario
(
	id_horarios INT IDENTITY (1,1),
	id_horas int not null,
	estado VARCHAR(55) not null,
	fecha_registro DATETIME DEFAULT GETDATE (),
	CONSTRAINT pk_id_horarios PRIMARY KEY (id_horarios),
	CONSTRAINT fk_id_horas FOREIGN KEY (id_horas) REFERENCES horas(id_horas)
);


--Creacion de la tabla indicadores_horario
CREATE TABLE indicadores_horario (
  id_horario INT NOT NULL,
  id_indicador INT NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  PRIMARY KEY (id_horario, id_indicador),
  CONSTRAINT fk_id_horario FOREIGN KEY (id_horario) REFERENCES horario(id_horarios),
  CONSTRAINT fk_id_indicador FOREIGN KEY (id_indicador) REFERENCES indicadores(id_indicadores)
);


--Creacion de la tabla indicadores
CREATE TABLE indicadores
(
	id_indicadores INT IDENTITY (1,1),
	id_registros_diarios_interbancarios INT NOT NULL,
	id_sistema_fuente INT NOT NULL,
	nombre VARCHAR(225) NOT NULL,
	descripcion VARCHAR(MAX) ,
	unidad_medida VARCHAR(100) NOT NULL,
	categoría VARCHAR(100) NOT NULL,

	CONSTRAINT pk_id_indicadores PRIMARY KEY (id_indicadores),
	CONSTRAINT fk_id_registros_diarios_interbancarios FOREIGN KEY (id_registros_diarios_interbancarios) REFERENCES registros_diarios_interbancarios(id_registros_diarios_interbancarios),
	CONSTRAINT fk_id_sistema_fuente FOREIGN KEY (id_sistema_fuente) REFERENCES sistema_fuente(id_sistema_fuente)
);


--Creacion de la tabla registros_diarios_interbancarios
CREATE TABLE registros_diarios_interbancarios
(
	id_registros_diarios_interbancarios INT IDENTITY (1,1),
	id_sucursal INT NOT NULL,
	id_desviaciones_indicadores INT NOT NULL,
	valor_meta DECIMAL (9,2),
	valor_real DECIMAL (9,2) NOT NULL,
	fecha_reporte DATETIME NOT NULL,

	CONSTRAINT pk_id_registros_diarios_interbancarios PRIMARY KEY (id_registros_diarios_interbancarios),
	CONSTRAINT fk_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal),
	CONSTRAINT fk_id_desviaciones_indicadores FOREIGN KEY (id_desviaciones_indicadores) REFERENCES desviaciones_indicadores(id_desviaciones_indicadores)
);


--Creacion de la tabla desviaciones_indicadores
CREATE TABLE desviaciones_indicadores
(
	id_desviaciones_indicadores INT IDENTITY (1,1),
	diferencia_absoluta DECIMAL(9,2)  NOT NULL,
	diferencia_porcentual DECIMAL(9,2) NOT NULL,
	clasificacion VARCHAR (100) NOT NULL,
	CONSTRAINT pk_id_desviaciones_indicadores PRIMARY KEY (id_desviaciones_indicadores)
);


--Creacion de la tabla sistema_fuente
CREATE TABLE sistema_fuente
(
	id_sistema_fuente INT IDENTITY (1,1),
	id_responsable INT NOT NULL,
	nombre VARCHAR(155) NOT NULL,
	descripcion VARCHAR(MAX) NULL,
	area VARCHAR(100) NOT NULL,

	CONSTRAINT pk_id_sistema_fuente PRIMARY KEY (id_sistema_fuente),
	CONSTRAINT fk_id_responsable FOREIGN KEY (id_responsable) REFERENCES responsables(id_responsable)
);
