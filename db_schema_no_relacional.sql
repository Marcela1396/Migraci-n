-- #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-
-- PROCESO DE MIGRACIÒN DE UNA BASE DE DATOS IMPLEMENTADA EN UN SISTEMA SQL A UN NOSQL
-- Presentado por: Sandra Marcela Guerrero Calvache
-- Sistemas Avanzados de Bases de Datos
-------------------------------------------------------------------------------------
-- Sistemas de estudio: PostgreSQL y ArangoDB
-- #-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-

-- Script para la creación del esquema NoSQL en ArangoDB

-- Creaciòn de una base de datos en ArangoDB
db._createDatabase("hotel", {}, [{ username: "root", passwd: "", active: true}])

-- Seleccionar una base de datos para trabajar con ella
db._useDatabase("hotel")

-- Creación de una colección
db._create("cliente")
