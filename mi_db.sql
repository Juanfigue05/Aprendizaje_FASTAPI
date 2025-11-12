DROP DATABASE IF EXISTS mi_proyecto_f;
CREATE DATABASE mi_proyecto_f CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE mi_proyecto_f;

CREATE TABLE rol(
    id_rol SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(20)
);

CREATE TABLE usuario(
    id_usuario INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(80),
    num_documento CHAR(12),
    correo VARCHAR(100) UNIQUE,
    contra_encript VARCHAR(140),
    id_rol SMALLINT UNSIGNED,
    estado BOOLEAN,  -- True = 1 Activo   False = 0 Inactivo
    FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);


CREATE TABLE IF NOT EXISTS `users` (
	`id_user` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
	`nombre_completo` VARCHAR(70),
	`correo` VARCHAR(90),
	`pass_hash` VARCHAR(150),
	`rol` VARCHAR(20),
	PRIMARY KEY(`id_user`)
);


CREATE TABLE IF NOT EXISTS `roles` (
	`nombre` VARCHAR(20) NOT NULL UNIQUE,
	`descripcion` VARCHAR(100),
	PRIMARY KEY(`nombre`)
);


CREATE TABLE IF NOT EXISTS `modulos` (
	`id_modulo` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
	`nombre` VARCHAR(20),
	PRIMARY KEY(`id_modulo`)
);


CREATE TABLE IF NOT EXISTS `permisos` (
	`id_permiso` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
	`rol` VARCHAR(20),
	`modulo` INTEGER UNSIGNED,
	`insertar` BOOLEAN,
	`actualizar` BOOLEAN,
	`seleccionar` BOOLEAN,
	`borrar` BOOLEAN,
	PRIMARY KEY(`id_permiso`)
);


CREATE TABLE IF NOT EXISTS `centros_formacion` (
	`cod_centro` SMALLINT UNSIGNED NOT NULL UNIQUE,
	`nombre_centro` VARCHAR(160),
	`cod_regional` TINYINT UNSIGNED,
	`nombre_regional` VARCHAR(50),
	PRIMARY KEY(`cod_centro`)
);


CREATE TABLE IF NOT EXISTS `programas_formacion` (
	`cod_programa` INT UNSIGNED NOT NULL UNIQUE,
	`version` CHAR(4),
	`nombre` VARCHAR(160),
	`nivel` VARCHAR(50),
	`id_red` INTEGER UNSIGNED,
	`tiempo_duracion` SMALLINT UNSIGNED,
	`unidad_medida` VARCHAR(20),
	`estado` BOOLEAN,
	`url_pdf` VARCHAR(180),
	PRIMARY KEY(`cod_programa`)
);


CREATE TABLE IF NOT EXISTS `redes_conocimiento` (
	`id_red` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
	`nombre` VARCHAR(180),
	PRIMARY KEY(`id_red`)
);


CREATE TABLE IF NOT EXISTS `grupos` (
	`ficha` INTEGER UNSIGNED NOT NULL UNIQUE,
	`cod_programa` MEDIUMINT UNSIGNED,
	`cod_centro` SMALLINT UNSIGNED,
	`modalidad` VARCHAR(50),
	`jornada` VARCHAR(30),
	`etapa_ficha` VARCHAR(30),
	`estado_curso` VARCHAR(30),
	`fecha_inicio` DATE,
	`fecha_fin` DATE,
	`cod_municipio` CHAR(5),
	`cod_estrategia` CHAR(5),
	`nombre_responsable` VARCHAR(80),
	`cupo_asignado` SMALLINT UNSIGNED,
	`num_aprendices_fem` SMALLINT UNSIGNED,
	`num_aprendices_mas` SMALLINT UNSIGNED,
	`num_aprendices_nobin` SMALLINT UNSIGNED,
	`num_aprendices_matriculados` SMALLINT UNSIGNED,
	`num_aprendices_activos` SMALLINT UNSIGNED,
	`tipo_doc_empresa` CHAR(3),
	`num_doc_empresa` VARCHAR(20),
	`nombre_empresa` VARCHAR(80),
	PRIMARY KEY(`ficha`)
);


CREATE TABLE IF NOT EXISTS `municipios` (
	`cod_municipio` CHAR(5) NOT NULL UNIQUE,
	`nombre` VARCHAR(30),
	PRIMARY KEY(`cod_municipio`)
);


CREATE TABLE IF NOT EXISTS `estrategia` (
	`cod_estrategia` CHAR(5) NOT NULL UNIQUE,
	`nombre` VARCHAR(80),
	PRIMARY KEY(`cod_estrategia`)
);


ALTER TABLE `roles`
ADD FOREIGN KEY(`nombre`) REFERENCES `users`(`rol`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `roles`
ADD FOREIGN KEY(`nombre`) REFERENCES `permisos`(`rol`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `modulos`
ADD FOREIGN KEY(`id_modulo`) REFERENCES `permisos`(`modulo`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `redes_conocimiento`
ADD FOREIGN KEY(`id_red`) REFERENCES `programas_formacion`(`id_red`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `programas_formacion`
ADD FOREIGN KEY(`cod_programa`) REFERENCES `grupos`(`cod_programa`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `centros_formacion`
ADD FOREIGN KEY(`cod_centro`) REFERENCES `grupos`(`cod_centro`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `municipios`
ADD FOREIGN KEY(`cod_municipio`) REFERENCES `grupos`(`cod_municipio`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `estrategia`
ADD FOREIGN KEY(`cod_estrategia`) REFERENCES `grupos`(`cod_estrategia`)
ON UPDATE NO ACTION ON DELETE NO ACTION;