USE CiudadInteligenteMER;
GO

INSERT INTO IoT.Ubicacion (Latitud, Longitud) VALUES
(4.8650, -74.0490),
(4.8645, -74.0500),
(4.8640, -74.0510),
(4.8635, -74.0520),
(4.8630, -74.0530),
(4.8625, -74.0540),
(4.8620, -74.0550),
(4.8615, -74.0560),
(4.8610, -74.0570),
(4.8605, -74.0580),
(4.8600, -74.0590),
(4.8595, -74.0600),
(4.8590, -74.0610),
(4.8585, -74.0620),
(4.8580, -74.0630),
(4.8575, -74.0640),
(4.8570, -74.0650),
(4.8565, -74.0660),
(4.8560, -74.0670),
(4.8555, -74.0680),
(4.8660, -74.0480),
(4.8665, -74.0470),
(4.8670, -74.0460),
(4.8675, -74.0450),
(4.8680, -74.0440),
(4.8685, -74.0430),
(4.8690, -74.0420),
(4.8695, -74.0410),
(4.8700, -74.0400),
(4.8705, -74.0390),
(4.8550, -74.0500),
(4.8710, -74.0500),
(4.8655, -74.0650),
(4.8655, -74.0450),
(4.8580, -74.0550),
(4.8680, -74.0550),
(4.8720, -74.0500),
(4.8540, -74.0500),
(4.8600, -74.0450),
(4.8600, -74.0650),
(4.8570, -74.0480),
(4.8700, -74.0520),
(4.8630, -74.0470),
(4.8560, -74.0580),
(4.8690, -74.0600),
(4.8550, -74.0620),
(4.8715, -74.0435),
(4.8545, -74.0655),
(4.8625, -74.0425),
(4.8675, -74.0685);

USE CiudadInteligenteMER;
GO
INSERT INTO IoT.WiFi (Nombre, IdUbicacion, IdCompania, IdEstado, RangoCobertura)
VALUES 
('WiFi_CentroComercial_1', 1, 2, 1, 45.50),
('WiFi_PlazaCentral', 2, 3, 1, 60.75),
('WiFi_ParqueNorte', 3, 1, 2, 80.00),
('WiFi_UniversidadTech', 4, 5, 1, 120.00),
('WiFi_BibliotecaSur', 5, 2, 1, 55.40),
('WiFi_MuseoArte', 6, 4, 1, 65.10),
('WiFi_Aeropuerto_T1', 7, 3, 1, 200.00),
('WiFi_Aeropuerto_T2', 7, 3, 1, 250.00),
('WiFi_HospitalGeneral', 8, 2, 1, 100.00),
('WiFi_MercadoCentral', 9, 5, 1, 75.60),
('WiFi_Estadio', 10, 4, 2, 300.00),
('WiFi_ResidencialNorte', 1, 1, 1, 45.00),
('WiFi_Puerto', 2, 3, 1, 150.00),
('WiFi_TerminalBus', 3, 2, 1, 90.50),
('WiFi_ParqueSur', 4, 5, 1, 70.10),
('WiFi_UniversidadSur', 5, 4, 1, 130.00),
('WiFi_MetroCentro', 6, 2, 1, 60.00),
('WiFi_HotelLux', 7, 3, 1, 100.00),
('WiFi_MallVerde', 8, 1, 1, 80.00),
('WiFi_Polideportivo', 9, 5, 1, 110.00),
('WiFi_Ayuntamiento', 10, 2, 1, 50.00),
('WiFi_ParqueIndustrial', 1, 4, 1, 180.00),
('WiFi_BibliotecaNorte', 2, 1, 1, 55.00),
('WiFi_HospitalInfantil', 3, 3, 1, 95.00),
('WiFi_ColegioCentral', 4, 2, 1, 65.00),
('WiFi_ParqueEste', 5, 5, 1, 70.00),
('WiFi_CentroCultural', 6, 4, 1, 85.00),
('WiFi_GaleriaComercial', 7, 2, 1, 75.00),
('WiFi_PiscinaMunicipal', 8, 3, 1, 100.00),
('WiFi_PoliciaCentral', 9, 5, 1, 90.00),
('WiFi_Bomberos', 10, 1, 1, 85.00),
('WiFi_MercadoNorte', 1, 2, 1, 70.00),
('WiFi_PlazaVerde', 2, 3, 1, 65.00),
('WiFi_EscuelaSur', 3, 1, 1, 55.00),
('WiFi_OficinaPublica', 4, 4, 1, 100.00),
('WiFi_BancoCentral', 5, 2, 1, 90.00),
('WiFi_TorreNegocios', 6, 5, 1, 150.00),
('WiFi_HospitalPrivado', 7, 3, 1, 95.00),
('WiFi_CentroDeportivo', 8, 1, 1, 120.00),
('WiFi_Aduana', 9, 4, 1, 180.00),
('WiFi_MuelleSur', 10, 2, 1, 200.00),
('WiFi_ResidencialSur', 1, 1, 1, 40.00),
('WiFi_CentroVeterinario', 2, 3, 1, 55.00),
('WiFi_UniversidadNorte', 3, 5, 1, 125.00),
('WiFi_FabricaElectrica', 4, 4, 1, 175.00),
('WiFi_PuentePrincipal', 5, 2, 1, 95.00),
('WiFi_PlantaAgua', 6, 3, 1, 190.00),
('WiFi_EstacionTren', 7, 4, 1, 210.00),
('WiFi_CentroTecnologico', 8, 5, 1, 160.00),
('WiFi_BibliotecaEste', 9, 1, 1, 65.00),
('WiFi_LaboratorioNacional', 10, 2, 1, 230.00);

USE CiudadInteligenteMER;
GO
INSERT INTO IoT.SensorWiFi (IdWiFi, IdUsuario, FechaConexion, FechaMedicion, VelocidadSubida, VelocidadBajada, DireccionIP, IdTipoConexion) VALUES
(1,1,GETDATE(),GETDATE(),15.5,45.6,'192.168.0.1',1),
(2,3,GETDATE(),GETDATE(),12.2,38.1,'192.168.0.2',2),
(3,2,GETDATE(),GETDATE(),20.1,55.3,'192.168.0.3',3),
(4,4,GETDATE(),GETDATE(),10.5,25.4,'192.168.0.4',4),
(5,5,GETDATE(),GETDATE(),8.9,22.0,'192.168.0.5',5),
(6,6,GETDATE(),GETDATE(),25.3,75.8,'192.168.0.6',6),
(7,7,GETDATE(),GETDATE(),30.1,100.2,'192.168.0.7',1),
(8,8,GETDATE(),GETDATE(),18.4,65.3,'192.168.0.8',2),
(9,9,GETDATE(),GETDATE(),22.6,72.4,'192.168.0.9',3),
(10,10,GETDATE(),GETDATE(),19.5,58.1,'192.168.0.10',4),
(11,2,GETDATE(),GETDATE(),14.1,35.0,'192.168.0.11',5),
(12,3,GETDATE(),GETDATE(),21.0,67.0,'192.168.0.12',6),
(13,1,GETDATE(),GETDATE(),25.0,80.0,'192.168.0.13',1),
(14,4,GETDATE(),GETDATE(),15.3,48.2,'192.168.0.14',2),
(15,5,GETDATE(),GETDATE(),28.9,90.4,'192.168.0.15',3),
(16,6,GETDATE(),GETDATE(),10.7,33.6,'192.168.0.16',4),
(17,7,GETDATE(),GETDATE(),32.0,110.0,'192.168.0.17',5),
(18,8,GETDATE(),GETDATE(),18.0,60.0,'192.168.0.18',6),
(19,9,GETDATE(),GETDATE(),22.0,70.0,'192.168.0.19',1),
(20,10,GETDATE(),GETDATE(),12.5,40.0,'192.168.0.20',2),
(21,1,GETDATE(),GETDATE(),26.0,95.0,'192.168.0.21',3),
(22,3,GETDATE(),GETDATE(),14.0,50.0,'192.168.0.22',4),
(23,4,GETDATE(),GETDATE(),20.0,68.0,'192.168.0.23',5),
(24,5,GETDATE(),GETDATE(),15.0,52.0,'192.168.0.24',6),
(25,6,GETDATE(),GETDATE(),27.0,85.0,'192.168.0.25',1),
(26,7,GETDATE(),GETDATE(),11.5,30.5,'192.168.0.26',2),
(27,8,GETDATE(),GETDATE(),16.0,45.0,'192.168.0.27',3),
(28,9,GETDATE(),GETDATE(),25.0,90.0,'192.168.0.28',4),
(29,10,GETDATE(),GETDATE(),28.0,95.0,'192.168.0.29',5),
(30,2,GETDATE(),GETDATE(),17.0,55.0,'192.168.0.30',6),
(31,3,GETDATE(),GETDATE(),12.5,40.0,'192.168.0.31',1),
(32,4,GETDATE(),GETDATE(),15.0,50.0,'192.168.0.32',2),
(33,5,GETDATE(),GETDATE(),23.0,70.0,'192.168.0.33',3),
(34,6,GETDATE(),GETDATE(),30.0,100.0,'192.168.0.34',4),
(35,7,GETDATE(),GETDATE(),22.0,80.0,'192.168.0.35',5),
(36,8,GETDATE(),GETDATE(),19.0,60.0,'192.168.0.36',6),
(37,9,GETDATE(),GETDATE(),25.0,85.0,'192.168.0.37',1),
(38,10,GETDATE(),GETDATE(),13.5,35.0,'192.168.0.38',2),
(39,1,GETDATE(),GETDATE(),16.0,45.0,'192.168.0.39',3),
(40,2,GETDATE(),GETDATE(),28.0,90.0,'192.168.0.40',4),
(41,3,GETDATE(),GETDATE(),18.0,55.0,'192.168.0.41',5),
(42,4,GETDATE(),GETDATE(),20.0,65.0,'192.168.0.42',6),
(43,5,GETDATE(),GETDATE(),24.0,78.0,'192.168.0.43',1),
(44,6,GETDATE(),GETDATE(),19.0,50.0,'192.168.0.44',2),
(45,7,GETDATE(),GETDATE(),21.0,70.0,'192.168.0.45',3),
(46,8,GETDATE(),GETDATE(),29.0,100.0,'192.168.0.46',4),
(47,9,GETDATE(),GETDATE(),23.0,80.0,'192.168.0.47',5),
(48,10,GETDATE(),GETDATE(),25.0,95.0,'192.168.0.48',6),
(49,1,GETDATE(),GETDATE(),18.0,60.0,'192.168.0.49',1),
(50,2,GETDATE(),GETDATE(),22.0,75.0,'192.168.0.50',2);


USE CiudadInteligenteMER;
GO
INSERT INTO IoT.AlumbradoPublico (Codigo, IdUbicacion, IdCompania, IdEstado) VALUES
('ALB-001',1,1,1),
('ALB-002',2,2,1),
('ALB-003',3,3,1),
('ALB-004',4,4,2),
('ALB-005',5,5,1),
('ALB-006',6,1,1),
('ALB-007',7,2,1),
('ALB-008',8,3,1),
('ALB-009',9,4,1),
('ALB-010',10,5,1),
('ALB-011',1,1,1),
('ALB-012',2,2,1),
('ALB-013',3,3,1),
('ALB-014',4,4,1),
('ALB-015',5,5,1),
('ALB-016',6,1,1),
('ALB-017',7,2,1),
('ALB-018',8,3,1),
('ALB-019',9,4,1),
('ALB-020',10,5,1),
('ALB-021',1,2,1),
('ALB-022',2,3,1),
('ALB-023',3,4,1),
('ALB-024',4,5,1),
('ALB-025',5,1,1),
('ALB-026',6,2,1),
('ALB-027',7,3,1),
('ALB-028',8,4,1),
('ALB-029',9,5,1),
('ALB-030',10,1,1),
('ALB-031',1,2,1),
('ALB-032',2,3,1),
('ALB-033',3,4,1),
('ALB-034',4,5,1),
('ALB-035',5,1,1),
('ALB-036',6,2,1),
('ALB-037',7,3,1),
('ALB-038',8,4,1),
('ALB-039',9,5,1),
('ALB-040',10,1,1),
('ALB-041',1,2,1),
('ALB-042',2,3,1),
('ALB-043',3,4,1),
('ALB-044',4,5,1),
('ALB-045',5,1,1),
('ALB-046',6,2,1),
('ALB-047',7,3,1),
('ALB-048',8,4,1),
('ALB-049',9,5,1),
('ALB-050',10,1,1);

USE CiudadInteligenteMER;
GO
INSERT INTO IoT.SensorLuminaria (IdAlumbrado, FechaMedicion, Consumo, Temperatura, Luminiscencia) VALUES
(1,GETDATE(),10.5,28.3,420.5),
(2,GETDATE(),12.0,30.0,450.0),
(3,GETDATE(),9.8,29.5,410.0),
(4,GETDATE(),15.2,33.1,500.0),
(5,GETDATE(),8.7,27.4,380.0),
(6,GETDATE(),11.3,31.0,460.0),
(7,GETDATE(),13.5,32.2,470.0),
(8,GETDATE(),14.0,34.0,490.0),
(9,GETDATE(),9.5,28.0,400.0),
(10,GETDATE(),16.2,35.5,510.0),
(11,GETDATE(),12.1,29.5,430.0),
(12,GETDATE(),10.8,28.7,420.0),
(13,GETDATE(),14.5,33.3,500.0),
(14,GETDATE(),11.6,31.2,440.0),
(15,GETDATE(),9.9,30.1,410.0),
(16,GETDATE(),15.0,35.0,520.0),
(17,GETDATE(),13.2,33.0,480.0),
(18,GETDATE(),12.8,31.5,460.0),
(19,GETDATE(),10.0,29.0,420.0),
(20,GETDATE(),14.9,34.0,500.0),
(21,GETDATE(),11.2,30.5,430.0),
(22,GETDATE(),13.6,32.8,470.0),
(23,GETDATE(),10.4,28.5,410.0),
(24,GETDATE(),12.0,29.8,440.0),
(25,GETDATE(),15.3,35.2,520.0),
(26,GETDATE(),14.1,33.0,490.0),
(27,GETDATE(),9.7,28.0,400.0),
(28,GETDATE(),11.9,30.0,430.0),
(29,GETDATE(),13.8,32.5,480.0),
(30,GETDATE(),10.6,29.0,420.0),
(31,GETDATE(),15.0,34.0,500.0),
(32,GETDATE(),12.7,31.0,460.0),
(33,GETDATE(),11.5,30.5,440.0),
(34,GETDATE(),13.9,33.0,480.0),
(35,GETDATE(),10.8,29.5,420.0),
(36,GETDATE(),15.1,35.0,510.0),
(37,GETDATE(),12.3,30.8,450.0),
(38,GETDATE(),14.0,33.5,490.0),
(39,GETDATE(),9.6,28.2,400.0),
(40,GETDATE(),13.4,32.2,470.0),
(41,GETDATE(),11.0,30.0,430.0),
(42,GETDATE(),12.8,31.7,460.0),
(43,GETDATE(),14.5,33.3,480.0),
(44,GETDATE(),10.9,29.4,410.0),
(45,GETDATE(),15.4,35.1,520.0),
(46,GETDATE(),13.1,32.8,470.0),
(47,GETDATE(),12.2,30.9,440.0),
(48,GETDATE(),14.8,33.9,495.0),
(49,GETDATE(),10.3,28.6,405.0),
(50,GETDATE(),15.0,35.0,515.0);

USE CiudadInteligenteMER;
GO
INSERT INTO Ops.Mantenimiento (IdAlumbrado, IdWiFi, Fecha, Descripcion, IdCompania)
VALUES
(1, NULL, DATEADD(DAY,-1,GETDATE()), 'Revisión luminaria por bajo rendimiento.', 1),
(2, NULL, DATEADD(DAY,-2,GETDATE()), 'Cambio de bombilla y limpieza de lámpara.', 2),
(3, NULL, DATEADD(DAY,-3,GETDATE()), 'Inspección rutinaria de alumbrado.', 3),
(4, NULL, DATEADD(DAY,-4,GETDATE()), 'Reemplazo de sensor de luminosidad.', 4),
(5, NULL, DATEADD(DAY,-5,GETDATE()), 'Revisión de cableado subterráneo.', 5),
(NULL, 1, DATEADD(DAY,-1,GETDATE()), 'Mantenimiento de punto WiFi principal.', 6),
(NULL, 2, DATEADD(DAY,-2,GETDATE()), 'Actualización de firmware del router.', 7),
(NULL, 3, DATEADD(DAY,-3,GETDATE()), 'Cambio de antena por interferencia.', 8),
(NULL, 4, DATEADD(DAY,-4,GETDATE()), 'Optimización de cobertura WiFi.', 9),
(NULL, 5, DATEADD(DAY,-5,GETDATE()), 'Revisión de conexión troncal.', 10),
(6, NULL, DATEADD(DAY,-6,GETDATE()), 'Cambio de bombilla LED.', 11),
(7, NULL, DATEADD(DAY,-7,GETDATE()), 'Revisión de conexión eléctrica.', 2),
(8, NULL, DATEADD(DAY,-8,GETDATE()), 'Reemplazo de poste oxidado.', 3),
(9, NULL, DATEADD(DAY,-9,GETDATE()), 'Reparación de panel de control.', 4),
(10, NULL, DATEADD(DAY,-10,GETDATE()), 'Inspección general de red de alumbrado.', 5),
(NULL, 6, DATEADD(DAY,-6,GETDATE()), 'Mantenimiento preventivo WiFi.', 6),
(NULL, 7, DATEADD(DAY,-7,GETDATE()), 'Revisión de ancho de banda.', 7),
(NULL, 8, DATEADD(DAY,-8,GETDATE()), 'Optimización de router central.', 8),
(NULL, 9, DATEADD(DAY,-9,GETDATE()), 'Revisión de puntos de acceso.', 9),
(NULL, 10, DATEADD(DAY,-10,GETDATE()), 'Reinstalación de equipo WiFi.', 10),
(11, NULL, DATEADD(DAY,-11,GETDATE()), 'Revisión programada mensual.', 1),
(12, NULL, DATEADD(DAY,-12,GETDATE()), 'Sustitución de foco fundido.', 2),
(13, NULL, DATEADD(DAY,-13,GETDATE()), 'Revisión de voltaje de línea.', 3),
(14, NULL, DATEADD(DAY,-14,GETDATE()), 'Limpieza de lámpara LED.', 4),
(15, NULL, DATEADD(DAY,-15,GETDATE()), 'Cambio de transformador.', 5),
(NULL, 11, DATEADD(DAY,-11,GETDATE()), 'Reemplazo de AP dañado.', 6),
(NULL, 12, DATEADD(DAY,-12,GETDATE()), 'Revisión de canal WiFi.', 7),
(NULL, 13, DATEADD(DAY,-13,GETDATE()), 'Reconfiguración de seguridad WPA3.', 8),
(NULL, 14, DATEADD(DAY,-14,GETDATE()), 'Actualización de firmware.', 9),
(NULL, 15, DATEADD(DAY,-15,GETDATE()), 'Inspección de latencia en red.', 10),
(16, NULL, DATEADD(DAY,-16,GETDATE()), 'Revisión de conexión eléctrica.', 11),
(17, NULL, DATEADD(DAY,-17,GETDATE()), 'Sustitución de bombilla LED.', 1),
(18, NULL, DATEADD(DAY,-18,GETDATE()), 'Revisión de sensor de movimiento.', 2),
(19, NULL, DATEADD(DAY,-19,GETDATE()), 'Limpieza de lámpara.', 3),
(20, NULL, DATEADD(DAY,-20,GETDATE()), 'Cambio de fusible principal.', 4),
(NULL, 16, DATEADD(DAY,-16,GETDATE()), 'Cambio de router WiFi.', 5),
(NULL, 17, DATEADD(DAY,-17,GETDATE()), 'Optimización de red pública.', 6),
(NULL, 18, DATEADD(DAY,-18,GETDATE()), 'Inspección general de señal.', 7),
(NULL, 19, DATEADD(DAY,-19,GETDATE()), 'Cambio de cable troncal.', 8),
(NULL, 20, DATEADD(DAY,-20,GETDATE()), 'Reinstalación de firmware.', 9),
(21, NULL, DATEADD(DAY,-21,GETDATE()), 'Revisión general de alumbrado.', 10),
(22, NULL, DATEADD(DAY,-22,GETDATE()), 'Cambio de poste averiado.', 11),
(23, NULL, DATEADD(DAY,-23,GETDATE()), 'Inspección de luminaria defectuosa.', 2),
(24, NULL, DATEADD(DAY,-24,GETDATE()), 'Reparación de cableado.', 3),
(25, NULL, DATEADD(DAY,-25,GETDATE()), 'Revisión del panel de energía.', 4),
(NULL, 21, DATEADD(DAY,-21,GETDATE()), 'Mantenimiento WiFi trimestral.', 5),
(NULL, 22, DATEADD(DAY,-22,GETDATE()), 'Optimización de señal.', 6),
(NULL, 23, DATEADD(DAY,-23,GETDATE()), 'Reemplazo de AP remoto.', 7),
(NULL, 24, DATEADD(DAY,-24,GETDATE()), 'Prueba de velocidad de conexión.', 8),
(NULL, 25, DATEADD(DAY,-25,GETDATE()), 'Revisión de fibra óptica.', 9);



INSERT INTO Core.Contacto (Valor, IdTipoContacto)
VALUES
('juan.perez@example.com',1),
('maria.gomez@example.com',1),
('carlos.lopez@example.com',1),
('laura.morales@example.com',1),
('andres.fernandez@example.com',1),
('3105551001',2),
('3115551002',2),
('3125551003',2),
('3135551004',2),
('3145551005',2),
('Cra 10 #45-20, Bogotá',3),
('Av 68 #30-15, Medellín',3),
('Cl 72 #14-35, Cali',3),
('Av 4 #33-22, Barranquilla',3),
('Cl 60 #22-18, Bucaramanga',3),
('diana.rojas@example.com',1),
('roberto.mendez@example.com',1),
('sofia.patino@example.com',1),
('camilo.alvarez@example.com',1),
('lina.ospina@example.com',1),
('3155551010',2),
('3165551011',2),
('3175551012',2),
('3185551013',2),
('3195551014',2),
('Av 9 #100-45, Bogotá',3),
('Cra 45 #15-25, Cali',3),
('Cl 80 #20-10, Medellín',3),
('Av 33 #12-11, Cartagena',3),
('Cl 90 #40-22, Cúcuta',3),
('julian.vargas@example.com',1),
('paula.garcia@example.com',1),
('felipe.rincon@example.com',1),
('carolina.torres@example.com',1),
('oscar.castro@example.com',1),
('3205551015',2),
('3215551016',2),
('3225551017',2),
('3235551018',2),
('3245551019',2),
('Cra 12 #50-18, Pasto',3),
('Cl 55 #30-20, Manizales',3),
('Av 26 #75-11, Armenia',3),
('Cl 65 #24-15, Pereira',3),
('Av 19 #22-33, Ibagué',3),
('luz.gomez@example.com',1),
('fernando.nino@example.com',1),
('angelica.soto@example.com',1),
('ivan.mendoza@example.com',1),
('patricia.lopez@example.com',1);


INSERT INTO Core.UsuarioContacto (IdUsuario, IdContacto, EsPrincipal)
VALUES
(1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,5,1),
(6,6,1),(7,7,1),(8,8,1),(9,9,1),(10,10,1),
(11,11,1),(12,12,1),(13,13,1),(14,14,1),(15,15,1),
(16,16,1),(17,17,1),(18,18,1),(19,19,1),(20,20,1),
(21,21,1),(22,22,1),(23,23,1),(24,24,1),(25,25,1),
(26,26,1),(27,27,1),(28,28,1),(29,29,1),(30,30,1),
(31,31,1),(32,32,1),(33,33,1),(34,34,1),(35,35,1),
(36,36,1),(37,37,1),(38,38,1),(39,39,1),(40,40,1),
(41,41,1),(42,42,1),(43,43,1),(44,44,1),(45,45,1),
(46,46,1),(47,47,1),(48,48,1),(49,49,1),(50,50,1);


INSERT INTO Core.RolCompania (IdUsuario, IdCompania, IdRol, FechaIngreso)
VALUES
(1,1,1,DATEADD(DAY,-400,GETDATE())),
(2,2,2,DATEADD(DAY,-395,GETDATE())),
(3,3,3,DATEADD(DAY,-390,GETDATE())),
(4,4,4,DATEADD(DAY,-385,GETDATE())),
(5,5,5,DATEADD(DAY,-380,GETDATE())),
(6,6,6,DATEADD(DAY,-375,GETDATE())),
(7,7,7,DATEADD(DAY,-370,GETDATE())),
(8,8,8,DATEADD(DAY,-365,GETDATE())),
(9,9,9,DATEADD(DAY,-360,GETDATE())),
(10,10,10,DATEADD(DAY,-355,GETDATE())),
(11,11,1,DATEADD(DAY,-350,GETDATE())),
(12,12,2,DATEADD(DAY,-345,GETDATE())),
(13,13,3,DATEADD(DAY,-340,GETDATE())),
(14,14,4,DATEADD(DAY,-335,GETDATE())),
(15,15,5,DATEADD(DAY,-330,GETDATE())),
(16,16,6,DATEADD(DAY,-325,GETDATE())),
(17,17,7,DATEADD(DAY,-320,GETDATE())),
(18,18,8,DATEADD(DAY,-315,GETDATE())),
(19,19,9,DATEADD(DAY,-310,GETDATE())),
(20,20,10,DATEADD(DAY,-305,GETDATE())),
(21,1,2,DATEADD(DAY,-300,GETDATE())),
(22,2,3,DATEADD(DAY,-295,GETDATE())),
(23,3,4,DATEADD(DAY,-290,GETDATE())),
(24,4,5,DATEADD(DAY,-285,GETDATE())),
(25,5,6,DATEADD(DAY,-280,GETDATE())),
(26,6,7,DATEADD(DAY,-275,GETDATE())),
(27,7,8,DATEADD(DAY,-270,GETDATE())),
(28,8,9,DATEADD(DAY,-265,GETDATE())),
(29,9,10,DATEADD(DAY,-260,GETDATE())),
(30,10,1,DATEADD(DAY,-255,GETDATE())),
(31,11,2,DATEADD(DAY,-250,GETDATE())),
(32,12,3,DATEADD(DAY,-245,GETDATE())),
(33,13,4,DATEADD(DAY,-240,GETDATE())),
(34,14,5,DATEADD(DAY,-235,GETDATE())),
(35,15,6,DATEADD(DAY,-230,GETDATE())),
(36,16,7,DATEADD(DAY,-225,GETDATE())),
(37,17,8,DATEADD(DAY,-220,GETDATE())),
(38,18,9,DATEADD(DAY,-215,GETDATE())),
(39,19,10,DATEADD(DAY,-210,GETDATE())),
(40,20,1,DATEADD(DAY,-205,GETDATE())),
(41,1,3,DATEADD(DAY,-200,GETDATE())),
(42,2,4,DATEADD(DAY,-195,GETDATE())),
(43,3,5,DATEADD(DAY,-190,GETDATE())),
(44,4,6,DATEADD(DAY,-185,GETDATE())),
(45,5,7,DATEADD(DAY,-180,GETDATE())),
(46,6,8,DATEADD(DAY,-175,GETDATE())),
(47,7,9,DATEADD(DAY,-170,GETDATE())),
(48,8,10,DATEADD(DAY,-165,GETDATE())),
(49,9,1,DATEADD(DAY,-160,GETDATE())),
(50,10,2,DATEADD(DAY,-155,GETDATE()));



USE CiudadInteligenteMER;
GO
INSERT INTO Ops.MantenimientoEmpleado (IdMantenimiento, IdEmpleado)
VALUES
(1,1),(1,2),
(2,3),(2,4),
(3,5),(3,6),
(4,7),(4,8),
(5,9),(5,10),
(6,1),(6,3),
(7,2),(7,4),
(8,5),(8,7),
(9,6),(9,8),
(10,9),(10,10),
(11,1),(11,2),
(12,3),(12,4),
(13,5),(13,6),
(14,7),(14,8),
(15,9),(15,10),
(16,1),(16,3),
(17,2),(17,4),
(18,5),(18,7),
(19,6),(19,8),
(20,9),(20,10),
(21,1),(21,2),
(22,3),(22,4),
(23,5),(23,6),
(24,7),(24,8),
(25,9),(25,10),
(26,1),(26,3),
(27,2),(27,4),
(28,5),(28,7),
(29,6),(29,8),
(30,9),(30,10),
(31,1),(31,2),
(32,3),(32,4),
(33,5),(33,6),
(34,7),(34,8),
(35,9),(35,10),
(36,1),(36,3),
(37,2),(37,4),
(38,5),(38,7),
(39,6),(39,8),
(40,9),(40,10),
(41,1),(41,2),
(42,3),(42,4),
(43,5),(43,6),
(44,7),(44,8),
(45,9),(45,10),
(46,1),(46,3),
(47,2),(47,4),
(48,5),(48,7),
(49,6),(49,8),
(50,9),(50,10);

USE CiudadInteligenteMER;
GO
SET NOCOUNT ON;

DECLARE @i INT = 1;
DECLARE @max INT = 1000000;

WHILE @i <= @max
BEGIN
    INSERT INTO IoT.SensorLuminaria (IdAlumbrado, FechaMedicion, Consumo, Temperatura, Luminiscencia)
    SELECT 
        (ABS(CHECKSUM(NEWID())) % 50) + 1 AS IdAlumbrado,          -- usa IdAlumbrado entre 1 y 50
        DATEADD(SECOND, -@i, GETDATE()) AS FechaMedicion,         -- fecha distinta por cada fila
        ROUND(RAND(CHECKSUM(NEWID())) * 20 + 5, 2) AS Consumo,    -- entre 5 y 25
        ROUND(RAND(CHECKSUM(NEWID())) * 15 + 20, 2) AS Temperatura, -- entre 20 y 35
        ROUND(RAND(CHECKSUM(NEWID())) * 300 + 300, 2) AS Luminiscencia; -- entre 300 y 600

    SET @i += 1;

    IF @i % 10000 = 0
        PRINT CONCAT('Insertadas ', @i, ' filas...');
END;
GO

USE CiudadInteligenteMER;
GO
SET NOCOUNT ON;

DECLARE @i INT = 1;
DECLARE @max INT = 1000000;

WHILE @i <= @max
BEGIN
    INSERT INTO IoT.SensorWiFi
        (IdWiFi, IdUsuario, FechaConexion, FechaMedicion, VelocidadSubida, VelocidadBajada, DireccionIP, IdTipoConexion)
    SELECT
        (ABS(CHECKSUM(NEWID())) % 50) + 1 AS IdWiFi,                 -- entre 1 y 50
        (ABS(CHECKSUM(NEWID())) % 10) + 1 AS IdUsuario,              -- entre 1 y 10
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, GETDATE())       -- fecha aleatoria del último año
            + DATEADD(SECOND, ABS(CHECKSUM(NEWID())) % 86400, 0) AS FechaConexion,
        DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, GETDATE())       
            + DATEADD(SECOND, ABS(CHECKSUM(NEWID())) % 86400, 0) AS FechaMedicion,
        ROUND(RAND(CHECKSUM(NEWID())) * 20 + 5, 2) AS VelocidadSubida,   -- entre 5 y 25 Mbps
        ROUND(RAND(CHECKSUM(NEWID())) * 80 + 10, 2) AS VelocidadBajada,  -- entre 10 y 90 Mbps
        CONCAT('192.168.', (ABS(CHECKSUM(NEWID())) % 255), '.', (ABS(CHECKSUM(NEWID())) % 255)) AS DireccionIP,
        (ABS(CHECKSUM(NEWID())) % 6) + 1 AS IdTipoConexion;          -- entre 1 y 6 tipos
    SET @i += 1;

    IF @i % 10000 = 0
        PRINT CONCAT('Insertadas ', @i, ' filas...');
END;
GO


USE CiudadInteligenteMER;
GO
SELECT COUNT(*) AS TotalSensorWiFi FROM IoT.SensorWiFi;
GO
USE CiudadInteligenteMER;
GO
SELECT COUNT(*) AS TotalSensorLuminaria FROM IoT.SensorLuminaria;
GO





USE CiudadInteligenteDW;
GO

SELECT * FROM sys.schemas;
GO
SELECT * FROM sys.tables;
GO


