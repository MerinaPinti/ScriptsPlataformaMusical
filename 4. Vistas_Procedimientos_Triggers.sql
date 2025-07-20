


USE PlataformaMusical

/***************************** VISTAS **********************************/

--		VISTA 1		--
-- 🎯 Vista VW_CancionesDetalles: qué es, para qué sirve y por qué fue útil 
-- La vista VW_CancionesDetalles se creó para unificar en una sola consulta toda la información relevante
-- de cada canción, incluyendo su artista, género, álbum, duración y ruta de reproducción.
-- En lugar de escribir múltiples JOINs cada vez que necesitábamos mostrar canciones en distintos formularios,
-- encapsulamos esa lógica en esta vista para hacer el acceso más simple, limpio y eficiente.

--📌 ¿Dónde la usamos?
-- FormCanciones: para cargar el catálogo completo al ListView con todos los datos contextuales de cada canción.
-- FormPlaylists: en dos funciones: para mostrar las canciones que tiene cada playlist y para reproducirlas en orden.
-- FormArtistasAlbumes: para desplegar las canciones de un álbum cuando el usuario lo selecciona en la vista en cards.

--✅ ¿Por qué fue funcional?
-- Nos permitió reducir duplicación de código en el backend.
-- Mejoró la legibilidad y mantenimiento del código SQL.
-- Aceleró el desarrollo de formularios que comparten la lógica musical.
-- Sirve como fuente central de datos musicales, lista para reutilizar en futuras estadísticas o filtros.

-- En definitiva, fue una decisión estratégica que aportó organización, rendimiento y escalabilidad al trabajo práctico.
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
--👥 Vista VW_UsuariosDetalles: descripción funcional y estratégica
-- 🎯 ¿Qué hace esta vista?
-- Consolida todos los datos personales, de registro y estado de cada usuario, incluyendo:
-- Nombre, apellido, email, fecha de nacimiento
-- País (nombre en vez de solo ID)
-- Estado de actividad (Activo)
-- Acceso (EsAdmin)
-- Credenciales necesarias para el login (contraseña y salt)

--📌 ¿Dónde se utiliza?
-- FormUsuarios: para cargar el Grid completo con usuarios activos.
-- FormLogin: para validar credenciales y recuperar datos personales tras el inicio de sesión.
-- FormHistorialSuscripciones: para obtener el nombre y apellido del usuario al mostrar su historial.

--✅ ¿Por qué fue útil?
-- Evita repetir JOINs con la tabla Paises en cada consulta
-- Hace que métodos como Login(), ListarUsuarios(), y GetUsuario() sean más simples y legibles
-- Permite expandir el acceso de datos sin modificar todos los métodos del sistema
-- Puede reutilizarse en reportes o módulos futuros relacionados con usuarios

--📦 En resumen: esta vista actúa como una fuente única de datos de usuario confiable y completa, optimizando consultas
-- en módulos visuales y de autenticación. Su creación mejora la arquitectura general del sistema y acelera el desarrollo.
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
--🧾 Vista vw_HistorialSuscripciones: descripción funcional y propósito en la aplicación
--🎯 ¿Qué hace esta vista?
-- Unifica todos los datos de cada suscripción de usuario en una sola consulta, incluyendo:
-- Usuario (nombre)
-- Tipo de cuenta adquirida
-- Método de pago utilizado
-- Fecha de inicio y finalización de la suscripción
-- ID único de la suscripción

-- Esto evita hacer múltiples joins entre Suscripciones, Usuarios, TiposCuenta y MetodosPago cada vez que se desea acceder al historial completo.

--📌 ¿Dónde se utiliza?
-- En el procedimiento almacenado sp_ObtenerHistorialSuscripciones, que filtra el historial por usuario y lo ordena de forma descendente.
-- En el método ListarHistorial(int idUsuario) del backend.
-- Y en el formulario visual FormHistorialSuscripciones, para cargar las cards que representan cada suscripción previa del usuario.

--✅ ¿Por qué fue útil?
-- Centraliza la información en una sola estructura legible y lista para consumir desde C#.
-- Reduce la complejidad del código SQL dentro del SP y la capa de negocio.
-- Acelera el tiempo de respuesta visual al mostrar suscripciones en pantalla.
-- Mejora la claridad semántica: los campos ya vienen con nombres descriptivos y estructurados.
-- Permite extender el uso en futuros reportes o métricas sobre actividad de suscripción.
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
--🧾 Vista vw_ReproduccionesDetalles: descripción funcional y propósito en la aplicación 
--🎯 ¿Qué hace esta vista? -- Unifica todos los datos relacionados a cada reproducción del sistema en una sola consulta, incluyendo: 
-- Usuario (nombre completo) 
-- Canción reproducida (título y duración) 
-- Álbum y artista vinculado 
-- Género musical 
-- Dispositivo utilizado 
-- Fecha y hora de reproducción 
-- ID único del evento de reproducción

-- Esto evita hacer múltiples joins entre Reproducciones, Usuarios, Canciones, Álbumes, Artistas, Géneros y Dispositivos cada vez que se desea acceder a estadísticas completas de reproducción.

--📌 ¿Dónde se utiliza? 
-- En el formulario FormReportesEstadisticas, que muestra métricas personales y globales por día, rankings y elementos destacados. 
-- En la clase ReproduccionNegocio, como fuente única para los métodos ObtenerCancionTopUsuario, ObtenerMinutosEscuchados, ObtenerHistorialGlobalPorDia, entre otros. 
-- En módulos futuros: visualización por país, tipo de cuenta, dispositivo o análisis de comportamiento musical.

--✅ ¿Por qué fue útil? 
-- Centraliza la información en una sola estructura legible y lista para consumir desde C#.
-- Elimina lógica repetida en cada método de estadísticas. 
-- Mejora la eficiencia de consultas agrupadas por fecha, usuario, artista o género. 
-- Acelera la generación de paneles en pantalla, como rankings o resúmenes diarios. 
-- Deja preparada la base para extender el sistema con nuevos reportes sin reescribir SQL complejo.
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
--🎯 ¿Qué hace?
-- Este procedimiento almacenado consulta la vista vw_HistorialSuscripciones y devuelve el historial completo de suscripciones
-- para un usuario específico, filtrando por IdUsuario y ordenando desde la más reciente.

--📌 ¿Dónde se utiliza?
-- En el método ListarHistorial(int idUsuario) dentro del backend
-- Llamado desde el FormHistorialSuscripciones para cargar las cards que muestran cada etapa de suscripción del usuario

--✅ ¿Por qué fue útil?
-- Encapsula la lógica de consulta en el motor SQL para mejorar rendimiento y legibilidad
-- Permite mantener la estructura centralizada en la vista mientras se organiza el acceso desde la app
-- Facilita futuras ampliaciones (filtrar por fechas, estados, etc.) sin tocar el código en C#

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
-- Creamos sp_AltaUsuarioConSuscripcion como procedimiento almacenado que se encarga de registrar un nuevo usuario y asociarle
-- automáticamente una suscripción inicial. Esto resuelve una acción directa en la base de datos, tal como exige el requisito del TP,
-- y se utiliza desde el formulario de alta de usuarios para encapsular la lógica SQL de forma segura y eficiente

--🎯 ¿Qué hace este SP?
-- Este procedimiento encapsula el proceso de alta de un nuevo usuario junto con su primera suscripción. Ejecuta dos acciones consecutivas:
-- Inserta al usuario con todos sus datos personales y credenciales
-- Crea automáticamente una suscripción inicial vinculada a ese usuario

--📌 ¿Dónde se utiliza?
-- Se invoca desde el formulario FormAltaUsuario, al momento de registrar un nuevo usuario en la aplicación.

--✅ ¿Por qué fue funcional y estratégico?
-- Resuelve una acción directa en la base de datos, tal como exige el TP (no es solo consulta o reporte).
-- Automatiza dos operaciones que estaban separadas: alta de usuario + alta de suscripción.
-- Asegura que ambos registros queden relacionados de forma coherente y sincronizada.
-- Mejora la seguridad y organización del backend al centralizar la lógica SQL.
-- Facilita el mantenimiento futuro: cualquier cambio en el registro se hace desde el SP.

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
        BEGIN TRANSACTION;	-- DECLARO VARIABLE PARA GUARDAR IdUsuario RESULTANTE
        DECLARE @NuevoIdUsuario INT;
		-- INSERTA NUEVO USUARIO
        INSERT INTO Usuarios (Nombre, Apellido, Email, Contraseña, IdPais, FechaNacimiento, FechaAlta, Salt, EsAdmin)
        VALUES (@Nombre, @Apellido, @Email, @Contrasena, @IdPais, @FechaNacimiento, GETDATE(), @Salt, 0); 		
        SET @NuevoIdUsuario = SCOPE_IDENTITY(); -- RESCATO ID GENERADO DE LA INSERCION DEL NUEVO USUARIO		
        IF @IdMetodoPago = 5 AND @IdTipoCuenta = 3	-- IDENTIFICO SI LA CUENTA ES FREE O PAGA
        BEGIN
		-- AL SER FREE NO TIENE FECHAFIN (VENCIMIENTO)
            INSERT INTO Suscripciones (IdUsuario, FechaInicio, FechaFin, IdMetodoPago, IdTipoCuenta)
            VALUES (@NuevoIdUsuario, GETDATE(), NULL, @IdMetodoPago, @IdTipoCuenta); 
        END
        ELSE
        BEGIN
		-- SI ES PAGA FECHAFIN EN 30 DIAS 
            INSERT INTO Suscripciones (IdUsuario, FechaInicio, FechaFin, IdMetodoPago, IdTipoCuenta)
            VALUES (@NuevoIdUsuario, GETDATE(), DATEADD(DAY, 30, GETDATE()), @IdMetodoPago, @IdTipoCuenta);
        END
		-- TRANSACCION EXITOSA
        COMMIT TRANSACTION;         
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
			-- REVIERTO TRANSACCION EN CASO DE ERROR
            ROLLBACK TRANSACTION;
		-- MSJ PERSONALIZADO DE ERROR
        RAISERROR('No se pudo registrar al usuario.', 16, 1); 
    END CATCH
END;

---------------------------------------------------------------------------------------------------------------------------

--		SP 3		--
-- SP Utilizado en FormEditarUsuario --
-- Actualiza los datos personales de un usuario existente en la base de datos, incluyendo nombre, apellido, email, país y fecha de nacimiento.
-- No toca datos sensibles como contraseña o suscripción.

--📌 ¿Dónde se utiliza?
-- En el formulario FormEditarUsuario, vinculado al botón “Guardar”, para reflejar los cambios que realiza el usuario o un administrador en su perfil.

--✅ ¿Por qué fue funcional?
-- Centraliza la lógica de modificación en el motor SQL, mejorando organización y seguridad.
-- Evita construir manualmente el UPDATE desde C#, lo que reduce errores y mejora el mantenimiento.
-- Deja preparada la estructura para extenderla con auditoría o triggers futuros (por ejemplo, registrar quién modificó qué).

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
        COMMIT TRANSACTION;	-- TRANSACCION EXITOSA
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0			
            ROLLBACK TRANSACTION;	-- REVIERTO TRANSACCION EN CASO DE ERROR
		-- MSJ PERSONALIZADO DE ERROR
        RAISERROR('No se pudo actualizar la informacion del usuario.', 16, 1);
    END CATCH
END;
---------------------------------------------------------------------------------------------------------------------------

--		SP 4		--
	--🧠 Descripción funcional — Procedimiento sp_ActualizarEstadoSuscripcion
-- Este procedimiento se encarga de garantizar que cada usuario tenga una suscripción activa, incluso si su suscripción paga ya venció.
-- Su propósito principal es automatizar la asignación de una cuenta Free cuando el usuario se queda sin suscripción vigente.
	--🎯 ¿Cuándo actúa?
-- Se ejecuta manualmente (por ejemplo, desde el FormLogin o alguna lógica de acceso) y realiza una verificación doble:
-- 🟣 Comprueba si el usuario ya tiene una suscripción paga vigente (FechaFin > GETDATE())
-- 🔵 Revisa si tiene una suscripción Free activa (FechaFin IS NULL)
-- 🔎 Si no existe ninguna suscripción activa, entonces se le asigna automáticamente una nueva suscripción Free.
	--🔧 ¿Qué inserta?
-- Crea un nuevo registro en la tabla Suscripciones con estos valores específicos:
-- IdUsuario → el usuario en cuestión
-- FechaInicio → el día actual
-- FechaFin → NULL para representar que es una cuenta Free sin vencimiento
-- IdMetodoPago = 5 → método “Gratis”
-- IdTipoCuenta = 3 → tipo “Free”
-- Esto mantiene la lógica del sistema y asegura que el usuario siempre tenga un plan válido aunque haya caducado el anterior.

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
            AND (FechaFin IS NULL OR FechaFin > GETDATE()) -- Verifica si tiene suscripción activa
        )
        BEGIN
            INSERT INTO Suscripciones (IdUsuario, FechaInicio, FechaFin, IdMetodoPago, IdTipoCuenta)
            VALUES (@idUser, GETDATE(), NULL, 5, 3); -- Inserta suscripción Free si no hay ninguna activa
        END
		-- TRANSACCION EXITOSA
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
			-- REVIERTO TRANSACCION EN CASO DE ERROR
            ROLLBACK TRANSACTION;
		-- MSJ PERSONALIZADO DE ERROR
        RAISERROR('No se pudo actualizar el estado de suscripción del usuario.', 16, 1);
    END CATCH
END;
--------------------------------------------------------------------------------------------------

/***************************** TRIGGERS **********************************/

--		TRIGGER 1		-- SP 2 y 4 Implicados
	--🧠 Descripción funcional — Trigger trg_CerrarSuscripcionAnterior
-- Este trigger se ejecuta automáticamente después de insertar una nueva suscripción en la tabla Suscripciones.
	--🎯 ¿Cuál es su propósito?
-- Garantizar que un usuario no tenga más de una suscripción activa a la vez. Para lograrlo, el trigger cierra automáticamente
-- todas las suscripciones anteriores del mismo usuario que estén vigentes o abiertas (sin fecha de fin).
	--🔍 ¿Cómo lo hace?
-- Se activa luego de cada INSERT sobre Suscripciones.
-- Identifica al usuario que recibió la nueva suscripción.
-- Busca todas sus suscripciones anteriores, excluyendo el nuevo registro.
-- Si alguna de esas suscripciones está:
-- 🟢 Abierta (FechaFin IS NULL) → cuenta Free sin vencimiento
-- 🔵 Vigente (FechaFin > GETDATE()) → suscripción paga aún activa
-- Entonces, les asigna como FechaFin la fecha actual, marcándolas como cerradas.
GO
CREATE OR ALTER TRIGGER trg_CerrarSuscripcionAnterior
ON Suscripciones
AFTER INSERT
AS
BEGIN
    UPDATE Suscripciones                                  -- Actualiza suscripcion anterior
    SET FechaFin = GETDATE()                              -- Le asigna la fecha actual (marca como cerradas)
    WHERE IdUsuario IN (SELECT IdUsuario FROM INSERTED)   -- Coinciden con el usuario de la nueva suscripción                        
      AND IdSuscripcion NOT IN (SELECT IdSuscripcion FROM INSERTED)      -- Evita modificar el nuevo registro recién insertado                                
	  AND (FechaFin IS NULL OR FechaFin > GETDATE()); -- Solo si está abierta o vigente (NO VENCIDA);
END;
--------------------------------------------------------------------------------------------------

--		TRIGGER 2		--
	--🧠 Descripción funcional — Trigger trg_ValidarEliminacionUsuario
-- Este trigger se ejecuta automáticamente cuando se intenta eliminar un usuario desde la tabla Usuarios. En lugar de permitir el DELETE directo,
-- actúa como controlador de lógica personalizada, decidiendo si el usuario puede o no ser borrado, y de qué forma.
	--🎯 ¿Cuál es su propósito?
-- Evitar que se eliminen usuarios que aún tienen suscripciones pagas vigentes, respetando los compromisos y la integridad de los datos.
	--🔍 ¿Cómo funciona?
-- Se activa INSTEAD OF DELETE: reemplaza la acción estándar de borrado.
-- Verifica si el usuario tiene alguna suscripción con FechaFin futura (es decir, activa).
-- 🛑 Si tiene suscripción activa, bloquea la operación lanzando RAISERROR, con un mensaje explicativo.
-- ✅ Si no tiene suscripción activa, ejecuta una acción controlada:
-- Por defecto: realiza una eliminación lógica → marca al usuario como inactivo (Activo = 0)
-- Alternativamente: se puede habilitar la eliminación física, borrando previamente todos los registros relacionados
-- en otras tablas (como Suscripciones, ListasReproduccion, Reproducciones, Artistas) para mantener integridad referencial.

GO
CREATE OR ALTER TRIGGER trg_ValidarEliminacionUsuario        -- Crea el trigger llamado trg_ValidarEliminacionUsuario
ON Usuarios                                              -- Se asocia a la tabla Usuarios
INSTEAD OF DELETE                                        -- Reemplaza el DELETE tradicional por lógica personalizada
AS
BEGIN
    IF EXISTS (                                          -- Verifica si existe al menos una suscripción activa
        SELECT 1
        FROM DELETED D                                   -- DELETED contiene el/los usuario/s que se intenta eliminar
        JOIN Suscripciones S ON D.IDUsuario = S.IdUsuario -- Une con suscripciones del usuario que se quiere eliminar
        WHERE S.FechaFin > GETDATE()                     -- Detecta si tiene una suscripción vigente (FechaFin futura)
    )
    BEGIN
        --THROW 50001,                                     -- Lanza un error con código personalizado (50001)
        --      'El usuario tiene una suscripción paga aun activa. No puede ser eliminado.', -- Mensaje que se muestra al intentar borrar
        --      1;                                         -- Severidad del error
		RAISERROR('No se puede dar de baja a un usuario que posee una suscripcion paga aun vigente.', 16, 1);
    END
    ELSE
    BEGIN
			-- **  Eliminacion fisica  ** --
			-- Elimina registros vinculados al usuario en otras tablas dependientes
        --DELETE FROM Reproducciones
        --WHERE IdUsuario IN (SELECT IDUsuario FROM DELETED);       -- Borra reproducciones hechas por el usuario
        --DELETE FROM ListasReproduccion
        --WHERE IdUsuario IN (SELECT IDUsuario FROM DELETED);       -- Borra sus listas creadas
        --DELETE FROM Artistas
        --WHERE IdUsuario IN (SELECT IDUsuario FROM DELETED);       -- Borra relación si el usuario es artista (si aplica)
        --DELETE FROM Suscripciones
        --WHERE IdUsuario IN (SELECT IDUsuario FROM DELETED);       -- Borra todas sus suscripciones (incluso las vencidas o Free)
        --DELETE FROM Usuarios
        --WHERE IDUsuario IN (SELECT IDUsuario FROM DELETED);       -- Finalmente, elimina físicamente al usuario

			-- ** Eliminacion Logica ** --
		UPDATE Usuarios                                       -- Marca al usuario como inactivo en lugar de borrarlo
        SET Activo = 0
        WHERE IDUsuario IN (SELECT IDUsuario FROM DELETED);   -- Solo afecta al usuario que se intentó eliminar

    END
END;              