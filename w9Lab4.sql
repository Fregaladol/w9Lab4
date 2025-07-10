CREATE DATABASE turismos;

USE turismos;

CREATE TABLE marca (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE turismos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    modelo VARCHAR(100) NOT NULL,
    anio INT NOT NULL,
    color VARCHAR(30),
    id_marca INT,
    FOREIGN KEY (id_marca) REFERENCES marca(id)
);


INSERT INTO marca (nombre) VALUES 
('Toyota'),
('Ford'),
('BMW'),
('Volkswagen'),
('Honda');

INSERT INTO turismos (modelo, anio, color, id_marca) VALUES
('Corolla', 2022, 'Rojo', 1),
('Camry', 2021, 'Negro', 1),
('Yaris', 2023, 'Blanco', 1),
('RAV4', 2020, 'Gris', 1),
('Hilux', 2019, 'Azul', 1),
('Focus', 2022, 'Blanco', 2),
('Mustang', 2023, 'Rojo', 2),
('Fiesta', 2021, 'Negro', 2),
('Explorer', 2020, 'Gris', 2),
('Escape', 2019, 'Azul', 2),
('Serie 3', 2023, 'Negro', 3),
('Serie 5', 2022, 'Blanco', 3),
('X1', 2021, 'Gris', 3),
('X3', 2020, 'Rojo', 3),
('Golf', 2023, 'Azul', 4),
('Polo', 2021, 'Blanco', 4),
('Tiguan', 2020, 'Negro', 4),
('Civic', 2023, 'Gris', 5),
('Accord', 2022, 'Rojo', 5),
('CR-V', 2021, 'Negro', 5);

-- Crear table de una consulta

CREATE TABLE turismos_22 AS
SELECT t.modelo, t.anio, t.color, m.nombre AS marca
FROM turismos t, marca m
WHERE t.id_marca = m.id AND t.anio = 2022 ;

SHOW TABLES;
SELECT *
FROM turismos_22;

-- Crear una vista

CREATE VIEW turismos_2223 AS
SELECT m.nombre AS marca, t.modelo, t.anio, t.color 
FROM turismos t, marca m
WHERE t.id_marca = m.id AND anio BETWEEN 2022 AND 2023;

SELECT * 
FROM turismos_2223;

-- Actualizar vista

CREATE OR REPLACE VIEW turismos_2223 AS
SELECT t.modelo, t.anio, t.color, m.nombre AS marca
FROM turismos t, marca m
WHERE t.id_marca = m.id
ORDER BY m.nombre;

SELECT *
FROM turismos_2223; 

SHOW TABLES;

SHOW FULL TABLES WHERE Table_type = 'VIEW';  -- para vistas
SHOW FULL TABLES WHERE Table_type = 'BASE TABLE';  -- para tablas

DROP VIEW turismos_2223; 

WITH cantidad_modelos_mayor_3 AS (
    SELECT m.nombre AS marca, COUNT(*) AS cantidad_modelos
    FROM turismos t, marca m
    WHERE t.id_marca = m.id
    GROUP BY m.nombre
    HAVING COUNT(*) > 3
)

-- no se puede hacer un order by en CTE

SELECT *
FROM cantidad_modelos_mayor_3
ORDER BY cantidad_modelos DESC;

-- Usar CTE viene bien para separa logicas complejas, solo la quiero para un momento es reutilizable
-- Usar la vista para usar despues de cerrar sesion pero no guardo datos solo la expresion
-- Usar creat tabla de una query si quiero guardar los datos