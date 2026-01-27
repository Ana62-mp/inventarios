

select prov.identificador,prov.tipo_documento, td.descripcion ,prov.nombre, prov.telefono, prov.correo, prov.direccion
from proveedores prov, tipo_documento td 
where prov.tipo_documento = td.codigo_doc 
and upper(nombre) like '%SA%'

select codigo_doc, descripcion from tipo_documento where upper(descripcion) like '%CE%'

select prod.codigo_prod, prod.nombre as nombre_producto, udm.codigo_udm, 
udm.descripcion, prod.precio_venta, prod.iva_prod, prod.coste,
prod.categoria, cat.nombre as nombre_categoria, stock
from productos prod, unidades_medida udm, categoria cat
where prod.udm = udm.codigo_udm
and prod.categoria = cat.codigo_cat
and upper(prod.nombre) like '%M%'

select * from productos prod, unidades_medida udm, categoria cat
where prod.udm = udm.codigo_udm
and prod.categoria = cat.codigo_cat