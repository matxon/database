/*
CREATE DATABASE db_name CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL PRIVILEGES ON db_name.* TO 'username'@'XX.XX.XX.XX or localhost';
FLUSH PRIVILEGES;
*/

CREATE TABLE documents ( 
  document_id INT AUTO_INCREMENT,
  doc_category VARCHAR(100) NOT NULL, -- COMMENT = "Құжаттың категориясы. Бірақ әлі бұған ерте сияқты",
  doc_name VARCHAR(255) NOT NULL, -- COMMENT="Құжаттың атауы", 
  doc_path VARCHAR(255) NOT NULL, -- COMMENT="Орналасқан жері", 
  validity_date DATE NOT NULL, -- COMMENT="Құжаттың мерзімі", 
  created_date DATE NOT NULL, -- COMMENT="Құжаттың салынған күні", 
  description TEXT, -- COMMENT="Түсініктеме. Құжат жайлы толық мәлімет, оның тарихы",
  author INT NOT NULL DEFAULT 1, -- COMMENT="По умолчанию системный администратор",
  PRIMARY KEY (document_id)
) COMMENT="Бұл кестеде барлық құжаттар тіркеледі. TODO: құжат салынған күн бүгінгі күнмен болуы керек";

INSERT INTO documents (doc_category, doc_name, doc_path, validity_date, created_date, description, author)
VALUES
  ('Лицензия', 'Приобретение и реализация взрывчатых материалов', './files/license001.pdf', '15/05/19', '01/08/17', 'Приобретение и реализация взрывчатых материалов', 1),
  ('Лицензия', 'Приобретение и реализация взрывчатых материалов', './files/license001.pdf', '15/05/19', '01/08/17', 'Приобретение и реализация взрывчатых материалов', 1),
  ('Лицензия', 'Приобретение и реализация взрывчатых материалов', './files/license001.pdf', '15/05/19', '01/08/17', 'Приобретение и реализация взрывчатых материалов', 1),
  ('Лицензия', 'Приобретение и реализация взрывчатых материалов', './files/license001.pdf', '15/05/19', '01/08/17', 'Приобретение и реализация взрывчатых материалов', 1),
  ('Лицензия', 'Приобретение и реализация взрывчатых материалов', './files/license001.pdf', '15/05/19', '01/08/17', 'Приобретение и реализация взрывчатых материалов', 1),
  ('Лицензия', 'Приобретение и реализация взрывчатых материалов', './files/license001.pdf', '15/05/19', '01/08/17', 'Приобретение и реализация взрывчатых материалов', 1),
  ('Лицензия', 'Приобретение и реализация взрывчатых материалов', './files/license001.pdf', '15/05/19', '01/08/17', 'Приобретение и реализация взрывчатых материалов', 1),
  ('Лицензия', 'Приобретение и реализация взрывчатых материалов', './files/license001.pdf', '15/05/19', '01/08/17', 'Приобретение и реализация взрывчатых материалов', 1),
  ('Лицензия', 'Приобретение и реализация взрывчатых материалов', './files/license001.pdf', '15/05/19', '01/08/17', 'Приобретение и реализация взрывчатых материалов', 1),
  ('Лицензия', 'Приобретение и реализация взрывчатых материалов', './files/license001.pdf', '15/05/19', '01/08/17', 'Приобретение и реализация взрывчатых материалов', 1),
  ('Лицензия', 'Приобретение и реализация взрывчатых материалов', './files/license001.pdf', '15/05/19', '01/08/17', 'Приобретение и реализация взрывчатых материалов', 1),
  ('Лицензия', 'Приобретение и реализация взрывчатых материалов', './files/license001.pdf', '15/05/19', '01/08/17', 'Приобретение и реализация взрывчатых материалов', 1),
  ('Лицензия', 'Приобретение и реализация взрывчатых материалов', './files/license001.pdf', '15/05/19', '01/08/17', 'Приобретение и реализация взрывчатых материалов', 1);

CREATE TABLE users (
  user_id INT NOT NULL AUTO_INCREMENT,
  username VARCHAR(15) NOT NULL, -- COMMENT="login",
  password VARCHAR(100) NOT NULL, -- COMMENT="password",
  fio VARCHAR(255) NOT NULL, -- COMMENT="Тегі, аты және әкесінің аты",
  email VARCHAR(50) NOT NULL,
  userstatus INT NOT NULL DEFAULT 1,
  PRIMARY KEY (user_id)
) COMMENT="Мәліметтер қорының пайдаланушылары";

INSERT INTO users 
  (username, password, fio, email, userstatus) 
VALUES
  ("root", "password", "Database Administrator", "kmadi@atyraugeocontrol.kz",1),
  ("askhat", "password", "Булекбаев Асхат", "askhat@atyraugeocontrol.kz", 1),
  ("rakhim", "password", "Молдабаев Рахым", "rakhim@bgz.kz", 2),
  ("kairat", "password", "Нурмуханов Кайрат", "kairat@bgz.kz", 3),
  ("boss", "password", "Сулейменов Жалгасбай", "zh.suleymenov@atyraugeocontrol.kz", 3),
  ("salamat", "password", "Сахим Саламат", "alex_saloma@bgz.kz", 3);


