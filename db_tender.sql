/*
CREATE DATABASE db_name CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL PRIVILEGES ON db_name.* TO 'username'@'XX.XX.XX.XX or localhost';
FLUSH PRIVILEGES;
*/

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema test
-- -----------------------------------------------------
-- test болып аталу себебі менің өз еркіммен жасап отырған бірінші базам болғандықтан

-- -----------------------------------------------------
-- Schema test
--
-- test болып аталу себебі менің өз еркіммен жасап отырған бірінші базам болғандықтан
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `test` DEFAULT CHARACTER SET utf8 ;
USE `test` ;

-- -----------------------------------------------------
-- Table `test`.`companies`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`companies` ;

CREATE TABLE IF NOT EXISTS `test`.`companies` (
  `company_name` VARCHAR(100) NOT NULL COMMENT 'Мекеменің атауы',
  `bin` VARCHAR(15) NOT NULL COMMENT 'ИИН/БИН',
  `address` TINYTEXT NULL,
  `bank_details` TEXT NULL COMMENT 'Банктік реквизиті',
  `telephone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `position` VARCHAR(30) NOT NULL COMMENT 'Басшының лауазымы',
  `director` VARCHAR(45) NOT NULL COMMENT 'Басшының аты-жөні',
  `company_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`company_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Мекемелердің тізімі';


-- -----------------------------------------------------
-- Table `test`.`documents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`documents` ;

CREATE TABLE IF NOT EXISTS `test`.`documents` (
  `document_folder` VARCHAR(45) NOT NULL COMMENT 'Құжаттар топтамасының атауы\n(папканың аты)',
  `description` VARCHAR(255) NOT NULL COMMENT 'Сол топтаманың сипаттамасы \n(қандай құжаттар екені)',
  `company_id` INT NOT NULL COMMENT 'Топтаманың иесі',
  `document_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`document_id`, `company_id`),
  INDEX `fk_documents_1_idx` (`company_id` ASC),
  CONSTRAINT `fk_documents_1`
    FOREIGN KEY (`company_id`)
    REFERENCES `test`.`companies` (`company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Құжаттардың топтамасы';


-- -----------------------------------------------------
-- Table `test`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`users` ;

CREATE TABLE IF NOT EXISTS `test`.`users` (
  `username` VARCHAR(15) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `blocked` TINYINT(1) NULL DEFAULT 0,
  `user_id` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Мәліметтер қорының пайдаланушылары';


-- -----------------------------------------------------
-- Table `test`.`doc_attaches`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`doc_attaches` ;

CREATE TABLE IF NOT EXISTS `test`.`doc_attaches` (
  `document_name` TINYTEXT NOT NULL COMMENT 'Құжаттың толық атауы',
  `language` VARCHAR(30) NOT NULL COMMENT 'Қай тілде жазылғандығы жайлы',
  `create_date` DATE NOT NULL COMMENT 'Құжаттың берілген/жазылған күні',
  `validate_date` DATE NOT NULL DEFAULT '0000-00-00' COMMENT 'Жарамдылық мерзімі',
  `description` TEXT NOT NULL COMMENT 'Жалпы осы құжаттың тарихы (барынша толық жазылуы тиіс)',
  `filepath` TEXT NOT NULL COMMENT 'Файлдың орналасқан жері',
  `document_id` INT NOT NULL,
  `user_id` INT NOT NULL COMMENT 'Құжатты базаға енгізген кісі',
  `doc_attache_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`doc_attache_id`, `user_id`, `document_id`),
  INDEX `fk_doc_attaches_1_idx` (`user_id` ASC),
  INDEX `fk_doc_attaches_2_idx` (`document_id` ASC),
  CONSTRAINT `fk_doc_attaches_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `test`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_doc_attaches_2`
    FOREIGN KEY (`document_id`)
    REFERENCES `test`.`documents` (`document_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Жүктелген файлдардың тізімі';


-- -----------------------------------------------------
-- Table `test`.`employes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`employes` ;

CREATE TABLE IF NOT EXISTS `test`.`employes` (
  `fio` VARCHAR(45) NOT NULL COMMENT 'Аты-жөні',
  `dob` DATE NULL COMMENT 'Туған күні',
  `passport_No` VARCHAR(15) NULL COMMENT 'жеке куәліктің нөмірі',
  `issued_by` VARCHAR(15) NULL COMMENT 'Қайдан алынғаны',
  `iin` VARCHAR(15) NULL COMMENT 'ИИН',
  `position` VARCHAR(45) NULL COMMENT 'лауазымы',
  `company_id` INT NOT NULL COMMENT 'қай компания',
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`employee_id`, `company_id`),
  CONSTRAINT `fk_employes_1`
    FOREIGN KEY (`company_id`)
    REFERENCES `test`.`companies` (`company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Қызметкерлердің тізімі';


-- -----------------------------------------------------
-- Table `test`.`employee_files`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`employee_files` ;

CREATE TABLE IF NOT EXISTS `test`.`employee_files` (
  `employee_id` INT NOT NULL,
  `doc_attache_id` INT NOT NULL,
  PRIMARY KEY (`doc_attache_id`, `employee_id`),
  INDEX `fk_employee_files_2_idx` (`employee_id` ASC),
  CONSTRAINT `fk_employee_files_1`
    FOREIGN KEY (`doc_attache_id`)
    REFERENCES `test`.`doc_attaches` (`doc_attache_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_files_2`
    FOREIGN KEY (`employee_id`)
    REFERENCES `test`.`employes` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Қызметкерлерге қатысты файлдарды \nбайланыстыратын кесте';


-- -----------------------------------------------------
-- Table `test`.`portals`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`portals` ;

CREATE TABLE IF NOT EXISTS `test`.`portals` (
  `portal_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `portal_url` TEXT NULL,
  `portal_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`portal_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Тендер ойналатын порталдардың тізімі, олардың ерекшеліктері';


-- -----------------------------------------------------
-- Table `test`.`specifications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`specifications` ;

CREATE TABLE IF NOT EXISTS `test`.`specifications` (
  `requirement_doc` TEXT NOT NULL,
  `portal_id` INT NOT NULL,
  `specification_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`specification_id`, `portal_id`),
  CONSTRAINT `fk_specifications_1`
    FOREIGN KEY (`portal_id`)
    REFERENCES `test`.`portals` (`portal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Порталдың талаптары осы кестеде орналасқан';


-- -----------------------------------------------------
-- Table `test`.`tenders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`tenders` ;

CREATE TABLE IF NOT EXISTS `test`.`tenders` (
  `purchase_number` INT NOT NULL,
  `tender_name` TEXT NOT NULL,
  `close_date` DATETIME NOT NULL,
  `open_date` DATETIME NOT NULL,
  `method` VARCHAR(25) NOT NULL,
  `portal_id` INT NOT NULL,
  `tender_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`tender_id`, `portal_id`),
  INDEX `fk_tenders_1_idx` (`portal_id` ASC),
  CONSTRAINT `fk_tenders_1`
    FOREIGN KEY (`portal_id`)
    REFERENCES `test`.`portals` (`portal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `test`.`lots`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`lots` ;

CREATE TABLE IF NOT EXISTS `test`.`lots` (
  `lots_name` TEXT NOT NULL,
  `bugdet` FLOAT NOT NULL,
  `mc` FLOAT NOT NULL COMMENT 'Местное содержание',
  `tender_id` INT NOT NULL,
  `lot_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lot_id`, `tender_id`),
  CONSTRAINT `fk_lots_1`
    FOREIGN KEY (`tender_id`)
    REFERENCES `test`.`tenders` (`tender_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `test`.`lots_specifications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`lots_specifications` ;

CREATE TABLE IF NOT EXISTS `test`.`lots_specifications` (
  `specification_id` INT NOT NULL,
  `lot_id` INT NOT NULL,
  `lots_specification_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lots_specification_id`, `lot_id`, `specification_id`),
  INDEX `fk_lots_specifications_1_idx` (`lot_id` ASC),
  CONSTRAINT `fk_lots_specifications_1`
    FOREIGN KEY (`lot_id`)
    REFERENCES `test`.`lots` (`lot_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `test`.`lots_documents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test`.`lots_documents` ;

CREATE TABLE IF NOT EXISTS `test`.`lots_documents` (
  `lots_specification_id` INT NOT NULL,
  `doc_attache_id` INT NOT NULL,
  `lots_documents_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`lots_documents_id`, `lots_specification_id`, `doc_attache_id`),
  INDEX `fk_lots_documents_2_idx` (`doc_attache_id` ASC),
  CONSTRAINT `fk_lots_documents_1`
    FOREIGN KEY (`lots_specification_id`)
    REFERENCES `test`.`lots_specifications` (`lots_specification_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lots_documents_2`
    FOREIGN KEY (`doc_attache_id`)
    REFERENCES `test`.`doc_attaches` (`doc_attache_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




----------------------------------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `test` DEFAULT CHARACTER SET utf8;

CREATE TABLE IF NOT EXISTS `test`.`companies` (
    `company_name` VARCHAR(100) NOT NULL, -- COMMENT 'Мекеменің атауы',
    `bin` VARCHAR(15) NOT NULL, -- COMMENT 'ИИН/БИН',
    `address` TINYTEXT NULL,
    `bank_details` TEXT NULL, -- COMMENT 'Банктік реквизиті',
    `telephone` VARCHAR(45) NULL,
    `email` VARCHAR(45) NULL,
    `position` VARCHAR(30) NOT NULL, -- COMMENT 'Басшының лауазымы',
    `director` VARCHAR(45) NOT NULL, -- COMMENT 'Басшының аты-жөні',
    `company_id` INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`company_id`)
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8 COMMENT='Мекемелердің тізімі';


CREATE TABLE IF NOT EXISTS `test`.`users` (
    `username` VARCHAR(15) NOT NULL,
    `password` VARCHAR(100) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `blocked` TINYINT(1) NULL DEFAULT 0,
    `user_id` INT(11) NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`user_id`)
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8 COMMENT='Мәліметтер қорының пайдаланушылары';

CREATE TABLE IF NOT EXISTS `test`.`documents` (
    `document_folder` VARCHAR(45) NOT NULL, -- COMMENT 'Құжаттар топтамасының атауы(папканың аты)',
    `description` VARCHAR(255) NOT NULL, -- COMMENT 'Сол топтаманың сипаттамасы (қандай құжаттар екені)',
    `company_id` INT NOT NULL, -- COMMENT 'Топтаманың иесі',
    `document_id` INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`document_id` , `company_id`),
    INDEX `fk_documents_1_idx` (`company_id` ASC),
    CONSTRAINT `fk_documents_1` FOREIGN KEY (`company_id`)
        REFERENCES `test`.`companies` (`company_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8 COMMENT='Құжаттардың топтамасы';

CREATE TABLE IF NOT EXISTS `test`.`doc_attaches` (
    `document_name` TINYTEXT NOT NULL, -- COMMENT 'Құжаттың толық атауы',
    `language` VARCHAR(30) NOT NULL, -- COMMENT 'Қай тілде жазылғандығы жайлы',
    `create_date` DATE NOT NULL, -- COMMENT 'Құжаттың берілген/жазылған күні',
    `validate_date` DATE NOT NULL, -- COMMENT 'Жарамдылық мерзімі',
    `description` TEXT NOT NULL, -- COMMENT 'Жалпы осы құжаттың тарихы (барынша толық жазылуы тиіс)',
    `filepath` TEXT NOT NULL, -- COMMENT 'Файлдың орналасқан жері',
    `document_id` INT NOT NULL,
    `user_id` INT NOT NULL, -- COMMENT 'Құжатты базаға енгізген кісі',
    `doc_attache_id` INT NOT NULL,
    PRIMARY KEY (`doc_attache_id` , `user_id` , `document_id`),
    INDEX `fk_doc_attaches_1_idx` (`user_id` ASC),
    INDEX `fk_doc_attaches_2_idx` (`document_id` ASC),
    CONSTRAINT `fk_doc_attaches_1` FOREIGN KEY (`user_id`)
        REFERENCES `test`.`users` (`user_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_doc_attaches_2` FOREIGN KEY (`document_id`)
        REFERENCES `test`.`documents` (`document_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8 COMMENT='Жүктелген файлдардың тізімі';

CREATE TABLE IF NOT EXISTS `test`.`employes` (
    `fio` VARCHAR(45) NOT NULL, -- COMMENT 'Аты-жөні',
    `dob` DATE NULL, -- COMMENT 'Туған күні',
    `passport_No` VARCHAR(15) NULL, -- COMMENT 'жеке куәліктің нөмірі',
    `issued_by` VARCHAR(15) NULL, -- COMMENT 'Қайдан алынғаны',
    `iin` VARCHAR(15) NULL, -- COMMENT 'ИИН',
    `position` VARCHAR(45) NULL, -- COMMENT 'лауазымы',
    `company_id` INT NOT NULL, -- COMMENT 'қай компания',
    `employee_id` INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`employee_id` , `company_id`),
    CONSTRAINT `fk_employes_1` FOREIGN KEY (`company_id`)
        REFERENCES `test`.`companies` (`company_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8 COMMENT='Қызметкерлердің тізімі';

CREATE TABLE IF NOT EXISTS `test`.`employee_files` (
    `employee_id` INT NOT NULL,
    `doc_attache_id` INT NOT NULL,
    PRIMARY KEY (`doc_attache_id` , `employee_id`),
    INDEX `fk_employee_files_2_idx` (`employee_id` ASC),
    CONSTRAINT `fk_employee_files_1` FOREIGN KEY (`doc_attache_id`)
        REFERENCES `test`.`doc_attaches` (`doc_attache_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_employee_files_2` FOREIGN KEY (`employee_id`)
        REFERENCES `test`.`employes` (`employee_id`)
        ON DELETE NO ACTION ON UPDATE NO ACTION
)  ENGINE=INNODB DEFAULT CHARACTER SET=UTF8 COMMENT='Қызметкерлерге қатысты файлдарды байланыстыратын кесте';





INSERT INTO `test`.`users` 
	(`username`, `password`, `email`, `blocked`, `user_id`) 
	VALUES 
    ('root', 'password', 'kmadi@inbox.ru', NULL, NULL);

INSERT INTO `companies` 
	VALUES 
    ('ТОО \"Атыраугеоконтроль\"','060840005288','Республика Казахстан, 060026, г.Атырау, Северная Промзона, 29а',NULL,'+7 7122 30-65-88','reception@atyraugeocontrol.kz','Генеральный директор','Сулейменов Ж.Е.',1),
    ('ТОО \"БатысГеоЗерттеу\"','080440015511','Республика Казахстан, 060026, г.Атырау, Северная Промзона, 29',NULL,'+7 7122 хх-хх-хх','reception@bgz.kz','Директор','Нурмуханов К.У.',2);
