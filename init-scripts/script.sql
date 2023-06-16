CREATE SCHEMA "comercios" AUTHORIZATION fedisal;
GRANT ALL ON SCHEMA "comercios" TO fedisal;


CREATE SEQUENCE comercios.catalogos_id_catalogo_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE comercios.comercios_id_comercio_seq;

CREATE SEQUENCE comercios.comercios_id_comercio_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE comercios.usuarios_id_usuario_seq;

CREATE SEQUENCE comercios.usuarios_id_usuario_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE comercios.ventas_detalle_id_venta_detalle_seq;

CREATE SEQUENCE comercios.ventas_detalle_id_venta_detalle_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE comercios.ventas_estado_id_venta_estado_seq;

CREATE SEQUENCE comercios.ventas_estado_id_venta_estado_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE comercios.ventas_id_venta_seq;

CREATE SEQUENCE comercios.ventas_id_venta_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- comercios.comercios definition

-- Drop table

-- DROP TABLE comercios.comercios;

CREATE TABLE comercios.comercios (
	id_comercio serial4 NOT NULL,
	nombre varchar NOT NULL,
	descripcion varchar NULL,
	logo varchar NULL,
	activo int4 NULL DEFAULT 1,
	created date NULL,
	CONSTRAINT comercios_pkey PRIMARY KEY (id_comercio)
);


-- comercios.ventas_estado definition

-- Drop table

-- DROP TABLE comercios.ventas_estado;

CREATE TABLE comercios.ventas_estado (
	id_venta_estado serial4 NOT NULL,
	nombre varchar NULL,
	CONSTRAINT ventas_estado_pkey PRIMARY KEY (id_venta_estado)
);


-- comercios.catalogos definition

-- Drop table

-- DROP TABLE comercios.catalogos;

CREATE TABLE comercios.catalogos (
	id_catalogo serial4 NOT NULL,
	nombre varchar NULL,
	descripcion varchar NULL,
	precio numeric NULL,
	imagen varchar NULL,
	id_comercio int4 NULL,
	activo int4 NULL DEFAULT 1,
	created date NULL,
	CONSTRAINT catalogos_pkey PRIMARY KEY (id_catalogo),
	CONSTRAINT catalogos_id_comercio_fkey FOREIGN KEY (id_comercio) REFERENCES comercios.comercios(id_comercio) ON DELETE CASCADE
);


-- comercios.usuarios definition

-- Drop table

-- DROP TABLE comercios.usuarios;

CREATE TABLE comercios.usuarios (
	id_usuario serial4 NOT NULL,
	correo varchar NOT NULL,
	nombres varchar NULL,
	apellidos varchar NULL,
	contacto varchar NULL,
	direccion varchar NULL,
	"password" varchar NULL,
	activo int4 NULL DEFAULT 1,
	rol varchar NULL,
	created date NULL,
	id_comercio int4 NULL,
	CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario),
	CONSTRAINT usuarios_id_comercio_fkey FOREIGN KEY (id_comercio) REFERENCES comercios.comercios(id_comercio)
);


-- comercios.ventas definition

-- Drop table

-- DROP TABLE comercios.ventas;

CREATE TABLE comercios.ventas (
	id_venta serial4 NOT NULL,
	id_usuario int4 NULL,
	fecha_anula date NULL,
	fecha_pago date NULL,
	observaciones varchar NULL,
	created date NULL,
	id_comercio int4 NULL,
	id_venta_estado int4 NULL,
	CONSTRAINT ventas_pkey PRIMARY KEY (id_venta),
	CONSTRAINT ventas_id_comercio_fkey FOREIGN KEY (id_comercio) REFERENCES comercios.comercios(id_comercio) ON DELETE CASCADE,
	CONSTRAINT ventas_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES comercios.usuarios(id_usuario) ON DELETE CASCADE,
	CONSTRAINT ventas_id_venta_estado_fkey FOREIGN KEY (id_venta_estado) REFERENCES comercios.ventas_estado(id_venta_estado)
);


-- comercios.ventas_detalle definition

-- Drop table

-- DROP TABLE comercios.ventas_detalle;

CREATE TABLE comercios.ventas_detalle (
	id_venta_detalle serial4 NOT NULL,
	id_venta int4 NULL,
	id_catalogo int4 NULL,
	cantidad int4 NULL,
	total numeric NULL,
	created date NULL,
	precio numeric NULL,
	CONSTRAINT ventas_detalle_pkey PRIMARY KEY (id_venta_detalle),
	CONSTRAINT ventas_detalle_id_catalogo_fkey FOREIGN KEY (id_catalogo) REFERENCES comercios.catalogos(id_catalogo) ON DELETE CASCADE,
	CONSTRAINT ventas_detalle_id_venta_fkey FOREIGN KEY (id_venta) REFERENCES comercios.ventas(id_venta) ON DELETE CASCADE
);


-- Funcion para encriptar a usuarios
CREATE OR REPLACE FUNCTION encriptar_md5()
    RETURNS trigger AS
$BODY$
BEGIN
    NEW."password" := md5(NEW."password");
    RETURN NEW;
END;
$BODY$
    LANGUAGE plpgsql;

create or replace TRIGGER trigger_encriptar_md5
    BEFORE INSERT ON "comercios".usuarios
    FOR EACH ROW
EXECUTE FUNCTION encriptar_md5();


-- INSERT DE COMERCIOS 

INSERT INTO comercios.comercios (nombre, descripcion, logo, activo, created) VALUES ('Beauty Always', 'Salon de belleza especializado en tintes de cabello', 'https://raw.githubusercontent.com/bm20019/imgs/main/Logos/02.png', 1, CURRENT_DATE);
INSERT INTO comercios.comercios (nombre, descripcion, logo, activo, created) VALUES ('Pet Shop Patitas Saludables', 'Empresa #1 en cuidado de mascotas en El Salvador', 'https://raw.githubusercontent.com/bm20019/imgs/main/Logos/01.png', 1, CURRENT_DATE);

-- INSERT DE CATALOGOS BELLEZA

INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Masajeador facial', 'Rodillo suave para extender el maquillaje', 4.99, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/01.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Mezclador de maquillaje', 'Esponjas para mezclar maquillaje', 2.49, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/02.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Brillo de labios', 'Aplicador de brillo de labios', 6.49, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/03.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Labial Honest', 'Aplicador de labial marca Honest', 8.99, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/04.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Parche removedor de ojeras', 'Apliquese en la zona afectada por ojeras y vea la magia', 15.99, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/05.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Espejo', 'Producto esencial para la aplicación de productos', 3.49, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/06.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Loción bronceadora', 'Apliquese para lograr un efecto de bronceado en la piel', 13.99, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/07.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Crema elimina estrías', 'Apliquese 3 veces por semana para disminuir las estrías en la piel', 11.49, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/08.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Crema de hidratación extrema Ultra Repair', 'Para casos especiales de deshidratación en la piel', 28.00, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/09.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Mascarilla facial Hydra Moist', 'Minimiza los poros mientras duerme', 17.89, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/10.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Mascara para pestañas Lash Princess', 'Agrega un efecto de mascara a tus pestañas', 14.35, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/11.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Mascara facial Breylee', 'Para uso preventivo o para reparación y rehidratración', 13.29, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/12.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Cepillo aplicador de shampoo', 'Cepillo aplicador de shampoo', 9.49, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/13.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Alisador de cabello sin calor', 'Practico y facil de usar', 18.25, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/14.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Juego de brochas para maquillaje', 'Equipate para toda situación', 26.99, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/15.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Labial Monocromatico', 'Logra un efecto monocromatico con este labial', 11.99, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/16.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Desodorante con olor a limon', 'Desodorante con olor a limon', 18.24, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/17.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Humedecedor facial', 'Producto especializador para humedecer la piel facial', 17.29, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/18.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Suero epidermico', 'Para los casos más extremos de exfoliación', 43.89, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/19.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Labial color chocolate pasión', 'Labial color chocolate pasión', 16.24, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/20.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Kit blanqueador de dentadura', 'Ponga la crema en el aplicador dental y vea resultados en los primeros 3 días', 34.99, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/21.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Lapiz multiuso', 'Lapiz multiuso para maquillaje', 9.24, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/22.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Jabon especial para la piel', 'Jabon especial para la piel', 6.99, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/23.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Crema anti acne Tula', 'Para remover el acne', 16.94, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/24.jpg', 1, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Crema hidratadora Kraverbeauty', 'Crema para hidratar la piel', 8.99, 'https://raw.githubusercontent.com/bm20019/imgs/main/Belleza/25.jpg', 1, 1, CURRENT_DATE);

-- INSERT DE CATALOGOS MASCOTAS

INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Spray Anti pulgas', 'Use este spray para eliminar las pulgas de su mascota', 19.99, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/01.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Probioticos Wuffes', 'Mejore la digestión de su amigo canino con este medicamento', 26.75, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/02.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Collares con diseño personalizados', 'Proporcionenos el nombre de su mascota y le haremos un collar a la medida', 4.25, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/03.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Collar de cadena para perro', 'Utiliza esta cadena para distinguir a tu mascota cuando paseen', 7.00, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/04.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Aspiradora para pelaje animal', 'Equipada con una boquilla especial hara que no te preocupes de los cabellos que dejan tus mascotas', 38.99, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/05.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Cama para perro color gris', 'Con cerdas especiales para maxima comodidad', 14.49, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/06.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Cama para gato color piel', 'Consiente a tu gato especial con esta cama', 12.49, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/07.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Aspiradora para casa', 'Equipada con una boquilla especial hara que no te preocupes de los cabellos que dejan tus mascotas', 29.99, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/08.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Removedor de pelo para mascotas', 'Frotalo sobre tu mascota para remover cabellos que no ha sacudido por si mismo', 18.75, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/09.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Plato para comida', 'Instalalo en tu pared de preferencia para que tus mascotas coman', 8.99, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/10.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Collar con forma de perro', 'Utiliza esta cadena para distinguir a tu mascota cuando paseen', 3.49, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/11.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Jaula transparente para mascotas pequeñas', 'Para transportación rápida y efectiva para viajes largos', 17.99, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/12.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Chaleco para transporte de mascotas', 'Para transportación rápida y efectiva para viajes largos', 11.25, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/13.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Bata de baño para perro', 'Para agilizar el proceso de secado para tu mascota', 16.49, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/14.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Cobija para mascotas', 'Para consentir a tu mascota y ayudarlos con el frío de la noche', 6.99, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/15.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Cera para depilar', 'Con ingredientes naturales para no arruinar la piel de tu mascota', 8.99, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/16.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Accesorio de collar para perro', 'Para mejorar la imagen de tu mascota y su collar', 4.59, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/17.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Vitaminas para mascotas', 'Para mejorar la salud de tu compañero', 1.00, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/02.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Gotas con feromonas para mascotas', 'Ayuda a reducir el estres de tus mascotas', 18.49, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/19.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Formula de Aloe Vera para mascotas', 'Para minimizar los problemas de bacterias con tus mascotas', 7.49, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/20.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Tarjetas memoriales para mascotas', 'Tarjetas personalizadas para que recuerdes a tu mascota', 2.49, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/21.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Dispensador de comida bluetooth', 'Utiliza este dispensador para poner fecha y hora a la hora de comer de tu mascota', 49.25, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/22.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Kit de barbería para mascotas', 'Kit completo para manejar a cualquier tipo de mascota', 34.49, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/23.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Bolsas y recogedor de desperdicios', 'Para no preocuparte por accidentes al pasear tu mascota', 16.50, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/24.jpg', 2, 1, CURRENT_DATE);
INSERT INTO comercios.catalogos (nombre, descripcion, precio, imagen, id_comercio, activo, created) VALUES ('Camilla de hilos para mascota', 'Completamente comoda para tus mascotas', 19.49, 'https://raw.githubusercontent.com/bm20019/imgs/main/Mascotas/25.jpg', 2, 1, CURRENT_DATE);
