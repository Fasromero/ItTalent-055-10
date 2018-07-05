/*
########  ######## ##       ########    ###       ######## #### ########  ########  ######  ####    ###     ######        ###    ##       ########    ###    
##     ## ##       ##          ##      ## ##         ##     ##  ##     ## ##       ##    ##  ##    ## ##   ##    ##      ## ##   ##       ##         ## ##   
##     ## ##       ##          ##     ##   ##        ##     ##  ##     ## ##       ##        ##   ##   ##  ##           ##   ##  ##       ##        ##   ##  
##     ## ######   ##          ##    ##     ##       ##     ##  ########  ######    ######   ##  ##     ##  ######     ##     ## ##       ######   ##     ## 
##     ## ##       ##          ##    #########       ##     ##  ##   ##   ##             ##  ##  #########       ##    ######### ##       ##       ######### 
##     ## ##       ##          ##    ##     ##       ##     ##  ##    ##  ##       ##    ##  ##  ##     ## ##    ##    ##     ## ##       ##       ##     ## 
########  ######## ########    ##    ##     ##       ##    #### ##     ## ########  ######  #### ##     ##  ######     ##     ## ######## ##       ##     ## 
*/
--*******************************************************
--	SCRIPT CREACIÓN OBJETOS DE BASE DE DATOS
--	CIUDAD ACCESIBLE Y HUMANA
--	CREADO		: 05-07-2018
--	AUTORES		: ADRIANA IBAÑEZ / JUAN OBANDO
--	MODIFCIADO	: 
--*******************************************************

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('FK_TB_RUTA_REFERENCIADA_TB_ACCIONES') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1)
ALTER TABLE TB_RUTA_REFERENCIADA DROP CONSTRAINT FK_TB_RUTA_REFERENCIADA_TB_ACCIONES
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('FK_TB_RUTA_REFERENCIADA_TB_REFERENCIAS') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1)
ALTER TABLE TB_RUTA_REFERENCIADA DROP CONSTRAINT FK_TB_RUTA_REFERENCIADA_TB_REFERENCIAS
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('FK_TB_RUTA_REFERENCIADA_TB_RUTAS') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1)
ALTER TABLE TB_RUTA_REFERENCIADA DROP CONSTRAINT FK_TB_RUTA_REFERENCIADA_TB_RUTAS
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('FK_TB_RUTAS_TB_USUARIOS') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1)
ALTER TABLE TB_RUTAS DROP CONSTRAINT FK_TB_RUTAS_TB_USUARIOS
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('FK_TB_USUARIOS_TB_PERFILES') AND OBJECTPROPERTY(id, 'IsForeignKey') = 1)
ALTER TABLE TB_USUARIOS DROP CONSTRAINT FK_TB_USUARIOS_TB_PERFILES
GO


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('TB_ACCIONES') AND  OBJECTPROPERTY(id, 'IsUserTable') = 1)
DROP TABLE TB_ACCIONES
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('TB_PERFILES') AND  OBJECTPROPERTY(id, 'IsUserTable') = 1)
DROP TABLE TB_PERFILES
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('TB_REFERENCIAS') AND  OBJECTPROPERTY(id, 'IsUserTable') = 1)
DROP TABLE TB_REFERENCIAS
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('TB_RUTA_REFERENCIADA') AND  OBJECTPROPERTY(id, 'IsUserTable') = 1)
DROP TABLE TB_RUTA_REFERENCIADA
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('TB_RUTAS') AND  OBJECTPROPERTY(id, 'IsUserTable') = 1)
DROP TABLE TB_RUTAS
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id('TB_USUARIOS') AND  OBJECTPROPERTY(id, 'IsUserTable') = 1)
DROP TABLE TB_USUARIOS
GO




CREATE TABLE TB_ACCIONES ( 
	ID_ACCION int NOT NULL,
	DESCRIPCION_ACCION varchar(200),
	ESTADO bit
)
GO

CREATE TABLE TB_PERFILES ( 
	ID_PERFIL int NOT NULL,
	DESCRIPCION_PERFIL varchar(300),
	ESTADO bit
)
GO

CREATE TABLE TB_REFERENCIAS ( 
	ID_REFERENCIA int NOT NULL,
	DESCRIPCION_REFERENCIA varchar(100),
	ESTADO bit
)
GO

CREATE TABLE TB_RUTA_REFERENCIADA ( 
	ID_RUTA_REFERENCIADA int NOT NULL,
	POSICION_GPS bigint,
	ID_ACCION int,
	ID_RUTA int,
	ID_REFERENCIA int
)
GO

CREATE TABLE TB_RUTAS ( 
	ID_RUTA int NOT NULL,
	NOMBRE_RUTA varchar(100),
	FECHA_CREACION datetime,
	ESTADO bit,
	ID_USUARIO int
)
GO

CREATE TABLE TB_USUARIOS ( 
	ID_USUARIO int NOT NULL,
	NOMBRE_USUARIO varchar(200),
	CONTRASENA varchar(20),
	FECHA_CREACION datetime,
	ID_PERFIL int
)
GO


ALTER TABLE TB_ACCIONES ADD CONSTRAINT PK_TB_ACCIONES 
	PRIMARY KEY CLUSTERED (ID_ACCION)
GO

ALTER TABLE TB_PERFILES ADD CONSTRAINT PK_TB_PERFILES 
	PRIMARY KEY CLUSTERED (ID_PERFIL)
GO

ALTER TABLE TB_REFERENCIAS ADD CONSTRAINT PK_TB_REFERENCIAS 
	PRIMARY KEY CLUSTERED (ID_REFERENCIA)
GO

ALTER TABLE TB_RUTA_REFERENCIADA ADD CONSTRAINT PK_TB_RUTA_REFERENCIADA 
	PRIMARY KEY CLUSTERED (ID_RUTA_REFERENCIADA)
GO

ALTER TABLE TB_RUTAS ADD CONSTRAINT PK_TB_RUTAS 
	PRIMARY KEY CLUSTERED (ID_RUTA)
GO

ALTER TABLE TB_USUARIOS ADD CONSTRAINT PK_TB_USUARIOS 
	PRIMARY KEY CLUSTERED (ID_USUARIO)
GO



ALTER TABLE TB_RUTA_REFERENCIADA ADD CONSTRAINT FK_TB_RUTA_REFERENCIADA_TB_ACCIONES 
	FOREIGN KEY (ID_ACCION) REFERENCES TB_ACCIONES (ID_ACCION)
GO

ALTER TABLE TB_RUTA_REFERENCIADA ADD CONSTRAINT FK_TB_RUTA_REFERENCIADA_TB_REFERENCIAS 
	FOREIGN KEY (ID_REFERENCIA) REFERENCES TB_REFERENCIAS (ID_REFERENCIA)
GO

ALTER TABLE TB_RUTA_REFERENCIADA ADD CONSTRAINT FK_TB_RUTA_REFERENCIADA_TB_RUTAS 
	FOREIGN KEY (ID_RUTA) REFERENCES TB_RUTAS (ID_RUTA)
GO

ALTER TABLE TB_RUTAS ADD CONSTRAINT FK_TB_RUTAS_TB_USUARIOS 
	FOREIGN KEY (ID_USUARIO) REFERENCES TB_USUARIOS (ID_USUARIO)
GO

ALTER TABLE TB_USUARIOS ADD CONSTRAINT FK_TB_USUARIOS_TB_PERFILES 
	FOREIGN KEY (ID_PERFIL) REFERENCES TB_PERFILES (ID_PERFIL)
GO
