-- Trabajo PracticoN°1, Elizabeth Belén Silva
/* Crear los siguientes store procedures para la base negocioWebRopa
    - Tabla articulos
		SP_Articulos_Insert_Min, SP_Articulos_Insert_Full
        SP_Articulos_Delete, SP_Articulos_Update, SP_Articulos_All, SP_Articulos_Reponer
        
	- Tabla facturas
		SP_Facturas_Insert, SP_Facturas_Delete, SP_Facturas_Update,SP_Facturas_All,SP_Facturas_AgregarDetalle
        
	- Tabla detalles
		SP_Detalles_Delete, SP_Detalles_All
*/
use negocioWebRopa;
-- Tabla articulos
		/* SP_Articulos_Insert_Min */
DROP PROCEDURE IF EXISTS SP_Articulos_Insert_Min;
DELIMITER // 
CREATE PROCEDURE SP_Articulos_Insert_Min (in Pdescripcion varchar(25))
BEGIN
	INSERT INTO articulos (descripcion)
	VALUES (Pdescripcion);
	END//
DELIMITER ; 
CALL SP_Articulos_Insert_Min('Barbijo');


		/* SP_Articulos_Insert_Full */
DROP PROCEDURE IF EXISTS SP_Articulos_Insert_Full;	
DELIMITER //
CREATE PROCEDURE SP_Articulos_Insert_Full ( 
    IN Pdescripcion varchar(25),
	Ptipo varchar(20),
	Pcolor varchar(20),
	Ptalle_num varchar(20),
	Pstock int,
    PstockMin int,
    PstockMax int,
    Pcosto double,
    Pprecio double,
	Ptemporada varchar(20))
BEGIN
	INSERT INTO articulos (descripcion,tipo,color,talle_num,stock,stockMin,stockMax,costo,precio,temporada)
    VALUES (Pdescripcion,Ptipo,Pcolor,Ptalle_num,Pstock,PstockMin,PstockMax,Pcosto,Pprecio,Ptemporada);
	END//
DELIMITER ;
CALL SP_Articulos_Insert_Full('Velo', 'ROPA', 'rojo', 'unico', 20, 15, 30, 900, 1400, 'VERANO'); 
 
 
		/* SP_Articulos_Delete */
DROP PROCEDURE IF EXISTS SP_Articulos_Delete;
DELIMITER //
CREATE PROCEDURE SP_Articulos_Delete (in Pid int)
	BEGIN
	DELETE from articulos 
	WHERE id=Pid;
	END//
DELIMITER ;			
CALL SP_Articulos_Delete(27);

		
		/* SP_Articulos_Update */
DROP PROCEDURE IF EXISTS SP_Articulos_Update;
DELIMITER // 
CREATE PROCEDURE SP_Articulos_Update(
		IN Pid int,
        Pdescripcion varchar(25),
		Ptipo enum('CALZADO', 'ROPA'),
		Pcolor varchar(20),
		Ptalle_num varchar(20),
		Pstock int,
		PstockMin int,
		PstockMax int,
		Pcosto double,
		Pprecio double,
		Ptemporada enum('VERANO', 'OTOÑO','INVIERNO'))
	BEGIN
	UPDATE articulos 
	SET descripcion=Pdescripcion, tipo=Ptipo, color=Pcolor, talle_num=Ptalle_num,
		stock=Pstock, stockMin=PstockMin, stockMax=PstockMax,
		costo=Pcosto, precio=Pprecio, temporada=Ptemporada 
	WHERE id=Pid;
    END //
DELIMITER ;		
CALL SP_Articulos_Update(9, 'CALZA invierno', 'ROPA', 'Amarello', '35', 2, 5, 20, 1000, 3000, 'OTOÑO'); 

		
		/* SP_Articulos_All */
DROP PROCEDURE IF EXISTS SP_Articulos_All;
DELIMITER //
CREATE PROCEDURE SP_Articulos_All()
    BEGIN
    SELECT*FROM articulos;
    END //
DELIMITER ; 	
CALL SP_Articulos_All();

		
		/* SP_Articulos_Reponer */
DROP PROCEDURE IF EXISTS SP_Articulos_Reponer;  
DELIMITER //
CREATE PROCEDURE SP_Articulos_Reponer()
	BEGIN
	SELECT id idArticulo, descripcion,tipo,color,talle_num,stock,stockMin,stockMax,costo,precio,temporada 
	FROM articulos
    WHERE stock<stockMin;
	END//
DELIMITER ;
CALL SP_Articulos_Reponer();

-- select *from articulos;


-- Tabla facturas
		/* SP_Facturas_Insert*/ 
DROP PROCEDURE IF EXISTS SP_Facturas_Insert;  
DELIMITER //
CREATE PROCEDURE SP_Facturas_Insert(
	IN Pletra enum ('A', 'B', 'C'), 
    Pnumero int, 
	Pfecha date,
    PmedioDePago enum('EFECTIVO', 'DEBITO', 'TARJETA'),
    PidCliente int)
	BEGIN
    INSERT INTO facturas (letra, numero, fecha, medioDePago, idCliente) 
	VALUES (Pletra, Pnumero, Pfecha, PmedioDePago, PidCliente);
	END//
DELIMITER ;
CALL SP_Facturas_Insert('A',72,curdate(),'DEBITO',4);
       
        /* SP_Facturas_Delete */
DROP PROCEDURE IF EXISTS SP_Facturas_Delete;
DELIMITER //
CREATE PROCEDURE SP_Facturas_Delete (in Pid int)
	BEGIN
	DELETE from facturas
	WHERE id=Pid;
	END//
DELIMITER ;	        
 CALL SP_Facturas_Delete(6);
 
 
        /* SP_Facturas_Update */
DROP PROCEDURE IF EXISTS SP_Facturas_Update;
DELIMITER // 
CREATE PROCEDURE SP_Facturas_Update
	(IN Pid int,
    Pletra enum('A','B','C'),
    Pnumero int,
    Pfecha date,
    PmedioDePago enum('EFECTIVO', 'DEBITO', 'TARJETA'),
    PidCliente int)
	BEGIN
	UPDATE facturas 
	SET letra=Pletra, numero=Pnumero, fecha=Pfecha,
		medioDePago=PmedioDePago,idCliente=PidCliente
	WHERE id=Pid;
    END //
DELIMITER ;       
 CALL SP_Facturas_Update (1,'C', 65, curdate(), 'DEBITO', 3);
 
 
        /* SP_Facturas_All */
DROP PROCEDURE IF EXISTS SP_Facturas_All;
DELIMITER //
CREATE PROCEDURE SP_Facturas_All()
    BEGIN
    SELECT*FROM Facturas;
    END //
DELIMITER ;         
CALL SP_Facturas_All();

        
        /* SP_Facturas_AgregarDetalle */
DROP PROCEDURE IF EXISTS SP_Facturas_AgregarDetalle;        
DELIMITER // 
CREATE PROCEDURE SP_Facturas_AgregarDetalle(
	IN PidArticulo int,
    PidFactura int,
    Pprecio double,
    Pcantidad int)
	BEGIN
    INSERT INTO detalles(idArticulo,idFactura,precio,cantidad)
	VALUES(PidArticulo,PidFactura,Pprecio,Pcantidad);
	END //
DELIMITER ; 
CALL SP_Facturas_AgregarDetalle(10, 5, 45000, 12); 


 
-- Tabla detalles
		/* SP_Detalles_Delete */
DROP PROCEDURE IF EXISTS  SP_Detalles_Delete;
DELIMITER //
CREATE PROCEDURE SP_Detalles_Delete(
	IN DetId int)
	BEGIN
	DELETE FROM detalles
	WHERE id = DetId;
	END //
DELIMITER ; 	
Call SP_Detalles_Delete(5);

        
        /* SP_Detalles_All */     
DROP PROCEDURE IF EXISTS SP_Detalles_All;
DELIMITER //
CREATE PROCEDURE SP_Detalles_All()
       BEGIN
	   SELECT *FROM detalles;
       END //
DELIMITER ; 
Call SP_Detalles_All();
       
        