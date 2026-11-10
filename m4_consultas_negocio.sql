-- Pre-entrega: Consultas SQL de negocio
-- Empresa: RetailPro
-- Archivo: m4_consultas_negocio.sql

-- Consulta 1 — Resumen ejecutivo mensual
-- Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes.

SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta);

-- Consulta 2 — Ranking de productos
-- Top 5 de id_producto por total facturado, mostrando unidades vendidas y total generado.

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado;

-- Consulta 3 — Clientes recurrentes
-- Clientes que hayan realizado más de un pedido, mostrando pedidos y total gastado.

SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;


-- Consulta 4 — Productos por encima/por debajo del promedio
-- Compara la facturación de cada producto frente al promedio general por producto.

WITH FacturacionProductos AS (
    SELECT 
        id_producto,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY id_producto
)
SELECT 
    id_producto,
    total_facturado,
    CASE 
        WHEN total_facturado >= (SELECT AVG(total_facturado) FROM FacturacionProductos) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS clasificacion_promedio
FROM FacturacionProductos;



-- BLOQUE DE CIERRE: Hallazgos clave

-- 1. El producto más vendido concentra la mayor parte de la facturación del período.
-- 2. Hay clientes que compran más de una vez, lo que ayuda a aumentar el valor total de las compras.
-- 3. La mayoría de los productos se ubican por debajo del promedio de ventas general de la tienda.