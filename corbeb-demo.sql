# ************************************************************
# Sequel Ace SQL dump
# Version 20033
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: 127.0.0.1 (MySQL 8.0.28)
# Database: corbeb
# Generation Time: 2022-06-30 23:23:05 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table clientes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cuit` bigint NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clientes_cuit_unique` (`cuit`),
  KEY `clientes_user_id_foreign` (`user_id`),
  CONSTRAINT `clientes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;

INSERT INTO `clientes` (`id`, `name`, `cuit`, `user_id`, `created_at`, `updated_at`)
VALUES
	(1,'Parques Nacionales',30207750264,1,'2022-05-11 22:01:43','2022-05-11 22:01:43'),
	(2,'INVAP',30219541324,1,'2022-05-11 23:28:39','2022-05-11 23:28:39');

/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table datoscliente
# ------------------------------------------------------------

DROP TABLE IF EXISTS `datoscliente`;

CREATE TABLE `datoscliente` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cliente_id` bigint unsigned NOT NULL,
  `type_id` bigint unsigned NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `datoscliente_cliente_id_foreign` (`cliente_id`),
  CONSTRAINT `datoscliente_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table failed_jobs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `failed_jobs`;

CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `migration`, `batch`)
VALUES
	(1,'2014_10_12_000000_create_users_table',1),
	(2,'2014_10_12_100000_create_password_resets_table',1),
	(3,'2019_08_19_000000_create_failed_jobs_table',1),
	(4,'2019_12_14_000001_create_personal_access_tokens_table',1),
	(5,'2022_04_19_030806_create_clientes_table',1),
	(6,'2022_04_24_002136_create_datoscliente_table',1),
	(7,'2022_04_24_025719_create_sucursales_table',1),
	(8,'2022_05_10_203405_create_productos_table',1),
	(9,'2022_05_11_201432_create_repartos_table',1),
	(10,'2022_05_18_214728_create_talonarios_table',2),
	(11,'2022_05_18_215324_add_talonario_id_to_reparto_table',2),
	(12,'2022_06_27_190337_create_remitos_table',3),
	(13,'2022_06_27_191609_create_remito_items_table',3),
	(14,'2022_06_30_040129_add_fecha_remito_to_remitos_table',4);

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table password_resets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table personal_access_tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `personal_access_tokens`;

CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table productos
# ------------------------------------------------------------

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `imagen` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `precio` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;

INSERT INTO `productos` (`id`, `nombre`, `descripcion`, `imagen`, `precio`, `created_at`, `updated_at`)
VALUES
	(1,'Bidon x 20 litros',NULL,NULL,500,'2022-05-11 22:56:17','2022-05-11 23:07:51'),
	(2,'Bidon x 12 litros',NULL,NULL,400,'2022-05-11 22:58:13','2022-05-11 22:58:13');

/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table remito_items
# ------------------------------------------------------------

DROP TABLE IF EXISTS `remito_items`;

CREATE TABLE `remito_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `remito_id` bigint unsigned DEFAULT NULL,
  `producto_id` bigint unsigned DEFAULT NULL,
  `cant` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `remito_items_remito_id_foreign` (`remito_id`),
  KEY `remito_items_producto_id_foreign` (`producto_id`),
  CONSTRAINT `remito_items_producto_id_foreign` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `remito_items_remito_id_foreign` FOREIGN KEY (`remito_id`) REFERENCES `remitos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `remito_items` WRITE;
/*!40000 ALTER TABLE `remito_items` DISABLE KEYS */;

INSERT INTO `remito_items` (`id`, `remito_id`, `producto_id`, `cant`, `unit_price`, `created_at`, `updated_at`)
VALUES
	(1,2,1,10,600.00,'2022-06-29 21:15:10','2022-06-29 21:15:10'),
	(2,2,2,1,400.00,'2022-06-29 21:15:10','2022-06-29 21:15:10'),
	(3,3,1,10,500.00,'2022-06-30 03:26:17','2022-06-30 03:26:17'),
	(4,3,2,1,400.00,'2022-06-30 03:26:17','2022-06-30 03:26:17');

/*!40000 ALTER TABLE `remito_items` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table remitos
# ------------------------------------------------------------

DROP TABLE IF EXISTS `remitos`;

CREATE TABLE `remitos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `nro_talonario` int DEFAULT NULL,
  `nro_remito` int DEFAULT NULL,
  `cliente_id` bigint unsigned NOT NULL,
  `sucursales_id` bigint unsigned NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `fecha_remito` date DEFAULT '2022-06-30',
  PRIMARY KEY (`id`),
  KEY `remitos_user_id_foreign` (`user_id`),
  KEY `remitos_cliente_id_foreign` (`cliente_id`),
  KEY `remitos_sucursales_id_foreign` (`sucursales_id`),
  CONSTRAINT `remitos_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `remitos_sucursales_id_foreign` FOREIGN KEY (`sucursales_id`) REFERENCES `sucursales` (`id`),
  CONSTRAINT `remitos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `remitos` WRITE;
/*!40000 ALTER TABLE `remitos` DISABLE KEYS */;

INSERT INTO `remitos` (`id`, `user_id`, `nro_talonario`, `nro_remito`, `cliente_id`, `sucursales_id`, `notes`, `created_at`, `updated_at`, `fecha_remito`)
VALUES
	(2,1,2,1,1,2,NULL,'2022-06-29 21:15:10','2022-06-29 21:15:10','2022-06-30'),
	(3,1,2,2,1,1,NULL,'2022-06-30 03:26:17','2022-06-30 03:26:17','2022-06-30');

/*!40000 ALTER TABLE `remitos` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table repartos
# ------------------------------------------------------------

DROP TABLE IF EXISTS `repartos`;

CREATE TABLE `repartos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `talonarios_id` bigint unsigned DEFAULT NULL,
  `fecha` date NOT NULL DEFAULT '2022-05-12',
  `concepto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `productos_id` bigint unsigned NOT NULL,
  `sucursales_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `remito` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `repartos_productos_id_foreign` (`productos_id`),
  KEY `repartos_sucursales_id_foreign` (`sucursales_id`),
  KEY `repartos_user_id_foreign` (`user_id`),
  CONSTRAINT `repartos_productos_id_foreign` FOREIGN KEY (`productos_id`) REFERENCES `productos` (`id`),
  CONSTRAINT `repartos_sucursales_id_foreign` FOREIGN KEY (`sucursales_id`) REFERENCES `sucursales` (`id`),
  CONSTRAINT `repartos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `repartos` WRITE;
/*!40000 ALTER TABLE `repartos` DISABLE KEYS */;

INSERT INTO `repartos` (`id`, `talonarios_id`, `fecha`, `concepto`, `cantidad`, `productos_id`, `sucursales_id`, `user_id`, `remito`, `created_at`, `updated_at`)
VALUES
	(1,NULL,'2022-05-11',NULL,2,1,1,3,'20',NULL,'2022-05-18 20:50:04'),
	(2,NULL,'2022-05-13',NULL,3,2,3,1,NULL,'2022-05-13 01:48:28','2022-05-14 02:29:42'),
	(3,NULL,'2022-05-13',NULL,4,2,3,1,NULL,'2022-05-13 01:50:13','2022-05-14 21:52:17'),
	(4,NULL,'2022-05-13',NULL,16,1,2,2,NULL,'2022-05-13 01:50:33','2022-05-13 23:45:41'),
	(5,NULL,'2022-05-19',NULL,3,1,3,1,'1000','2022-05-18 20:45:40','2022-05-18 20:45:40'),
	(6,NULL,'2022-05-19',NULL,15,1,1,2,'1001','2022-05-18 20:46:02','2022-05-18 20:46:09');

/*!40000 ALTER TABLE `repartos` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sucursales
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sucursales`;

CREATE TABLE `sucursales` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `direccion` text COLLATE utf8mb4_unicode_ci,
  `dia_reparto` json DEFAULT NULL,
  `orden_entrega` int DEFAULT NULL,
  `cliente_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sucursales_cliente_id_foreign` (`cliente_id`),
  KEY `sucursales_user_id_foreign` (`user_id`),
  KEY `sucursales_orden_entrega_index` (`orden_entrega`),
  CONSTRAINT `sucursales_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `sucursales_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `sucursales` WRITE;
/*!40000 ALTER TABLE `sucursales` DISABLE KEYS */;

INSERT INTO `sucursales` (`id`, `direccion`, `dia_reparto`, `orden_entrega`, `cliente_id`, `user_id`, `created_at`, `updated_at`)
VALUES
	(1,'Museo','[\"martes\"]',NULL,1,2,'2022-05-11 22:02:53','2022-05-11 22:04:14'),
	(2,'Moreno 50','[\"miercoles\"]',NULL,1,3,'2022-05-11 22:37:09','2022-05-11 22:37:09'),
	(3,'Ruta 254','[\"lunes\"]',NULL,2,2,'2022-05-11 23:29:07','2022-05-11 23:29:07');

/*!40000 ALTER TABLE `sucursales` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table talonarios
# ------------------------------------------------------------

DROP TABLE IF EXISTS `talonarios`;

CREATE TABLE `talonarios` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `talonario` int NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `talonarios_user_id_foreign` (`user_id`),
  CONSTRAINT `talonarios_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `talonarios` WRITE;
/*!40000 ALTER TABLE `talonarios` DISABLE KEYS */;

INSERT INTO `talonarios` (`id`, `talonario`, `user_id`, `created_at`, `updated_at`)
VALUES
	(1,9,1,'2022-06-29 19:09:50','2022-06-29 19:09:50'),
	(2,10,2,'2022-06-29 19:10:07','2022-06-29 19:10:07');

/*!40000 ALTER TABLE `talonarios` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`)
VALUES
	(1,'bicho44','bicho44@ateste.ar',NULL,'$2y$10$0J3HNmGoS9kfwirajeUsL.EBF2uSlrMeh8wz9tTSqv6/4yPUTARPq','VqS5RmOZet8pspUzDIPdhEjhM8EqAwwXeaHSAUavfoVssVlFAPbaeMtgYDrq','2022-05-11 22:00:28','2022-05-11 22:00:28'),
	(2,'Josue','josue@corbeb.com',NULL,'12345678',NULL,'2022-05-11 22:03:27','2022-05-11 22:03:27'),
	(3,'Ezequiel','ezequiel@corbeb.com',NULL,'12345678',NULL,'2022-05-11 22:03:59','2022-05-11 22:03:59');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
