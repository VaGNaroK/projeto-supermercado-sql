-- =============================================
-- Banco de Dados: Sistema de Mercado
-- Feito por: GILBERTO VAGNER FERREIRA CAVALCANTE
-- =============================================

-- Cria o banco de dados
CREATE SCHEMA IF NOT EXISTS `db_sistema_mercado` DEFAULT CHARACTER SET utf8 ;
USE `db_sistema_mercado` ;

-- Tabela categorias dos produtos
CREATE TABLE IF NOT EXISTS `db_sistema_mercado`.`tbl_categoria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `descricao` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- Tabela produtos
CREATE TABLE IF NOT EXISTS `db_sistema_mercado`.`tbl_produto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `preco` DECIMAL(10,2) NOT NULL,
  `id_categoria` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_produto_categoria_idx` (`id_categoria` ASC),
  CONSTRAINT `fk_produto_categoria`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `db_sistema_mercado`.`tbl_categoria` (`id`))
ENGINE = InnoDB;


-- Tabela clientes
CREATE TABLE IF NOT EXISTS `db_sistema_mercado`.`tbl_cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) NOT NULL,
  `cpf` VARCHAR(11) NULL,
  `telefone` VARCHAR(15) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC))
ENGINE = InnoDB;


-- Tabela colaboradores (vendedores)
CREATE TABLE IF NOT EXISTS `db_sistema_mercado`.`tbl_colaborador` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- Tabela formas de pagamento
CREATE TABLE IF NOT EXISTS `db_sistema_mercado`.`tbl_forma_pagamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- Tabela informações de cada venda
CREATE TABLE IF NOT EXISTS `db_sistema_mercado`.`tbl_venda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_hora` DATETIME NOT NULL,
  `valor_total` DECIMAL(10,2) NOT NULL,
  `id_cliente` INT NOT NULL,
  `id_colaborador` INT NOT NULL,
  `id_forma_pagamento` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_venda_cliente_idx` (`id_cliente` ASC),
  INDEX `fk_venda_colaborador_idx` (`id_colaborador` ASC),
  INDEX `fk_venda_forma_pagamento_idx` (`id_forma_pagamento` ASC),
  CONSTRAINT `fk_venda_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `db_sistema_mercado`.`tbl_cliente` (`id`),
  CONSTRAINT `fk_venda_colaborador`
    FOREIGN KEY (`id_colaborador`)
    REFERENCES `db_sistema_mercado`.`tbl_colaborador` (`id`),
  CONSTRAINT `fk_venda_forma_pagamento`
    FOREIGN KEY (`id_forma_pagamento`)
    REFERENCES `db_sistema_mercado`.`tbl_forma_pagamento` (`id`))
ENGINE = InnoDB;


-- Tabela ligar os produtos a cada venda
CREATE TABLE IF NOT EXISTS `db_sistema_mercado`.`tbl_item_venda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantidade` INT NOT NULL,
  `preco_momento` DECIMAL(10,2) NOT NULL,
  `id_venda` INT NOT NULL,
  `id_produto` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_item_venda_venda_idx` (`id_venda` ASC),
  INDEX `fk_item_venda_produto_idx` (`id_produto` ASC),
  CONSTRAINT `fk_item_venda_venda`
    FOREIGN KEY (`id_venda`)
    REFERENCES `db_sistema_mercado`.`tbl_venda` (`id`),
  CONSTRAINT `fk_item_venda_produto`
    FOREIGN KEY (`id_produto`)
    REFERENCES `db_sistema_mercado`.`tbl_produto` (`id`))
ENGINE = InnoDB;
