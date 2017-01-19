/*
CREATE DATABASE db_name CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL PRIVILEGES ON db_name.* TO 'username'@'XX.XX.XX.XX or localhost';
FLUSH PRIVILEGES;
*/

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
    `description` VARCHAR(45) NOT NULL, -- COMMENT 'Сол топтаманың сипаттамасы (қандай құжаттар екені)',
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
    ('root', 'password', 'kmadi@inbox.ru', '', '');

INSERT INTO `companies` 
	VALUES 
    ('ТОО \"Атыраугеоконтроль\"','060840005288','Республика Казахстан, 060026, г.Атырау, Северная Промзона, 29а',NULL,'+7 7122 30-65-88','reception@atyraugeocontrol.kz','Генеральный директор','Сулейменов Ж.Е.',1),
    ('ТОО \"БатысГеоЗерттеу\"','080440015511','Республика Казахстан, 060026, г.Атырау, Северная Промзона, 29',NULL,'+7 7122 хх-хх-хх','reception@bgz.kz','Директор','Нурмуханов К.У.',2);
