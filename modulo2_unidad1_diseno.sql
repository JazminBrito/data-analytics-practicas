-- ==========================================================
-- Módulo 2 - Unidad 1: Diseño de Base de Datos para Sistema de Ventas
-- Archivo: modulo2_unidad1_diseno.sql
-- ==========================================================

-- 1. Tabla de Clientes
CREATE TABLE clientes (
    -- INT: Elegido para el identificador único porque es un número entero estándar, 
    -- ideal para claves primarias que se autoincrementan.
    id_cliente INT NOT NULL,
    
    -- VARCHAR(100): Permite almacenar cadenas de texto de longitud variable 
    -- con un límite máximo de 100 caracteres, suficiente para nombres y apellidos.
    nombre VARCHAR(100) NOT NULL,
    
    -- VARCHAR(MAX) (o TEXT): Se utiliza para textos largos como biografías o notas 
    -- donde no se conoce con exactitud la longitud máxima que ocuparán.
    perfil_bio VARCHAR(MAX),
    
    -- DATE: Almacena exclusivamente la fecha (año, mes y día) sin hora, 
    -- adecuado para registrar fechas de registro de usuarios.
    fecha_registro DATE NOT NULL,
    
    -- Definimos la clave primaria para asegurar la unicidad de cada cliente
    CONSTRAINT PK_clientes PRIMARY KEY (id_cliente)
);

-- 2. Tabla de Productos
CREATE TABLE productos (
    -- INT: Número entero para identificar de forma unívoca cada producto.
    id_producto INT NOT NULL,
    
    -- VARCHAR(255): Texto de longitud variable de hasta 255 caracteres, 
    -- ideal para descripciones detalladas del producto.
    descripcion VARCHAR(255) NOT NULL,
    
    -- DECIMAL(10, 2): Obligatorio para valores monetarios. Garantiza precisión exacta 
    -- (hasta 10 dígitos en total, con 2 decimales para los centavos), evitando 
    -- los problemas de redondeo típicos de los tipos de datos flotantes (FLOAT).
    precio DECIMAL(10, 2) NOT NULL,
    
    -- BIT (o TINYINT): Usamos un tipo de dato lógico/pequeño (0 o 1) 
    -- para representar un estado booleano (verdadero/falso) de si el producto está activo.
    esta_activo BIT NOT NULL,
    
    -- Definimos la clave primaria para la tabla de productos
    CONSTRAINT PK_productos PRIMARY KEY (id_producto)
);
