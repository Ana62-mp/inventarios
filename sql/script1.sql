


-- categorias

drop table if exists detalle_ventas;
drop table if exists cabecera_ventas;
drop table if exists detalle_pedido;
drop table if exists cabecera_pedido;
drop table if exists historial_stock;
drop table if exists productos;
drop table if exists unidades_medida;
drop table if exists categoria_unidad_medida;
drop table if exists proveedores;
drop table if exists tipo_documento;
drop table if exists estado_pedido;
drop table if exists categoria;

create table categoria (
    codigo_cat serial not null,
    nombre varchar(100) not null,
    categoria_padre int,
    constraint categoria_pk primary key (codigo_cat),
    constraint categoria_fk_padre foreign key (categoria_padre)
        references categoria(codigo_cat)
);

insert into categoria(nombre, categoria_padre) values ('Materia Prima', null);
insert into categoria(nombre, categoria_padre) values ('Proteina', 1);
insert into categoria(nombre, categoria_padre) values ('Salsas', 1);
insert into categoria(nombre, categoria_padre) values ('Punto de Venta', null);
insert into categoria(nombre, categoria_padre) values ('Bebidas', 4);
insert into categoria(nombre, categoria_padre) values ('Con alcohol', 5);
insert into categoria(nombre, categoria_padre) values ('Sin alcohol', 5);



-- categoria_unidad_medida

create table categoria_unidad_medida (
    codigo_udm char(1) not null,
    nombre varchar(100) not null,
    constraint categoria_unidad_medida_pk primary key (codigo_udm)
);

insert into categoria_unidad_medida(codigo_udm, nombre) values ('U', 'Unidades');
insert into categoria_unidad_medida(codigo_udm, nombre) values ('V', 'Volumen');
insert into categoria_unidad_medida(codigo_udm, nombre) values ('P', 'Peso');



-- unidades_medida

create table unidades_medida (
    codigo_udm varchar(5) not null,
    descripcion varchar(100) not null,
    categoria_udm char(1) not null,
    constraint unidades_medida_pk primary key (codigo_udm),
    constraint unidades_medida_fk_categoria foreign key (categoria_udm)
        references categoria_unidad_medida(codigo_udm)
);

insert into unidades_medida(codigo_udm, descripcion, categoria_udm) values ('ml', 'mililitros', 'V');
insert into unidades_medida(codigo_udm, descripcion, categoria_udm) values ('l',  'litros',     'V');
insert into unidades_medida(codigo_udm, descripcion, categoria_udm) values ('u',  'unidad',     'U');
insert into unidades_medida(codigo_udm, descripcion, categoria_udm) values ('d',  'docena',     'U');
insert into unidades_medida(codigo_udm, descripcion, categoria_udm) values ('g',  'gramos',     'P');
insert into unidades_medida(codigo_udm, descripcion, categoria_udm) values ('kg', 'kilogramos', 'P');
insert into unidades_medida(codigo_udm, descripcion, categoria_udm) values ('lb', 'libras',     'P');



-- productos

create table productos (
    codigo_prod serial not null,
    nombre varchar(100) not null,
    udm varchar(5) not null,
    precio_venta numeric(12,4) not null,
    iva_prod boolean not null,
    coste numeric(12,4) not null,
    categoria int not null,
    stock int not null,
    constraint productos_pk primary key (codigo_prod),
    constraint productos_fk_udm foreign key (udm)
        references unidades_medida(codigo_udm),
    constraint productos_fk_categoria foreign key (categoria)
        references categoria(codigo_cat)
);

insert into productos(nombre, udm, precio_venta, iva_prod, coste, categoria, stock)
values ('Coca cola pequeña', 'u', 0.5804, true, 0.3729, 7, 105);

insert into productos(nombre, udm, precio_venta, iva_prod, coste, categoria, stock)
values ('Salsa de tomate', 'kg', 0.95, true, 0.8736, 3, 0);

insert into productos(nombre, udm, precio_venta, iva_prod, coste, categoria, stock)
values ('Mostaza', 'kg', 0.95, true, 0.89, 3, 0);

insert into productos(nombre, udm, precio_venta, iva_prod, coste, categoria, stock)
values ('Fuze Tea', 'u', 0.8, true, 0.7, 7, 49);



-- tipo_documento

create table tipo_documento (
    codigo_doc char(1) not null,
    descripcion varchar(100) not null,
    constraint tipo_documento_pk primary key (codigo_doc)
);

insert into tipo_documento(codigo_doc, descripcion) values ('C', 'CEDULA');
insert into tipo_documento(codigo_doc, descripcion) values ('R', 'RUC');



-- proveedores

create table proveedores (
    identificador bigint not null,
    tipo_documento char(1) not null,
    nombre varchar(100) not null,
    telefono char(10) not null,
    correo varchar(30) not null,
    direccion varchar(100) not null,
    constraint proveedores_pk primary key (identificador),
    constraint proveedores_fk_tipo_documento foreign key (tipo_documento)
        references tipo_documento(codigo_doc)
);

insert into proveedores(identificador, tipo_documento, nombre, telefono, correo, direccion)
values (1792285747, 'C', 'SANTIAGO MOS', '0992920306', 'zantycb89@gmail.com', 'Cumbayork');

insert into proveedores(identificador, tipo_documento, nombre, telefono, correo, direccion)
values (1792285747001, 'R', 'SNACKS SA', '0992920398', 'snacks@gmail.com', 'La Tola');



-- estado_pedido

create table estado_pedido (
    codigo_estado char(1) not null,
    descripcion varchar(100) not null,
    constraint estado_pedido_pk primary key (codigo_estado)
);

insert into estado_pedido(codigo_estado, descripcion) values ('S', 'Solicitado');
insert into estado_pedido(codigo_estado, descripcion) values ('R', 'Recibido');



-- cabecera_pedido

create table cabecera_pedido (
    numero_pedido serial not null,
    proveedor_id bigint not null,
    fecha date not null,
    estado char(1) not null,
    constraint cabecera_pedido_pk primary key (numero_pedido),
    constraint cabecera_pedido_fk_proveedor foreign key (proveedor_id)
        references proveedores(identificador),
    constraint cabecera_pedido_fk_estado foreign key (estado)
        references estado_pedido(codigo_estado)
);

insert into cabecera_pedido(proveedor_id, fecha, estado)
values (1792285747, '2023-11-20', 'R');

insert into cabecera_pedido(proveedor_id, fecha, estado)
values (1792285747, '2023-11-20', 'R');



-- detalle_pedido

create table detalle_pedido (
    codigo_detallep serial not null,
    cabecera_pedido int not null,
    producto_cod int not null,
    cantidad_solicitada int not null,
    subtotal numeric(12,2) not null,
    cantidad_recibida int not null,
    constraint detalle_pedido_pk primary key (codigo_detallep),
    constraint detalle_pedido_fk_cabecera foreign key (cabecera_pedido)
        references cabecera_pedido(numero_pedido),
    constraint detalle_pedido_fk_producto foreign key (producto_cod)
        references productos(codigo_prod)
);

insert into detalle_pedido(cabecera_pedido, producto_cod, cantidad_solicitada, subtotal, cantidad_recibida)
values (1, 1, 100, 37.29, 100);

insert into detalle_pedido(cabecera_pedido, producto_cod, cantidad_solicitada, subtotal, cantidad_recibida)
values (1, 4, 50, 11.80, 50);

insert into detalle_pedido(cabecera_pedido, producto_cod, cantidad_solicitada, subtotal, cantidad_recibida)
values (2, 1, 10, 3.73, 10);



-- historial_stock

create table historial_stock (
    codigo_historial serial not null,
    fecha timestamp without time zone not null,
    referencia varchar(100) not null,
    producto int not null,
    cantidad int not null,
    constraint historial_stock_pk primary key (codigo_historial),
    constraint historial_stock_fk_producto foreign key (producto)
        references productos(codigo_prod)
);

insert into historial_stock(fecha, referencia, producto, cantidad)
values ('2023-11-20 19:59:00', 'PEDIDO 1', 1, 100);

insert into historial_stock(fecha, referencia, producto, cantidad)
values ('2023-11-20 19:59:00', 'PEDIDO 1', 4, 50);

insert into historial_stock(fecha, referencia, producto, cantidad)
values ('2023-11-20 20:00:00', 'PEDIDO 2', 1, 10);

insert into historial_stock(fecha, referencia, producto, cantidad)
values ('2023-11-20 20:00:00', 'VENTA 1', 1, -5);

insert into historial_stock(fecha, referencia, producto, cantidad)
values ('2023-11-20 20:00:00', 'VENTA 1', 4, 1);



-- cabecera_ventas

create table cabecera_ventas (
    codigo_venta serial not null,
    fecha timestamp without time zone not null,
    total_sin_iva numeric(12,2) not null,
    iva numeric(12,2) not null,
    total numeric(12,2) not null,
    constraint cabecera_ventas_pk primary key (codigo_venta)
);

insert into cabecera_ventas(fecha, total_sin_iva, iva, total)
values ('2023-11-20 20:00:00', 3.26, 0.39, 3.65);



-- detalle_ventas

create table detalle_ventas (
    codigo_detallev serial not null,
    cabecera_venta int not null,
    producto_cod int not null,
    cantidad int not null,
    precio_venta numeric(12,2) not null,
    subtotal numeric(12,2) not null,
    subtotal_con_iva numeric(12,2) not null,
    constraint detalle_ventas_pk primary key (codigo_detallev),
    constraint detalle_ventas_fk_cabecera foreign key (cabecera_venta)
        references cabecera_ventas(codigo_venta),
    constraint detalle_ventas_fk_producto foreign key (producto_cod)
        references productos(codigo_prod)
);

insert into detalle_ventas(cabecera_venta, producto_cod, cantidad, precio_venta, subtotal, subtotal_con_iva)
values (1, 1, 5, 0.58, 2.90, 3.25);

insert into detalle_ventas(cabecera_venta, producto_cod, cantidad, precio_venta, subtotal, subtotal_con_iva)
values (1, 4, 1, 0.36, 0.36, 0.40);


--////////////////////
--SELECTS

-- categorias
select * from categoria;

-- categoria_unidad_medida
select * from categoria_unidad_medida;

-- unidades_medida
select * from unidades_medida;

-- productos
select * from productos;

-- tipo_documento
select * from tipo_documento;

-- proveedores
select * from proveedores;

-- estado_pedido
select * from estado_pedido;

-- cabecera_pedido
select * from cabecera_pedido;

-- detalle_pedido
select * from detalle_pedido;

-- historial_stock
select * from historial_stock;

-- cabecera_ventas
select * from cabecera_ventas;

-- detalle_ventas
select * from detalle_ventas;
