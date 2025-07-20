 -- CARGA REGISTROS NIRVANA-RED HOT EN:
	--Artistas
	--Album
	--Canciones


USE PlataformaMusical

GO
-- GENERO
insert into Generos values ('Rock'), ('Rock Alternativo'), ('Grunge'), ('Hard Rock'), ('Pop'), ('Funk Rock');
GO

INSERT INTO Paises (Pais)
VALUES 
  ('Estados Unidos'), -- ID 1
  ('Reino Unido'), -- ID 2
  ('China'), -- ID 3
  ('India'), -- ID 4
  ('Indonesia'), -- ID 5
  ('Pakistán'), -- ID 6
  ('Brasil'), -- ID 7
  ('Nigeria'), -- ID 8
  ('Bangladés'), -- ID 9
  ('Rusia'), -- ID 10
  ('México'), -- ID 11
  ('Japón'), -- ID 12
  ('Etiopía'), -- ID 13
  ('Filipinas'), -- ID 14
  ('Egipto'), -- ID 15
  ('Vietnam'), -- ID 16
  ('República Democrática del Congo'), -- ID 17
  ('Irán'), -- ID 18
  ('Turquía'), -- ID 19
  ('Tailandia'), -- ID 20

  -- Países latinoamericanos
  ('Argentina'), -- ID 21
  ('Colombia'), -- ID 22
  ('Perú'), -- ID 23
  ('Venezuela'), -- ID 24
  ('Chile'), -- ID 25
  ('Guatemala'), -- ID 26
  ('Ecuador'), -- ID 27
  ('Bolivia'), -- ID 28
  ('Cuba'), -- ID 29
  ('Honduras'), -- ID 30

  -- Países europeos
  ('Alemania'), -- ID 31
  ('Francia'), -- ID 32
  ('Italia'), -- ID 33
  ('España'), -- ID 34
  ('Polonia'), -- ID 35
  ('Ucrania'), -- ID 36
  ('Rumania'), -- ID 37
  ('Países Bajos'), -- ID 38
  ('Grecia'), -- ID 39
  ('Portugal'); -- ID 40

go
-- Insert Artistas
INSERT INTO Artistas (NombreArtistico, Descripcion, IdPais, IdGenero, ImagenArtista, IDUsuario ) VALUES
('Nirvana', 'Banda estadounidense de grunge', 1, 3 , 'https://upload.wikimedia.org/wikipedia/ru/e/e9/Band_Nirvana.jpg', NULL),
('Red Hot Chili Peppers', 'Banda estadounidense de rock alternativo', 1, 2 , 'https://pbs.twimg.com/media/GDMnUtrXcAEcMYy.jpg', NULL);

-- Insert Álbumes
GO
INSERT INTO Albumes (Titulo, Anio, IDArtista, ImagenPortada) VALUES
('Nirvana', 2002, 1, 'https://www.moviepostersetc.com/_staticProxy/content/ff808081163c05b001169d6655243ae9/Nirvana_flat.jpg'),
('Greatest Hits', 2003, 2, 'https://upload.wikimedia.org/wikipedia/en/7/79/GreatestHitsRHCP.jpg');

-- Insert Canciones Nirvana (IDs 1 a 15)
GO
INSERT INTO Canciones (Titulo, Duracion, IdGenero, IDAlbum, RutaArchivo) VALUES
('You Know You''re Right', 218, 3, 1, 'https://drive.google.com/uc?export=download&id=1MvhYdirqqpxbaOGhuJSqOtdPF4E7uMNq'),
('About a Girl', 169, 3, 1, 'https://drive.google.com/uc?export=download&id=1BTyU2_Txjh9Ih84c_G8aP_ohu56g2ohf'),
('Been a Son', 143, 3, 1, 'https://drive.google.com/uc?export=download&id=16aK5OFL4QNfEkSvu-8uWgAuJZ4GHJwKr'),
('Sliver', 134, 3, 1, 'https://drive.google.com/uc?export=download&id=1a3w0a99XTMHf7Pn4x7uocrHTaBKSagBu'),
('Smells Like Teen Spirit', 301, 3, 1, 'https://drive.google.com/uc?export=download&id=1R4WXglJ-86wV8n8y9JJ2BvdcqpexDG9D'),
('Come as You Are', 219, 3, 1, 'https://drive.google.com/uc?export=download&id=10d5po_JL5qmbdrzXgHHqI1KEg-z_5HBA'),
('Lithium', 257, 3, 1, 'https://drive.google.com/uc?export=download&id=1OyAQET1ZTQol8DYCgtfUYqORlDMHcTyT'),
('In Bloom', 255, 3, 1, 'https://drive.google.com/uc?export=download&id=1N2puWiwBZjZBF2wPXeXMJmisB6hl6kIz'),
('Heart-Shaped Box', 281, 3, 1, 'https://drive.google.com/uc?export=download&id=1kFRT0SyWqqPLHNxfsHwDavZHQvMMZaab'),
('Pennyroyal Tea', 218, 3, 1, 'https://drive.google.com/uc?export=download&id=1XpzsY59x0dUQHvFH29e-nXz9rzxYgN65'),
('Rape Me', 171, 3, 1, 'https://drive.google.com/uc?export=download&id=1CkKMcqeZflp7sLFdxDYNRc2njeYtsSEc'),
('Dumb', 154, 3, 1, 'https://drive.google.com/uc?export=download&id=1YJ6ZPC7fV6g5xVgrxGwEr5e8N7m2c_VT'),
('All Apologies', 227, 3, 1, 'https://drive.google.com/uc?export=download&id=1hjdjnI6JP-TD96RJmevezULpw6kY4wpk'),
('The Man Who Sold the World', 229, 3, 1, 'https://drive.google.com/uc?export=download&id=1_HXz8l4W9jwfRR9rZ6V12bkl3zVaRmtv'),
('Where Did You Sleep Last Night', 302, 3, 1, 'https://drive.google.com/uc?export=download&id=10USheWizmHuV0O_LueVRsWekaijdZjoE'),

-- Insert Canciones Red Hot Chili Peppers (IDs 16 a 31)
('Under the Bridge', 264, 2, 2, 'https://drive.google.com/uc?export=download&id=1CuYW9qOjSLyrlGmHr2SIiHWnyLkJmRc0'),
('Give It Away', 269, 2, 2, 'https://drive.google.com/uc?export=download&id=1T3Q-rq-Nm5vGxias5NMLGZpdu8l-hL78'),
('Californication', 329, 2, 2, 'https://drive.google.com/uc?export=download&id=1zPEvoefJMpRVhfXaVLKSLK-saDjIG50f'),
('Scar Tissue', 216, 2, 2, 'https://drive.google.com/uc?export=download&id=1ICUbLYk1l0CLW_Q_Lzhv3u8B2qodSeWS'),
('Soul to Squeeze', 262, 2, 2, 'https://drive.google.com/uc?export=download&id=1uL7ga5-PPNWEf7tD7nnprIxqWXXS0Kgh'),
('Otherside', 256, 2, 2, 'https://drive.google.com/uc?export=download&id=1R4-RQ1Hhd-2opyCTgtqQl32iE1Imefl7'),
('Suck My Kiss', 180, 2, 2, 'https://drive.google.com/uc?export=download&id=1JMy7EGRQQgVdEBX91-kA0l-VA3u68ya7'),
('By the Way', 320, 2, 2, 'https://drive.google.com/uc?export=download&id=1_po0wGRRBtQ3FOVCRVJNVigR8t6emDxw'),
('Parallel Universe', 269, 2, 2, 'https://drive.google.com/uc?export=download&id=1DFFJud9VzZ2Q5ZwfclaF-XirwpaCdhov'),
('Breaking the Girl', 263, 2, 2, 'https://drive.google.com/uc?export=download&id=1utLyDT01_MAOzadISdRrNfnUFzPOLcCB'),
('My Friends', 249, 2, 2, 'https://drive.google.com/uc?export=download&id=1hwXP-AkHdRDnUj2Wjai85ZLSgMVtbge0'),
('Higher Ground', 293, 2, 2, 'https://drive.google.com/uc?export=download&id=1ChvVFXXG9NM51rc_QGNzd_vfQ0GPjmP5'),
('Universally Speaking', 230, 2, 2, 'https://drive.google.com/uc?export=download&id=1HYWNhihBUffvKqwXXBO708iN5wJYl4su'),
('Road Trippin', 213, 2, 2, 'https://drive.google.com/uc?export=download&id=1yC6DE8_jaB_6eD5ZmLTFL5BwG3JZtVHL'),
('Fortune Faded', 222, 2, 2, 'https://drive.google.com/uc?export=download&id=17aVMH-vsYXLQejBglCDnjxQKAn-TLDKC'),
('Save the Population', 207, 2, 2, 'https://drive.google.com/uc?export=download&id=1ENtF5oj10E2fNXiBlKlrdduIB9eEXMWe');


-- INSERT LED ZEPPELIN
GO
INSERT INTO Artistas (NombreArtistico, Descripcion, IdPais, IdGenero, ImagenArtista, IDUsuario)
VALUES ('Led Zeppelin', 'Banda británica de rock formada en 1968, considerada una de las más influyentes de la historia del rock.', 2, 1,'https://upload.wikimedia.org/wikipedia/commons/6/63/Led_Zeppelin_-_promotional_image_%281971%29.jpg', NULL);

GO
INSERT INTO Albumes (Titulo, Anio, IDArtista, ImagenPortada)
VALUES ('Mothership (Remastered)', 2015, 3, 'https://upload.wikimedia.org/wikipedia/en/c/cb/Led_Zeppelin_-_Mothership.jpg');

GO
-- Disco 1
INSERT INTO Canciones (Titulo, Duracion, IdGenero, IDAlbum, RutaArchivo) VALUES
('Good Times Bad Times', 167, 1, 3, 'https://drive.google.com/uc?export=download&id=1_tGiUFaIZKKteUKXvPxBsJ5Tzo215Duh'),
('Communication Breakdown', 148, 1, 3, 'https://drive.google.com/uc?export=download&id=1bgZeHWsZ1d0en2MGDn_6n5PsVqdoyU9y'),
('Dazed And Confused', 388, 1, 3, 'https://drive.google.com/uc?export=download&id=1FZLst98nx8tKwF_NTDIj1ffjO3imUuqM'),
('Babe I''m Gonna Leave You', 402, 1, 3, 'https://drive.google.com/uc?export=download&id=1KVeTUEzF1I1bTcRwV0FcfTYNxUyP19fj'),
('Whole Lotta Love', 329, 1, 3, 'https://drive.google.com/uc?export=download&id=1w02WhPYB3QBHr_ZsOT5eI-JI0mc2LKW7'),
('Ramble On', 268, 1, 3, 'https://drive.google.com/uc?export=download&id=1JAzjawGc0bnIFkHfNrJHePvgRVjsN1NG'),
('Heartbreaker', 255, 1, 3, 'https://drive.google.com/uc?export=download&id=14mPhS8N_NEmdcHf1A4mPnA7GmUOQA8pp'),
('Immigrant Song', 146, 1, 3, 'https://drive.google.com/uc?export=download&id=1yomhuSFhIGDpKzJZ5tGYJQX_YlrBaXM6'),
('Since I''ve Been Loving You', 444, 1, 3, 'https://drive.google.com/uc?export=download&id=1xlagfJnnz40KYEZzil0IGIFG-fKGOHqd'),
('Rock And Roll', 220, 1, 3, 'https://drive.google.com/uc?export=download&id=1Ly6JRdFxi-8_Yce3mY222hvhrYLpan_0'),
('Black Dog', 295, 1, 3, 'https://drive.google.com/uc?export=download&id=1AcoYfaVhnOg-zFQUvGs-bC-aOI_hynRq'),
('When The Levee Breaks', 430, 1, 3, 'https://drive.google.com/uc?export=download&id=1snyrwKTSjvpYl-IgcOAHj9x812NlK9PR'),
('Stairway To Heaven', 485, 1, 3, 'https://drive.google.com/uc?export=download&id=1sPib1KLVRpZeuYW5t9rtN0KL_XP1L7ev');

-- Disco 2
INSERT INTO Canciones (Titulo, Duracion, IdGenero, IDAlbum, RutaArchivo) VALUES
('The Song Remains The Same', 331, 1, 3, 'https://drive.google.com/uc?export=download&id=1Tne7COnmboeoqTymn8khFLzoO4ty3Yc6'),
('Over The Hills And Far Away', 290, 1, 3, 'https://drive.google.com/uc?export=download&id=1p5A_-G-PtvlcvoT9PNo3nEWzHkrzOfwN'),
('D''yer Mak''er', 262, 1, 3, 'https://drive.google.com/uc?export=download&id=1O5p7OGR-t8q9N58cjbRUBIE5LRIOZ15z'),
('No Quarter', 422, 1, 3, 'https://drive.google.com/uc?export=download&id=1KR7_gIU-Q-M66K3SXpCDKaozNs1PACbG'),
('Trampled Under Foot', 336, 1, 3, 'https://drive.google.com/uc?export=download&id=1dTCVg7kzwInhm_wfArUnuKcMNpR-v5Gs'),
('Houses Of The Holy', 244, 1, 3, 'https://drive.google.com/uc?export=download&id=1yfcnFAK826gzW9FDYxEzFIBP4rItEDNJ'),
('Kashmir', 517, 1, 3, 'https://drive.google.com/uc?export=download&id=18XRqbCx7uzhBLnOMrELY7LnT7y2Xtx0P'),
('Nobody''s Fault But Mine', 388, 1, 3, 'https://drive.google.com/uc?export=download&id=1eUAS9MyLYpoOfqhQUQ8Cl2vK1_i_mx6J'),
('Achilles Last Stand', 630, 1, 3, 'https://drive.google.com/uc?export=download&id=1M9KscoC14DSpfbo3FGssar_5QDbtH-uo'),
('In The Evening', 413, 1, 3, 'https://drive.google.com/uc?export=download&id=1Fu4ZmYUM5KmpMpChdTf5oKTzBIejnE9L'),
('All My Love', 355, 1, 3, 'https://drive.google.com/uc?export=download&id=1u5i0jRRqV3DdXy5pPgoHPJHMKi6Hvpcy');

-- INSERT GUNS & ROSES
GO
-- Insert del artista Guns N' Roses
INSERT INTO Artistas (NombreArtistico, Descripcion, IdPais,IdGenero, ImagenArtista, IDUsuario) VALUES 
('Guns N'' Roses', 'Banda estadounidense de hard rock formada en Los Ángeles en 1985.', 1,4 , 'https://headbangersla.com/app/uploads/2020/01/guns-and-roses-1.jpg', NULL);
GO
-- Insert del álbum Greatest Hits (se genera automáticamente IDAlbum, asumimos que es el siguiente disponible)
INSERT INTO Albumes (Titulo, Anio, IDArtista, ImagenPortada) VALUES 
('Greatest Hits', 2004, 4, 'https://upload.wikimedia.org/wikipedia/en/3/36/GreatestHits_Guns%27n%27Roses.jpg');
GO
-- Insert de canciones del álbum Greatest Hits de Guns N' Roses (usamos el último IDAlbum insertado)
INSERT INTO Canciones (Titulo, Duracion, IdGenero, IDAlbum, RutaArchivo) VALUES
('Welcome to the Jungle', 274, 4, 4, 'https://drive.google.com/uc?export=download&id=16Z7CA8rzz9_6z0V8LWlt_ufIn-aCPyT9'),
('Sweet Child O'' Mine', 356, 4, 4, 'https://drive.google.com/uc?export=download&id=1wP8luNOBOdTD3E_vTsVsk2eoDQNkNaKe'),
('Patience', 337, 4, 4, 'https://drive.google.com/uc?export=download&id=1egxBikBcBxfN1MMBhoxtuttJgglBI7LN'),
('Paradise City', 406, 4, 4, 'https://drive.google.com/uc?export=download&id=1jzrlFn06qRRKMOmox6cjf1Ucz_aIZ8us'),
('Knockin'' on Heaven''s Door', 336, 1, 4, 'https://drive.google.com/uc?export=download&id=1Oi0r-FCkXvuyMvmX2aMJLeeLsz-7IhWF'),
('You Could Be Mine', 334, 4, 4, 'https://drive.google.com/uc?export=download&id=16EIBdV_aKI57jIDh-4Kx0o8cSWsYq_1f'),
('Don''t Cry [Original Version]', 254, 4, 4, 'https://drive.google.com/uc?export=download&id=1zG58_you31gg882_NitTpM0vzcWV9cxw'),
('November Rain', 537, 4, 4, 'https://drive.google.com/uc?export=download&id=1rmiYT9hfcBj6g-GoDbVrNURrt_FFV2q3'),
('Live and Let Die', 180, 4, 4, 'https://drive.google.com/uc?export=download&id=1_LGqyXLge4FU4JXPA2Dlvlz-EGa2gMlQ'),
('Yesterdays', 223, 4, 4, 'https://drive.google.com/uc?export=download&id=1EcXpf8ouMRI1X8NBHfggR18pZdjsb0zA'),
('Ain''t It Fun', 315, 4, 4, 'https://drive.google.com/uc?export=download&id=1lxBacI1auy477OpTGSxNr76N29pF14J8'),
('Since I Don''t Have You', 253, 1,4, 'https://drive.google.com/uc?export=download&id=1RH7YwvH8aMHw00T_GOYCh6WXYZq4A-vu'),
('Sympathy for the Devil', 437, 4,4, 'https://drive.google.com/uc?export=download&id=1bXbLcFK6VEG625c0uOxfbCLoLO0hQ9XB'),
('Civil War', 464, 4, 4, 'https://drive.google.com/uc?export=download&id=1Vg0RFEAMCLXXPJsQqkK8lgXTtAaC5mug');

--TIPO CUENTA
INSERT INTO TiposCuenta (Descripcion, Monto) values ('Premium', 3.99 ),('Standard', 1.99 ),('Free', 0.00);

--USUARIOS
INSERT INTO Usuarios (Nombre, Apellido, IdPais, Email, Contraseña, Salt, FechaNacimiento, FechaAlta)
VALUES 
-- Alta reciente (2025)
('Juan', 'Pérez', 21, 'juan.perez@example.com', '61qJYJaH4159OFNlFR+QAlK0CRdTSKlfMtKjAvgaKZ8=', 'dYZw471P7JoM5e9OGxEuKQ==', '1990-05-15', '2025-01-28'),
('Laura', 'Gómez', 21, 'laura.gomez@example.com', 'si4vzjMBoDB6P/PaE4AYPz4uApbfMf3U4YlROCsWoZc=', '0PzCwrGJjmih7asYfV0WMQ==', '1990-05-15', '2025-02-03'),
-- Alta intermedia (2023–2024)
('María', 'González', 21, 'maria.gonzalez@example.com', 'ppcA67L4FPMm5X9fVJnAsIHEl3Sioj+LzvEs3AQVhgo=', '2wIEtgTZjcXZV3baXpPnVA==', '1985-11-22', '2024-06-10'),
('Carlos', 'Martínez', 21, 'carlos.mtz@example.com', '2B59+o55TtlxPpQNSc1za0kUTluKeXNKvcKrCoIrGrc=', 'RI1l4oKJrU8Dm1CDptFgEA==', '1985-11-22', '2024-12-22'),
('Ana', 'Rodríguez', 21, 'ana.rodriguez@example.com', 'zr7oRNEn+Hp9EKgDYuFCpOb5Df2dhcPNHZvxw0c46wc=', '0g9Tl42nFqV37YtMF95hsA==', '1995-07-30', '2023-03-12'),
-- Alta en pandemia (2020–2022)
('Carlos', 'Rodríguez', 21, 'carlos.admin@example.com', 'Fcpg0FxFFSS2ZwRSjnvGYpxLI4KPcr9WvNxaL90AwWk=', 'aI0Dl6geDTQMS4+Ly53qTw==', '1978-03-10', '2021-01-17'),
('Ana', 'López', 21, 'ana.lopez@example.com', 'uQmGfqJkmohRjrqDgJooxWy4Gl9vBwOwsTYD1NEE1rs=', 'BiECy1VRPfrWISzWeKwCUQ==', '1995-07-30', '2022-11-08'),
('Pedro', 'Sánchez', 21, 'pedro.sanchez@example.com', 'N52DUY/yuwpC4h88nSCcp0FqMU8JbbW6D1i30AKKj3k=', 'ptZBYHe/ZVpAoRamG3MU4Q==', '1988-03-10', '2020-09-05'),
('María', 'López', 21, 'maria.lopez@example.com', '3AN52/h06ERlGvfK9D0+tMRnYsGBxElemuAsndRpQU8=', 'iwrEUxrD6qKvgd6g++kOpg==', '1992-09-18', '2022-03-19'),
('Javier', 'Fernández', 21, 'javier.fernandez@example.com', 'NH+4rSoC3th7wXj6l9b4r7Odi0e93z+iZeOQPBCldJc=', '0XDsC+IUJ/PYKRv/C57FLw==', '1983-12-05', '2021-07-22');

-- Usuario especial: ejemplo fijo
INSERT INTO Usuarios (Nombre, Apellido, IdPais, Email, Contraseña, Salt, FechaNacimiento, FechaAlta, EsAdmin)
VALUES 
('Ale', 'Jandro', 21, 'admin', 'KxtdOdorQeKJFYmKT60RjbzuL2BueKDawKkerzzteZw=', 'fQH8NGvH/wnTTphjQn44SA==', '1988-01-27', '2020-01-27', 1);

GO
--Metodos de pago
go
INSERT INTO MetodosPago VALUES
('Debito'),
('Credito'),
('PayPal'),
('Mercado Pago'),
('Gratis')
go
--Suscripciones
INSERT INTO Suscripciones (IdUsuario, FechaInicio, FechaFin, IdMetodoPago, IdTipoCuenta) VALUES

(1, '2025-01-28', NULL, 5, 3), -- Juan Pérez | Free activa | Método: Gratis | Tipo: Free
(2, '2025-02-03', NULL, 5, 3), -- Laura Gómez | Free activa | Método: Gratis | Tipo: Free

(3, '2024-06-10', '2024-07-10', 5, 3), -- María González | Free inicial | Método: Gratis | Tipo: Free
(3, '2024-07-11', '2024-08-10', 1, 2), -- María González | Cambio a Standard | Método: Débito | Tipo: Standard
(3, '2024-08-11', '2024-09-10', 4, 1), -- María González | Cambio a Premium | Método: Mercado Pago | Tipo: Premium
(3, '2024-09-11', NULL, 5, 3),         -- María González | Vuelve a Free activa | Método: Gratis | Tipo: Free

(4, '2024-12-22', '2025-01-21', 5, 3), -- Carlos Martínez | Free inicial | Método: Gratis | Tipo: Free
(4, '2025-01-22', '2025-02-21', 2, 2), -- Carlos Martínez | Cambio a Standard | Método: Crédito | Tipo: Standard
(4, '2025-02-22', DATEADD(DAY, 30, '2025-02-22'), 3, 1), -- Carlos Martínez | Cambio a Premium activa | Método: PayPal | Tipo: Premium

(5, '2023-03-12', '2023-04-11', 5, 3), -- Ana Rodríguez | Free inicial | Método: Gratis | Tipo: Free
(5, '2023-04-12', '2023-05-11', 1, 2), -- Ana Rodríguez | Cambio a Standard | Método: Débito | Tipo: Standard
(5, '2023-05-12', DATEADD(DAY, 30, '2023-05-12'), 4, 1), -- Ana Rodríguez | Cambio a Premium activa | Método: Mercado Pago | Tipo: Premium

(6, '2021-01-17', '2021-02-16', 5, 3), -- Carlos Rodríguez | Free inicial | Método: Gratis | Tipo: Free
(6, '2021-02-17', '2021-03-19', 2, 2), -- Carlos Rodríguez | Cambio a Standard | Método: Crédito | Tipo: Standard
(6, '2021-03-20', '2021-04-19', 1, 1), -- Carlos Rodríguez | Cambio a Premium | Método: Débito | Tipo: Premium
(6, '2021-04-20', NULL, 5, 3),         -- Carlos Rodríguez | Vuelve a Free activa | Método: Gratis | Tipo: Free

(7, '2022-11-08', '2022-12-07', 5, 3), -- Ana López | Free inicial | Método: Gratis | Tipo: Free
(7, '2022-12-08', '2023-01-07', 3, 2), -- Ana López | Cambio a Standard | Método: PayPal | Tipo: Standard
(7, '2023-01-08', '2023-02-07', 4, 1), -- Ana López | Cambio a Premium | Método: Mercado Pago | Tipo: Premium
(7, '2023-02-08', DATEADD(DAY, 30, '2023-02-08'), 1, 1), -- Ana López | Renueva Premium activa | Método: Débito | Tipo: Premium

(8, '2020-09-05', '2020-10-04', 5, 3), -- Pedro Sánchez | Free inicial | Método: Gratis | Tipo: Free
(8, '2020-10-05', '2020-11-04', 3, 1), -- Pedro Sánchez | Cambio a Premium | Método: PayPal | Tipo: Premium
(8, '2020-11-05', '2020-12-04', 1, 2), -- Pedro Sánchez | Cambio a Standard | Método: Débito | Tipo: Standard
(8, '2020-12-05', NULL, 5, 3),         -- Pedro Sánchez | Vuelve a Free activa | Método: Gratis | Tipo: Free

(9, '2022-03-19', '2022-04-18', 5, 3), -- María López | Free inicial | Método: Gratis | Tipo: Free
(9, '2022-04-19', '2022-05-18', 1, 2), -- María López | Cambio a Standard | Método: Débito | Tipo: Standard
(9, '2022-05-19', DATEADD(DAY, 30, '2022-05-19'), 2, 1), -- María López | Cambio a Premium activa | Método: Crédito | Tipo: Premium

(10, '2021-07-22', '2021-08-21', 5, 3), -- Javier Fernández | Free inicial | Método: Gratis | Tipo: Free
(10, '2021-08-22', '2021-09-21', 2, 2), -- Javier Fernández | Cambio a Standard | Método: Crédito | Tipo: Standard
(10, '2021-09-22', DATEADD(DAY, 30, '2021-09-22'), 1, 1); -- Javier Fernández | Cambio a Premium activa | Método: Débito | Tipo: Premium



--DISPOSITIVOS
	insert into Dispositivos values ('Pc'),('Celular'),('Tablet'),('Smart Tv');

