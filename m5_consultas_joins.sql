-- Entregable: m5_consultas_joins.sql
-- Base de datos: Ventas_Tech_DB
-- Motor utilizado: SQL Server

USE Ventas_Tech_DB;
GO

-- ============================================================================
-- Consulta 1: Vista base del proyecto (INNER JOIN)
-- ============================================================================
SELECT 
    v.id_venta,
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad AS region_ciudad,
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas AS v
INNER JOIN clientes AS c ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p ON v.id_producto = p.id_producto
INNER JOIN categorias AS cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta ASC, v.id_venta ASC;
-- Hallazgo: Se encuentran las 10 transacciones registradas por un total de $6.444, donde la categoría Computación lidera ampliamente la facturación gracias 
-- a las ventas de Laptop Pro 15 y Monitor 4K 27 en ciudades como Buenos Aires y Tucumán.


-- ============================================================================
-- Consulta 2: Clientes sin ventas (LEFT JOIN)
-- ============================================================================
SELECT 
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;
-- Hallazgo: Aparecieron 0 clientes sin compras; los 5 registrados ya compraron al menos una vez, por lo que CRM debe enfocarse en fidelizarlos y lograr que 
-- vuelvan a comprar en vez de buscar su primera compra.

-- ============================================================================
-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- ============================================================================
SELECT 
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM productos AS p
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas AS v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;
-- Hallazgo: Aparecieron 0 productos sin ventas (los 6 artículos del catálogo ya fueron vendidos); para el área de Producto esto indica que todo el stock inicial
-- tiene rotación y no hay artículos estancados.

-- ============================================================================
-- Consulta 4: Consolidado por canal (UNION ALL)
-- ============================================================================
SELECT 
    canal, 
    COUNT(id_venta) AS cantidad_operaciones,
    SUM(total) AS total_canal
FROM (
    SELECT 
        v.id_venta,
        v.fecha_venta, 
        (v.cantidad * v.precio_unitario) AS total, 
        'Sucursal CABA / AMBA' AS canal
    FROM ventas AS v
    INNER JOIN clientes AS c ON v.id_cliente = c.id_cliente
    WHERE c.ciudad = 'Buenos Aires'
    
    UNION ALL
    
    SELECT 
        v.id_venta,
        v.fecha_venta, 
        (v.cantidad * v.precio_unitario) AS total, 
        'Canal Online Interior' AS canal
    FROM ventas AS v
    INNER JOIN clientes AS c ON v.id_cliente = c.id_cliente
    WHERE c.ciudad <> 'Buenos Aires'
) AS consolidado
GROUP BY canal
ORDER BY total_canal DESC;
-- Hallazgo: El Canal Online Interior concentró 8 operaciones por $3.804 y la Sucursal CABA/AMBA 2 operaciones por $2.640; esto demuestra que la mayor parte 
-- de las ventas provienen del interior del país, aunque Buenos Aires mantiene un ticket promedio por venta más alto.
