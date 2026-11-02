-- ══════════════════════════════════════════
-- BodegaTech — Script de Inventario
-- Autor: Estudiante / DBA
-- Fecha: 2026-11-02
-- Motor utilizado: SQL Server (SSMS)
-- ══════════════════════════════════════════

-- (Opcional) Si preferís trabajar dentro de una base de datos propia:
CREATE DATABASE BodegaTech_DB;
GO
USE BodegaTech_DB;
GO

-- ── SECCIÓN DDL ──────────────────────────

-- Paso 1: DROP TABLE
-- Elimina la tabla si ya existe para que el script sea repetible sin errores.
DROP TABLE IF EXISTS inventario;
GO

-- Paso 2: CREATE TABLE
-- Creación de la estructura de la tabla de inventario
CREATE TABLE inventario (
    id_producto INT PRIMARY KEY,                       -- Explicación: Se usa INT como clave primaria única para identificar de forma eficiente y unívoca cada producto.
    nombre_producto VARCHAR(100) NOT NULL,             -- Explicación: VARCHAR(100) permite almacenar nombres descriptivos de longitud variable con un límite seguro y eficiente.
    categoria VARCHAR(50),                             -- Categoría del producto
    precio_unitario DECIMAL(10,2) NOT NULL,            -- Explicación: Se utiliza DECIMAL(10,2) de manera obligatoria para valores monetarios, evitando errores de redondeo típicos de FLOAT.
    stock_actual INT DEFAULT 0,                        -- Unidades disponibles actualmente en stock
    stock_minimo INT DEFAULT 0,                        -- Umbral mínimo de reposición
    fecha_ingreso DATE NOT NULL,                       -- Fecha de ingreso al inventario
    activo TINYINT DEFAULT 1                           -- 1 = disponible, 0 = descontinuado (Nota: En SQL Server se usa TINYINT sin especificar longitud)
);
GO

-- ── SECCIÓN DML ──────────────────────────

-- Paso 3: INSERT INTO
-- Carga inicial de los 10 productos del inventario
INSERT INTO inventario (id_producto, nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo) VALUES
  (1,  'Laptop Pro 15',         'Computación',    1200.00, 15,  3, '2024-01-10', 1),
  (2,  'Mouse Inalámbrico',     'Accesorios',       28.00, 80, 10, '2024-01-10', 1),
  (3,  'Monitor 4K 27"',        'Computación',     450.00, 12,  2, '2024-01-15', 1),
  (4,  'Teclado Mecánico',      'Accesorios',       95.00, 40,  5, '2024-01-15', 1),
  (5,  'Laptop Basic 14',       'Computación',     650.00, 20,  3, '2024-02-01', 1),
  (6,  'Auriculares BT Pro',    'Audio',           120.00, 35,  5, '2024-02-01', 1),
  (7,  'Hub USB-C 7 puertos',   'Accesorios',       45.00, 60, 10, '2024-02-10', 1),
  (8,  'Webcam HD 1080p',       'Accesorios',       85.00, 25,  5, '2024-02-10', 1),
  (9,  'SSD Externo 1TB',       'Almacenamiento',  130.00, 18,  3, '2024-03-01', 1),
  (10, 'Parlante Bluetooth',    'Audio',            60.00, 45,  8, '2024-03-01', 1);
GO

-- Paso 4: UPDATE con WHERE (Ventas del día)
-- Actualización del stock restando las unidades vendidas y asegurando el uso de WHERE por id_producto.

-- Venta de Laptop Pro 15 (id: 1) — 3 unidades vendidas (Stock pasa de 15 a 12)
UPDATE inventario 
SET stock_actual = stock_actual - 3 
WHERE id_producto = 1;

-- Venta de Mouse Inalámbrico (id: 2) — 12 unidades vendidas (Stock pasa de 80 a 68)
UPDATE inventario 
SET stock_actual = stock_actual - 12 
WHERE id_producto = 2;

-- Venta de Auriculares BT Pro (id: 6) — 5 unidades vendidas (Stock pasa de 35 a 30)
UPDATE inventario 
SET stock_actual = stock_actual - 5 
WHERE id_producto = 6;
GO

-- Paso 5: UPDATE adicional (Producto descontinuado)
-- La Webcam HD 1080p (id: 8) fue descontinuada, se marca activo = 0
UPDATE inventario 
SET activo = 0 
WHERE id_producto = 8;
GO

-- Paso 6: SELECT de validación
-- Ver la tabla completa para confirmar que los datos y actualizaciones se cargaron correctamente
SELECT * FROM inventario;
GO