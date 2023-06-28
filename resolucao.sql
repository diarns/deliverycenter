/*1- Qual o número de hubs por cidade?*/
SELECT COUNT(hub_city), hub_city as CITYS
FROM hubs
GROUP BY hub_city
ORDER BY (hub_city) DESC;

/*2- Qual o número de pedidos (orders) por status?*/
SELECT order_status, COUNT(order_status) AS RESULT
GROUP BY order_status;

/*3- Qual o número de lojas (stores) por cidade dos hubs?*/
SELECT COUNT(store_id), h.hub_city FROM stores AS s 
INNER JOIN hubs AS h ON s.hub_id = h.hub_Id
GROUP BY hub_city
ORDER BY (hub_city) DESC;

/*4- Qual o maior e o menor valor de pagamento (payment_amount) registrado?*/
select MIN(payment_amount) as menor_valor, MAX(payment_amount) as maior_valor
from payments;

/*5- Qual tipo de driver (driver_type) fez o maior número de entregas?*/
SELECT MAX(drivers.driver_type) AS ENTREGAS
FROM drivers
INNER JOIN deliveries 
ON drivers.driver_id = deliveries.driver_id;

/*6- Qual a distância média das entregas por tipo de driver (driver_modal)?*/
SELECT driver_modal, AVG(delivery_distance_meters)  as media_distancia_metros
FROM drivers AS dr 
INNER JOIN deliveries AS de 
ON dr.driver_id = de.driver_id 
GROUP BY driver_modal 
LIMIT 10;

/*7- Qual a média de valor de pedido (order_amount) por loja, em ordem decrescente?*/
select store_name, ROUND(AVG(order_amount),2) as media_de_valor
from orders
join stores
where orders.store_id = stores.store_id
group by orders.store_id
order by order_amount DESC;

/*8- Existem pedidos que não estão associados a lojas? Se caso positivo, quantos?*/
SELECT COUNT(*) AS quantidade_pedidos_sem_lojas
FROM orders
WHERE store_id IS NULL;

/*9- Qual o valor total de pedido (order_amount) no channel 'FOOD PLACE'?*/
SELECT SUM(o.order_amount) AS total_pedido
FROM orders AS o
INNER JOIN channels AS c ON o.channel_id = c.channel_id
WHERE c.channel_name = 'FOOD PLACE';

/*10- Quantos pagamentos foram cancelados (chargeback)?*/
SELECT COUNT(*) AS pagamentos_cancelados
FROM payments
WHERE payment_status = 'chargeback';

/*11- Qual foi o valor médio dos pagamentos cancelados (chargeback)?*/
SELECT ROUND(AVG(payment_amount),2) AS media_pagamentos_cancelados
FROM payments
WHERE payment_status = 'chargeback';

/*12- Qual a média do valor de pagamento por método de pagamento (payment_method) em ordem decrescente?*/
SELECT payment_method as metodoPagamento, ROUND(AVG(payment_amount),1) as ValorMedio
FROM payments
GROUP BY payment_method
ORDER BY payment_method DESC;

SELECT payment_method, AVG(payment_amount) AS media_pagamento_metodo
FROM payments
GROUP BY payment_method
ORDER BY media_pagamento_metodo DESC;

/*13- Quais métodos de pagamento tiveram valor médio superior a 100?*/
SELECT payment_method
FROM payments
GROUP BY payment_method
HAVING AVG(payment_amount) > 100;

/*14- Qual a média de valor de pedido (order_amount) por estado do hub
(hub_state), segmento da loja (store_segment) e tipo de canal (channel_type)?*/
SELECT h.hub_state, s.store_segment, c.channel_type, round((o.order_amount),1) AS media_valor_pedido
FROM hubs h
JOIN stores s ON h.hub_id = s.hub_id
JOIN orders o ON s.store_id = o.store_id
JOIN channels c ON o.channel_id = c.channel_id
GROUP BY h.hub_state, s.store_segment, c.channel_type;

/*15- Qual estado do hub (hub_state), segmento da loja (store_segment) e tipo
de canal (channel_type) teve média de valor de pedido (order_amount) maior que
450?*/
SELECT h.hub_state, s.store_segment, c.channel_type, round((o.order_amount),1) AS media_valor_pedido
FROM hubs h
JOIN stores s ON h.hub_id = s.hub_id
JOIN orders o ON s.store_id = o.store_id
JOIN channels c ON o.channel_id = c.channel_id
GROUP BY h.hub_state, s.store_segment, c.channel_type
HAVING AVG(o.order_amount) > 450;
