-- Base de datos para regidtro bibliográfico de Medellín
CREATE DATABASE BibliotecaMedellin

USE BibliotecaMedellin

-- Crear la tabla TIPOPUBLICACION
CREATE TABLE TipoPublicacion(
	Id int IDENTITY NOT NULL,
	Nombre varchar(50) NOT NULL,
	Descripcion varchar(100) NULL
)

ALTER TABLE TipoPublicacion
	ADD CONSTRAINT pk_TipoPublicacion_Id PRIMARY KEY(Id)

-- Crear índice de la tabla TIPOPUBLICACION
CREATE UNIQUE INDEX ix_TipoPublicacion_Nombre
	ON TipoPublicacion(Nombre)


-- Crear la tabla CIUDAD
CREATE TABLE Ciudad(
	Id int IDENTITY NOT NULL,
	CONSTRAINT pk_Ciudad_Id PRIMARY KEY(Id),
	Nombre varchar(50) NOT NULL,
	Departamento varchar (50) NOT NULL
)

-- Crear índice de la tabla CIUDAD
CREATE UNIQUE INDEX ix_Ciudad_Nombre
	ON Ciudad(Nombre)


-- Crear la tabla EDITORIAL
CREATE TABLE Editorial(
	Id int IDENTITY NOT NULL,
	CONSTRAINT pk_Editorial_Id PRIMARY KEY(Id),
	Nombre varchar(100) NOT NULL,
	IdCiudad int NOT NULL,
	CONSTRAINT fk_Editorial_IdCiudad FOREIGN KEY(IdCiudad) REFERENCES Ciudad(Id)
)

-- Crear índice de la tabala EDITORIAL
CREATE UNIQUE INDEX ix_Editorial_Nombre
	ON Editorial(Nombre)


-- Crear la tabla AUTOR
CREATE TABLE Autor(
	Id int IDENTITY NOT NULL,
	CONSTRAINT pk_Autor_Id PRIMARY KEY(Id),
	Nombre varchar(100) NOT NULL,
	Apellido varchar(100) NOT NULL,
	EsCorporativo bit NOT NULL DEFAULT 0
)

-- Crear índice de la tabla AUTOR
CREATE UNIQUE INDEX ix_Autor_Nombre
	ON Autor(Nombre, Apellido)


-- Crear la tabla PUBLICACION
CREATE TABLE Publicacion(
	Id int IDENTITY NOT NULL,
	CONSTRAINT pk_Publicación_Id PRIMARY KEY(Id),
	Titulo varchar(200) NOT NULL,
	Año int NULL,
	NumeroVolumen int NULL,
	ISBN varchar(20) NULL,
	IdTipoPublicacion int NOT NULL,
	IdEditorial int NOT NULL,
	CONSTRAINT fk_Publicacion_IdTipoPublicacion
		FOREIGN KEY(IdTipoPublicacion) REFERENCES TipoPublicacion(Id),
	CONSTRAINT fk_Publicacion_IdEditorial
		FOREIGN KEY(IdEditorial) REFERENCES Editorial(Id)
)

-- Crear índice de la tabla PUBLICACION
CREATE INDEX ix_Publicacion_Titulo
	ON Publicacion(Titulo)


-- Crear tabla PUBLICACIONAUTOR (para la relación de uno al otro)
CREATE TABLE PublicacionAutor(
	IdPublicacion int NOT NULL,
	CONSTRAINT fk_PublicacionAutor_IdPublicacion
		FOREIGN KEY(IdPublicacion) REFERENCES Publicacion(Id),
	IdAutor int NOT NULL,
	CONSTRAINT fk_PublicacionAutor_IdAutor
		FOREIGN KEY(IdAutor) REFERENCES Autor(Id),
	CONSTRAINT pk_PublicacionAutor
		PRIMARY KEY(IdPublicacion, IdAutor)
)


