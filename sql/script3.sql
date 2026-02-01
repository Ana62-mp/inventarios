
select prov.identificador,prov.tipo_documento, td.descripcion ,prov.nombre, prov.telefono, prov.correo, prov.direccion
from proveedores prov, tipo_documento td 
where prov.tipo_documento = td.codigo_doc 
and upper(nombre) like '%SA%'

select codigo_doc, descripcion from tipo_documento where upper(descripcion) like '%CE%'

select prod.codigo_prod, prod.nombre as nombre_producto, udm.codigo_udm, prod.precio_ve  from productos prod, unidades_medida udm, categoria cat
where prod.udm = udm.codigo_udm
and prod.categoria = cat.codigo_cat

select * from productos prod, unidades_medida udm, categoria cat
where prod.udm = udm.codigo_udm
and prod.categoria = cat.codigo_cat


--////////////

UPDATE cabecera_pedido
SET estado = 'S'
WHERE numero_pedido = 7;

UPDATE detalle_pedido
SET cantidad_recibida = 40, subtotal = 20
WHERE codigo_detallep = 5;



