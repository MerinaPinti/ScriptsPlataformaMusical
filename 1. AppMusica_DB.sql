--USE master
--ALTER DATABASE PlataformaMusical SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
--DROP DATABASE PlataformaMusical;

-- Crear la base de datos
CREATE DATABASE PlataformaMusical;
GO

USE PlataformaMusical;
GO

-- Tabla: PAISES
CREATE TABLE Paises (
    IdPais TINYINT IDENTITY(1,1) PRIMARY KEY,
    Pais VARCHAR(100) NOT NULL
);
GO

-- Tabla: METODOS DE PAGO
CREATE TABLE MetodosPago (
    IdMetodoPago TINYINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(100) NOT NULL
);
GO

-- Tabla: TIPOS DE CUENTA
CREATE TABLE TiposCuenta (
    IdTipoCuenta TINYINT PRIMARY KEY NOT NULL IDENTITY(1,1),
    Descripcion VARCHAR(100) NOT NULL,
    Monto DECIMAL(12, 2) NOT NULL CHECK (Monto >= 0)
);
GO

-- Tabla: USUARIOS
CREATE TABLE Usuarios (
    IDUsuario INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    Apellido NVARCHAR(50) NOT NULL,
    IdPais TINYINT NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Contraseña NVARCHAR(255) NOT NULL, -- HASHEADA
	Salt NVARCHAR(255) NOT NULL, -- HASHEADA
    FechaNacimiento DATE NOT NULL,
    FechaAlta DATE NOT NULL DEFAULT GETDATE(),
	EsAdmin BIT DEFAULT 0,
	Activo BIT DEFAULT 1
	--IdTipoCuenta INT NOT NULL
    FOREIGN KEY (IdPais) REFERENCES Paises(IdPais)
);
GO

-- Tabla: GENEROS
CREATE TABLE Generos (
    IdGenero TINYINT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Descripcion VARCHAR(100) NOT NULL
);
GO

-- Tabla: ARTISTAS
CREATE TABLE Artistas (
    IDArtista INT IDENTITY PRIMARY KEY, 
    NombreArtistico NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(255),
    IdPais TINYINT NOT NULL,
    IdGenero TINYINT NOT NULL,
	ImagenArtista NVARCHAR(255) DEFAULT 'https://media.istockphoto.com/id/1409329028/es/vector/no-hay-imagen-disponible-marcador-de-posici%C3%B3n-miniatura-icono-dise%C3%B1o-de-ilustraci%C3%B3n.jpg?s=612x612&w=0&k=20&c=Bd89b8CBr-IXx9mBbTidc-wu_gtIj8Py_EMr3hGGaPw=',
    IDUsuario INT NULL, -- Si tiene ID es Usuario y artista, si es NULL es solo ARTISTA
    FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario),
    FOREIGN KEY (IdGenero) REFERENCES Generos(IdGenero),
    FOREIGN KEY (IdPais) REFERENCES Paises(IdPais)
);
GO

-- Tabla: ALBUMES
CREATE TABLE Albumes (
    IDAlbum INT IDENTITY PRIMARY KEY,
    Titulo NVARCHAR(100) NOT NULL,
    Anio SMALLINT CHECK (Anio >= 1900),
    IDArtista INT NOT NULL,
    ImagenPortada NVARCHAR(255) DEFAULT 'https://media.istockphoto.com/id/1409329028/es/vector/no-hay-imagen-disponible-marcador-de-posici%C3%B3n-miniatura-icono-dise%C3%B1o-de-ilustraci%C3%B3n.jpg?s=612x612&w=0&k=20&c=Bd89b8CBr-IXx9mBbTidc-wu_gtIj8Py_EMr3hGGaPw=',
    FOREIGN KEY (IDArtista) REFERENCES Artistas(IDArtista)
);
GO

-- Tabla: CANCIONES
CREATE TABLE Canciones (
    IDCancion INT IDENTITY PRIMARY KEY,
    Titulo NVARCHAR(100) NOT NULL,
    Duracion SMALLINT CHECK (Duracion > 0), -- duración en segundos
    IdGenero TINYINT NOT NULL,
    IDAlbum INT NOT NULL,
    RutaArchivo NVARCHAR(255) NOT NULL,
    FOREIGN KEY (IDAlbum) REFERENCES Albumes(IDAlbum),
    FOREIGN KEY (IdGenero) REFERENCES Generos(IdGenero)
);
GO

-- Tabla: LISTAS DE REPRODUCCIÓN
CREATE TABLE ListasReproduccion (
    IDLista INT IDENTITY PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    FechaCreacion DATE NOT NULL DEFAULT GETDATE(),
    IDUsuario INT NOT NULL,
    FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario)
);
GO

-- Tabla: CANCION-LISTA (relación muchos a muchos)
CREATE TABLE CancionListas (
    IDLista INT NOT NULL,
    IDCancion INT NOT NULL,
    Orden SMALLINT CHECK (Orden > 0),
    PRIMARY KEY (IDLista, IDCancion),
    FOREIGN KEY (IDLista) REFERENCES ListasReproduccion(IDLista),
    FOREIGN KEY (IDCancion) REFERENCES Canciones(IDCancion)
);
GO

-- Tabla: DISPOSITIVOS
CREATE TABLE Dispositivos (
    IdDispositivo TINYINT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Dispositivo VARCHAR(50) NOT NULL
);
GO

-- Tabla: REPRODUCCIONES
CREATE TABLE Reproducciones (
    IDReproduccion INT IDENTITY PRIMARY KEY,
    IDUsuario INT NOT NULL,
    IDCancion INT NOT NULL,
    FechaHora DATETIME NOT NULL DEFAULT GETDATE(),
    IdDispositivo TINYINT NOT NULL,
    FOREIGN KEY (IDUsuario) REFERENCES Usuarios(IDUsuario),
    FOREIGN KEY (IDCancion) REFERENCES Canciones(IDCancion),
    FOREIGN KEY (IdDispositivo) REFERENCES Dispositivos(IdDispositivo)
);
GO

-- Tabla: SUSCRIPCIONES
CREATE TABLE Suscripciones (
    IDSuscripcion INT IDENTITY PRIMARY KEY,
    IdUsuario INT NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE,
    IdMetodoPago TINYINT NOT NULL,
    IdTipoCuenta TINYINT NOT NULL,
    FOREIGN KEY (IdMetodoPago) REFERENCES MetodosPago(IdMetodoPago),
    FOREIGN KEY (IdTipoCuenta) REFERENCES TiposCuenta(IdTipoCuenta),
    FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IDUsuario)
);

