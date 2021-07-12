-- Trabajo Practico N°2, Elizabeth Belén Silva
/* Crear Triggers para registrar en la tabla control las transacciones insert, 
	update o delete de las tablas:
        - artículos
        - facturas 
        - detalles 
        - clientes 
        
        
drop  table if exists control;
create table control(
	id int auto_increment primary key,
    tabla varchar(25) not null,
    accion enum('INSERT','DELETE','UPDATE'),
    fecha date,
    hora time,
    usuario varchar(50),
    idRegistro int
);


 truncate control; */
        
use negocioWebRopa;
-- Tabla articulos
     /* TR_articulos_insert */
DROP TRIGGER IF EXISTS TR_articulos_insertS;
DELIMITER //
CREATE TRIGGER TR_articulos_insertS
AFTER INSERT ON articulos
FOR EACH ROW
    BEGIN
    INSERT INTO control(tabla, accion, fecha, hora, usuario, idRegistro)
    VALUES('articulos', 'insert', curdate(), curtime(), current_user(), NEW.id);
    END //
DELIMITER ; 
     
     /* TR_articulos_Update */
DROP TRIGGER IF EXISTS TR_articulos_updateS;    
DELIMITER //
CREATE TRIGGER TR_articulos_updateS
AFTER INSERT ON articulos
FOR EACH ROW
     BEGIN
	 INSERT INTO control(tabla, accion, fecha, hora, usuario, idRegistro) 
	 VALUES ('articulos','update',current_date(),current_time(),current_user(),NEW.id);
     END// 
DELIMITER ;       

    /* TR_articulos_delete */
DROP TRIGGER IF EXISTS TR_articulos_deleteS;   
DELIMITER //
CREATE TRIGGER TR_articulos_deleteS
BEFORE DELETE ON articulos
FOR EACH ROW
    BEGIN
	INSERT INTO control (tabla,accion,fecha,hora,usuario,idRegistro) 
    VALUES ('articulos','delete',current_date(),current_time(),current_user(),OLD.id);
    END//
DELIMITER ;       


-- Tabla facturas
     /*TR_facturas_insert*/
DROP TRIGGER IF EXISTS TR_facturas_insertS;
DELIMITER //
CREATE TRIGGER TR_facturas_insertS
AFTER INSERT ON facturas
FOR EACH ROW
  BEGIN
  INSERT INTO control(tabla, accion, fecha, hora, usuario, idRegistro)
  VALUES('facturas', 'insert', curdate(), curtime(), current_user(), NEW.id);
  END //
DELIMITER ; 

     /*TR_facturas_update*/     
DROP TRIGGER IF EXISTS TR_facturas_updateS; 
DELIMITER //
CREATE TRIGGER TR_facturas_updateS
AFTER UPDATE ON facturas
FOR EACH ROW
  BEGIN
  INSERT INTO control(tabla, accion, fecha, hora, usuario, idRegistro)
  VALUES('facturas', 'update', curdate(), curtime(), current_user(),New.id);
  END //
DELIMITER ; 
 
      /*TR_facturas_delete*/ 
DROP TRIGGER IF EXISTS TR_facturas_deleteS; 
DELIMITER //
CREATE TRIGGER TR_facturas_deleteS
BEFORE DELETE ON facturas
FOR EACH ROW
BEGIN
INSERT INTO control(tabla, accion, fecha, hora, usuario, idRegistro)
VALUES('facturas', 'delete', curdate(), curtime(), current_user(), OLD.id);
END; //
DELIMITER ;
        
        
 -- Tabla detalles
     /*TR_detalles_insert*/    
DROP TRIGGER IF EXISTS TR_detalles_insertS;
DELIMITER //
CREATE TRIGGER TR_detalles_insertS
AFTER INSERT ON detalles
FOR EACH ROW
BEGIN
INSERT INTO control (tabla, accion, fecha, hora, usuario, idRegistro) 
VALUES ('detalles','insert', curdate(), curtime(), current_user(), NEW.id);
END // 
DELIMITER ;
        
     /*TR_detalles_update*/
DROP TRIGGER IF EXISTS TR_detalles_updateS; 
DELIMITER //
CREATE TRIGGER TR_detalles_updateS
AFTER UPDATE ON detalles
FOR EACH ROW
  BEGIN
  INSERT INTO control(tabla, accion, fecha, hora, usuario, idRegistro)
  VALUES('detalles','update', curdate(), curtime(), current_user(), NEW.id);
  END //
DELIMITER ;	
    
     /*TR_detalles_delete*/
DROP TRIGGER IF EXISTS TR_detalles_deleteS; 
DELIMITER //
CREATE TRIGGER TR_detalles_deleteS
AFTER DELETE ON detalles
FOR EACH ROW
  BEGIN
  INSERT INTO control(tabla, accion, fecha, hora, usuario, idRegistro)
  VALUES('detalles','delete', curdate(), curtime(), current_user(), OLD.id);
  END //
DELIMITER ;        
        
        
 -- Tabla clientes
     /*TR_clientes_insert*/ 
DROP TRIGGER IF EXISTS TR_clientes_insertS; 
DELIMITER //
CREATE TRIGGER TR_clientes_insertS
BEFORE INSERT ON clientes
FOR EACH ROW
  BEGIN
  INSERT INTO control(tabla, accion, fecha, hora, usuario, idRegistro)
  VALUES('clientes', 'insert', curdate(), curtime(), current_user(),New.id);
  END //
DELIMITER ;

      /*TR_clientes_update*/
DROP TRIGGER IF EXISTS TR_clientes_updateS; 
DELIMITER //
CREATE TRIGGER TR_clientes_updateS
AFTER UPDATE ON clientes
FOR EACH ROW
  BEGIN
  INSERT INTO control(tabla, accion, fecha, hora, usuario, idRegistro)
  VALUES('clientes', 'update', curdate(), curtime(), current_user(), New.id);
  END //
DELIMITER ;      

       /*TR_clientes_delete*/ 
DROP TRIGGER IF EXISTS TR_clientes_deleteS;
DELIMITER //
CREATE TRIGGER TR_clientes_deleteS
AFTER DELETE ON clientes
FOR EACH ROW
  BEGIN
  INSERT INTO control(tabla, accion, fecha, hora, usuario, idRegistro)
  VALUES('clientes', 'delete', curdate(), curtime(), current_user(), OLD.id);
  END //
DELIMITER ;        
        
        