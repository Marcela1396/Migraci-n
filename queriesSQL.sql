-- # ========================================================================================== # 
-- # SANDRA MARCELA GUERRERO CALVACHE
-- # UNIVERSIDAD DE NARIÑO
-- # ======== CONSULTAS EJERCICIO PRÁCTICO EN UN MOTOR SQL : PosgreSQL ======== #

-- Con base en la implementación de la base de datos para el Hotel, generar los scripts SQL 
-- necesarios para  resolver las siguientes consultas:

-- # ========================================================================================== #
-- Opcion 1
SELECT * FROM empleado;
-- Opcion 2
SELECT numreg, nombre, incorporacion, sueldo, cods FROM empleado;

-- # ========================================================================================== #
SELECT nombre, descripcion from servicio join empleado on servicio.numreg = empleado.NumReg 
where descripcion like '%estauran%';

-- # ========================================================================================== #
select nombre from servicio join empleado on servicio.numreg = empleado.NumReg 
where empleado.cods = (select cods from empleado where nombre like '%orge%');

-- # ========================================================================================== #
-- exclusivamente para aquellos que tengan algún servicio asignado.
select nombre, descripcion from empleado join servicio on empleado.NumReg = servicio.numreg

-- # ========================================================================================== #
-- la actualidad (no tienen fecha de salida).
select habitacion.numero, habitacion.tipo, precio.precio 
from precio join habitacion on precio.tipo = habitacion.tipo
join factura on habitacion.numero = factura.numero 
where factura.salida is null;

-- # ========================================================================================== #
-- hotel (no número total de noches, sino estancias diferentes: una persona que ha estado tres 
-- veces diferentes de una noche en el hotel habrá "estado" más veces que otra persona que ha 
-- estado una vez durante tres noches)
select factura.dni, cliente.nombre, cliente.apellidos, count(factura.dni) as NumEstancias 
from  factura join cliente on factura.dni = cliente.dni 
group by factura.dni, cliente.nombre, cliente.apellidos 
having count(factura.dni) = (select max(NumEstancias) as Maximo 
from (select count(factura.dni) as NumEstancias from factura  group by factura.dni ) T1)

-- # ========================================================================================== #
-- 7) Obtener los datos del empleado o empleados que hayan limpiado todas las habitaciones del 
-- hotel
select t1.nombre, count(t1.nombre) as NumeroHab from 
(select distinct empleado.nombre , limpieza.numero 
from empleado join limpieza on empleado.numreg = limpieza.numreg)t1
group by t1.nombre
having count(t1.nombre) = (select count(numero) from habitacion)

-- # ========================================================================================== #
-- 8) Obtener el listado de los clientes que ocupen o hayan ocupado alguna vez habitaciones de 
-- los dos tipos (individual y doble)
select distinct(cliente.nombre) as Cliente from cliente join factura on cliente.dni = factura.dni
join habitacion on factura.numero = habitacion.numero where habitacion.tipo like '%oble%'
intersect
select distinct(cliente.nombre) as Cliente from cliente join factura on cliente.dni = factura.dni
join habitacion on factura.numero = habitacion.numero where habitacion.tipo like '%ndivi%'

-- # ========================================================================================== #
-- 9) Obtener un listado de los proveedores cuyas facturas hayan sido aprobadas únicamente por 
-- el encargado y no por el responsable de un servicio.

select  distinct proveedor.nombre as Proveedor, empleado.nombre as Encargado from 
proveedor join factura_prov on proveedor.nif = factura_prov.nif
join empleado on factura_prov.numreg = empleado.numreg

-- # ========================================================================================== #
-- 10) Igualar el sueldo del empleado que menos cobra dentro del servicio de "restaurante" con 
-- el del empleado que más cobra del mismo servicio

select servicio.descripcion, max(empleado.sueldo) as SueldoMax,  min(empleado.sueldo) as SueldoMin
from empleado join servicio on empleado.cods = servicio.cods
where servicio.descripcion like '%estaur%'
group by servicio.descripcion

-- # ========================================================================================== #
-- 11) Incrementar en un 10% el sueldo del empleado de "limpieza" que más habitaciones haya limpiado.
select t1.nombre, count(t1.nombre) as NumeroHab, t1.sueldo, t1.sueldo + (t1.sueldo*0.1) as SueldoNuevo from 
(select distinct empleado.nombre , empleado.sueldo, limpieza.numero 
from empleado join limpieza on empleado.numreg = limpieza.numreg)t1
group by t1.nombre, t1.sueldo
having count(t1.nombre) = (select count(numero) from habitacion)