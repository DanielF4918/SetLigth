CREATE DATABASE SetLight;
GO

USE SetLight;
GO

-- Tabla Roles
CREATE TABLE Roles (
    IdRol INT PRIMARY KEY IDENTITY(1,1),
    NombreRol NVARCHAR(100) NOT NULL
);

-- Tabla Usuarios
CREATE TABLE Usuarios (
    IdUsuario INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Apellido NVARCHAR(100) NOT NULL,
    Correo NVARCHAR(100) NOT NULL,
    Contrasenia NVARCHAR(100) NOT NULL,
    IdRol INT FOREIGN KEY REFERENCES Roles(IdRol)
);

-- Tabla Clientes
CREATE TABLE Clientes (
    IdCliente INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Apellido NVARCHAR(100) NOT NULL,
    Telefono NVARCHAR(20),
    Correo NVARCHAR(100)
);

-- Tabla estadoOrdenAlquiler
CREATE TABLE estadoOrdenAlquiler (
    IdEstadoOrden INT PRIMARY KEY IDENTITY(1,1),
    NombreEstado NVARCHAR(100) NOT NULL
);

-- Tabla OrdenAlquiler
CREATE TABLE OrdenAlquiler (
    IdOrden INT PRIMARY KEY IDENTITY(1,1),
    FechaOrden DATE NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFinal DATE NOT NULL,
    IdEstadoOrden INT FOREIGN KEY REFERENCES estadoOrdenAlquiler(IdEstadoOrden),
    IdCliente INT FOREIGN KEY REFERENCES Clientes(IdCliente)
);

-- Tabla DetalleOrden
CREATE TABLE DetalleOrden (
    IdDetalle INT PRIMARY KEY IDENTITY(1,1),
    IdOrden INT FOREIGN KEY REFERENCES OrdenAlquiler(IdOrden),
    IdEquipo INT,
    Cantidad INT NOT NULL
);

-- Tabla CategoriaEquipos
CREATE TABLE CategoriaEquipos (
    IdCategoria INT PRIMARY KEY IDENTITY(1,1),
    NombreCategoria NVARCHAR(100) NOT NULL
);

-- Tabla EstadoEquipos
CREATE TABLE EstadoEquipos (
    IdEstado INT PRIMARY KEY IDENTITY(1,1),
    NombreEstado NVARCHAR(100) NOT NULL
);

-- Tabla Equipos
CREATE TABLE Equipos (
    IdEquipo INT PRIMARY KEY IDENTITY(1,1),
    NombreEquipo NVARCHAR(100) NOT NULL,
    Marca NVARCHAR(100),
    Modelo NVARCHAR(100),
    Serie NVARCHAR(100),
    Descripcion NVARCHAR(MAX),
    IdCategoria INT FOREIGN KEY REFERENCES CategoriaEquipos(IdCategoria),
    IdEstado INT FOREIGN KEY REFERENCES EstadoEquipos(IdEstado)
);

-- Agregar FK en DetalleOrden para IdEquipo después de crear Equipos
ALTER TABLE DetalleOrden ADD CONSTRAINT FK_DetalleOrden_Equipos FOREIGN KEY (IdEquipo) REFERENCES Equipos(IdEquipo);

-- Tabla HistorialEquipo
CREATE TABLE HistorialEquipo (
    IdHistorial INT PRIMARY KEY IDENTITY(1,1),
    IdEquipo INT FOREIGN KEY REFERENCES Equipos(IdEquipo),
    FechaCambio DATE NOT NULL,
    Observaciones NVARCHAR(MAX)
);

-- Tabla TipoMantenimiento
CREATE TABLE TipoMantenimiento (
    IdTipoMantenimiento INT PRIMARY KEY IDENTITY(1,1),
    NombreTipo NVARCHAR(100) NOT NULL
);

-- Tabla EstadoMantenimiento
CREATE TABLE EstadoMantenimiento (
    IdEstadoMantenimiento INT PRIMARY KEY IDENTITY(1,1),
    NombreEstado NVARCHAR(100) NOT NULL
);

-- Tabla Mantenimiento
CREATE TABLE Mantenimiento (
    IdMantenimiento INT PRIMARY KEY IDENTITY(1,1),
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    IdTipoMantenimiento INT FOREIGN KEY REFERENCES TipoMantenimiento(IdTipoMantenimiento),
    IdEstadoMantenimiento INT FOREIGN KEY REFERENCES EstadoMantenimiento(IdEstadoMantenimiento),
    IdEquipo INT FOREIGN KEY REFERENCES Equipos(IdEquipo)
);
