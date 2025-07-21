


USE PlataformaMusical

/***************************** VISTAS **********************************/

--		VISTA 1		--
-- 🎯 Vista VW_CancionesDetalles
GO
CREATE OR ALTER VIEW VW_CancionesDetalles AS
SELECT 
    C.IDCancion,
    C.Titulo,
    C.Duracion,
    C.RutaArchivo,
    G.Descripcion AS Genero,
    G.IdGenero,
    AR.NombreArtistico,
    AL.Titulo AS Album,
    AL.IDAlbum, --
    AL.ImagenPortada
FROM Canciones c
INNER JOIN Albumes AL ON C.IDAlbum = AL.IDAlbum
INNER JOIN Artistas AR ON AL.IDArtista = AR.IDArtista
INNER JOIN Generos G ON C.IdGenero = G.IdGenero;
---------------------------------------------------------------------------------------------------------------------------

--		VISTA 2		--
--👥 Vista VW_UsuariosDetalles
GO
CREATE OR ALTER VIEW VW_UsuariosDetalles AS
SELECT
    U.IDUsuario,
    U.Nombre,
    U.Apellido,
    U.Email,
    U.Contraseña,
    U.Salt,
    U.IdPais,
    P.Pais,
    U.FechaNacimiento,
    U.FechaAlta,
    U.EsAdmin,
    U.Activo
FROM Usuarios U
INNER JOIN Paises P ON U.IdPais = P.IdPais;
---------------------------------------------------------------------------------------------------------------------------

--		VISTA 3		--
--🧾 Vista vw_HistorialSuscripciones
GO
CREATE OR ALTER VIEW vw_HistorialSuscripciones AS
SELECT
    S.IdUsuario,
    U.Nombre,
    TC.Descripcion AS TipoCuenta,
    MP.Descripcion AS MetodoPago,
    S.FechaInicio,
    S.FechaFin,
    S.IDSuscripcion
FROM Suscripciones S
JOIN Usuarios U ON S.IdUsuario = U.IdUsuario
JOIN TiposCuenta TC ON S.IdTipoCuenta = TC.IdTipoCuenta
JOIN MetodosPago MP ON S.IdMetodoPago = MP.IdMetodoPago;
---------------------------------------------------------------------------------------------------------------------------


--		VISTA 4		--
--🧾 Vista vw_ReproduccionesDetalles
GO
CREATE OR ALTER VIEW vw_ReproduccionesDetalles AS
SELECT
    R.IDReproduccion,
    R.IDUsuario,
    U.Nombre + ' ' + U.Apellido AS NombreUsuario,
    R.FechaHora,
    D.IdDispositivo,
    D.Dispositivo,
    C.IDCancion,
    C.Titulo AS Cancion,
    C.Duracion,
    A.Titulo AS Album,
    AR.NombreArtistico AS Artista,
    G.Descripcion AS Genero
FROM Reproducciones R
INNER JOIN Usuarios U ON R.IDUsuario = U.IDUsuario
INNER JOIN Canciones C ON R.IDCancion = C.IDCancion
INNER JOIN Albumes A ON C.IDAlbum = A.IDAlbum
INNER JOIN Artistas AR ON A.IDArtista = AR.IDArtista
INNER JOIN Generos G ON C.IdGenero = G.IdGenero
INNER JOIN Dispositivos D ON R.IdDispositivo = D.IdDispositivo;
---------------------------------------------------------------------------------------------------------------------------

/***************************** PROCEDIMIENTOS ALMACENADOS **********************************/

--		SP 1		--
-- SP Utilizado en FormHistorialSuscripciones en el metodo ListarHistorial(int IdUsuario)

GO
CREATE OR ALTER PROCEDURE sp_ObtenerHistorialSuscripciones
    @IdUsuario INT
AS
BEGIN
    BEGIN TRY
        SELECT * 
        FROM vw_HistorialSuscripciones
        WHERE IdUsuario = @IdUsuario
        ORDER BY IDSuscripcion DESC;
    END TRY
    BEGIN CATCH
        RAISERROR('No se pudo obtener el historial de suscripciones del usuario.', 16, 1);
    END CATCH
END;
---------------------------------------------------------------------------------------------------------------------------

--		SP 2		--
-- SP Utilizado en FormAltaUsuario - FormRegistro

GO
CREATE OR ALTER PROCEDURE sp_AltaUsuarioConSuscripcion
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Email NVARCHAR(100),
    @Contrasena NVARCHAR(255),
    @Salt NVARCHAR(255),
    @IdPais TINYINT,
    @FechaNacimiento DATE,
    @IdMetodoPago TINYINT,
    @IdTipoCuenta TINYINT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;	
        DECLARE @NuevoIdUsuario INT;
        INSERT INTO Usuarios (Nombre, Apellido, Email, Contraseña, IdPais, FechaNacimiento, FechaAlta, Salt, EsAdmin)
        VALUES (@Nombre, @Apellido, @Email, @Contrasena, @IdPais, @FechaNacimiento, GETDATE(), @Salt, 0); 		
        SET @NuevoIdUsuario = SCOPE_IDENTITY(); 	
        IF @IdMetodoPago = 5 AND @IdTipoCuenta = 3	
        BEGIN
            INSERT INTO Suscripciones (IdUsuario, FechaInicio, FechaFin, IdMetodoPago, IdTipoCuenta)
            VALUES (@NuevoIdUsuario, GETDATE(), NULL, @IdMetodoPago, @IdTipoCuenta); 
        END
        ELSE
        BEGIN
            INSERT INTO Suscripciones (IdUsuario, FechaInicio, FechaFin, IdMetodoPago, IdTipoCuenta)
            VALUES (@NuevoIdUsuario, GETDATE(), DATEADD(DAY, 30, GETDATE()), @IdMetodoPago, @IdTipoCuenta);
        END
        COMMIT TRANSACTION;         
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        RAISERROR('No se pudo registrar al usuario.', 16, 1); 
    END CATCH
END;

---------------------------------------------------------------------------------------------------------------------------

--		SP 3		--
-- SP Utilizado en FormEditarUsuario --.

GO
CREATE OR ALTER PROCEDURE sp_ModificarUsuario
    @IdUsuario INT,
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Email NVARCHAR(100),
    @IdPais TINYINT,
    @FechaNacimiento DATE,
    @Activo BIT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        UPDATE Usuarios
        SET
            Nombre = @Nombre,
            Apellido = @Apellido,
            Email = @Email,
            IdPais = @IdPais,
            FechaNacimiento = @FechaNacimiento,
            Activo = @Activo
        WHERE IdUsuario = @IdUsuario;		
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0			
            ROLLBACK TRANSACTION;
        RAISERROR('No se pudo actualizar la informacion del usuario.', 16, 1);
    END CATCH
END;
---------------------------------------------------------------------------------------------------------------------------

--		SP 4		--
	--🧠 Descripción funcional — Procedimiento sp_ActualizarEstadoSuscripcion

GO
CREATE OR ALTER PROCEDURE sp_ActualizarEstadoSuscripcion
    @idUser INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        IF NOT EXISTS (
            SELECT 1
            FROM Suscripciones
            WHERE IdUsuario = @idUser
            AND (FechaFin IS NULL OR FechaFin > GETDATE())
        )
        BEGIN
            INSERT INTO Suscripciones (IdUsuario, FechaInicio, FechaFin, IdMetodoPago, IdTipoCuenta)
            VALUES (@idUser, GETDATE(), NULL, 5, 3);
        END
		-- TRANSACCION EXITOSA
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        RAISERROR('No se pudo actualizar el estado de suscripción del usuario.', 16, 1);
    END CATCH
END;
--------------------------------------------------------------------------------------------------

/***************************** TRIGGERS **********************************/

--		TRIGGER 1		-- SP 2 y 4 Implicados
GO
CREATE OR ALTER TRIGGER trg_CerrarSuscripcionAnterior
ON Suscripciones
AFTER INSERT
AS
BEGIN
    UPDATE Suscripciones               
    SET FechaFin = GETDATE()                          
    WHERE IdUsuario IN (SELECT IdUsuario FROM INSERTED)                       
      AND IdSuscripcion NOT IN (SELECT IdSuscripcion FROM INSERTED)                                
	  AND (FechaFin IS NULL OR FechaFin > GETDATE()); 
END;
--------------------------------------------------------------------------------------------------

--		TRIGGER 2		--
	--🧠 Descripción funcional — Trigger trg_ValidarEliminacionUsuario

GO
CREATE OR ALTER TRIGGER trg_ValidarEliminacionUsuario      
ON Usuarios                                       
INSTEAD OF DELETE          
AS
BEGIN
    IF EXISTS (                  
        SELECT 1
        FROM DELETED D      
        JOIN Suscripciones S ON D.IDUsuario = S.IdUsuario 
        WHERE S.FechaFin > GETDATE()                     
    )
    BEGIN
        
		RAISERROR('No se puede dar de baja a un usuario que posee una suscripcion paga aun vigente.', 16, 1);
    END
    ELSE
    BEGIN
		UPDATE Usuarios                                       
        SET Activo = 0
        WHERE IDUsuario IN (SELECT IDUsuario FROM DELETED); 

    END
END;              