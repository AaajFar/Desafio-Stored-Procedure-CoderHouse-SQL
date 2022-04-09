USE fabrica_guitarras;

/* Store Procedure #1: Sirve para ordenar la tabla de guitarras según los parametros que ingresa
el usuario. En total recibe 2 parametros, el primero corresponde a sobre que campo se va a hacer
el orden, el segundo corresponde a la forma en que se va a hacer ese orden (ASC, DESC).
Para poder realizarlo utilicé el condicional CASE para cada caso, de tal forma que cuando se llama
al SP los parametros que espera son de tipo INT, siendo que en el caso del campo son valores
del 1 al 6 y son en el mismo orden que esta la tabla, y en el caso del orden son valores 1 para
ASC y 2 para DESC. Por ejemplo si hicieramos un CALL con parametros 3 y 2 lo ordenaría por 
modelo de forma descendente.
*/

DELIMITER //
CREATE PROCEDURE sp_orden_guitarras (IN campo INT, IN orden INT)
BEGIN
    SELECT * 
    FROM guitarras 
    ORDER BY
    CASE WHEN campo = 1 AND orden = 1 THEN id END,
    CASE WHEN campo = 1 AND orden = 2 THEN id END DESC,
    CASE WHEN campo = 2 AND orden = 1 THEN tipo END,
	CASE WHEN campo = 2 AND orden = 2 THEN tipo END DESC,
	CASE WHEN campo = 3 AND orden = 1 THEN modelo END,
	CASE WHEN campo = 3 AND orden = 2 THEN modelo END DESC,
	CASE WHEN campo = 4 AND orden = 1 THEN ano END,
	CASE WHEN campo = 4 AND orden = 2 THEN ano END DESC,
	CASE WHEN campo = 5 AND orden = 1 THEN stock END,
	CASE WHEN campo = 5 AND orden = 2 THEN stock END DESC,
	CASE WHEN campo = 6 AND orden = 1 THEN precio END,
	CASE WHEN campo = 6 AND orden = 2 THEN precio END DESC;
END
//
DELIMITER ;

-- PRUEBA PARA STORE PROCEDURE #1
/*
CALL sp_orden_guitarras(6,2);
*/




/* Store Procedure #2: Sirve para ingresar nuevos registros a la tabla guitarras
El funcionamiento es muy simple, recibe los mismos parametros que luego usa dentro de la
funcion para hacer el INSERT a la tabla, excepto por el 'id' que en este caso al ser
autoincremental se le pasa el valor NULL
*/

DELIMITER //
CREATE PROCEDURE insertar_guitarra (IN tipo ENUM('electrica', 'clasica', 'electroacustica', 
									'clasica nino', 'clasica concierto'),
									IN modelo VARCHAR(60),
                                    IN ano YEAR,
                                    IN stock INT,
                                    IN precio INT)
BEGIN
	INSERT INTO guitarras VALUES
    (null, tipo, modelo, ano, stock, precio);
END					
//
DELIMITER ; 

-- PRUEBA PARA STORE PROCEDURE #2
/*
CALL insertar_guitarra ('electrica', 'stratocaster', '2022', '500', '60000');
*/



/* Store Procedure #3: Sirve para ingresar nuevos registros a la tabla de relación de 
materiales_guitarras, con un funcionamiento similar al anterior en el cual se le pasa
los mismos parametros para que luego dentro de la funcion se haga el INSERT a la tabla
*/

DELIMITER //
CREATE PROCEDURE insertar_materiales_guitarras (IN materialid INT,
												IN guitarraid INT,
                                                IN cantidad INT)
BEGIN
	INSERT INTO materiales_guitarras VALUES
    (materialid, guitarraid, cantidad);
END					
//
DELIMITER ;

-- PRUEBA PARA STORED PROCEDURE #3
/*
CALL insertar_materiales_guitarras(5, 21, 1);
CALL insertar_materiales_guitarras(15, 21, 1);
CALL insertar_materiales_guitarras(24, 21, 1);
CALL insertar_materiales_guitarras(34, 21, 1);
*/
