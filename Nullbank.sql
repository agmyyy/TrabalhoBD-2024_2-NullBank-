
CREATE DATABASE IF NOT EXISTS `NullBank`;
USE `NullBank`;

CREATE TABLE IF NOT EXISTS `Agencia` (
 `num_ag` INT NOT NULL AUTO_INCREMENT,
 `nome_ag` VARCHAR(100) NOT NULL,
 `sal_total` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
 `cidade` VARCHAR(100) NOT NULL,
 PRIMARY KEY (`num_ag`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Funcionario` (
 `matricula` VARCHAR(100) NOT NULL,
 `nome` VARCHAR(100) NOT NULL,
 `senha` VARCHAR(255) NOT NULL,
 `endereco` TEXT NOT NULL,
 `cidade` VARCHAR(100) NOT NULL,
 `cargo` ENUM('gerente', 'atendente', 'caixa') NOT NULL,
 `genero` ENUM('masculino', 'feminino', 'não-binário') NOT NULL,
 `data_nascimento` DATE NOT NULL,
 `salario` DECIMAL(10,2) NOT NULL CHECK (`salario` >= 2286.00), 
 `num_ag` INT NOT NULL, 
 PRIMARY KEY (`matricula`),
 FOREIGN KEY (`num_ag`) REFERENCES `Agencia` (`num_ag`) ON DELETE 
CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Dependente` (
 `id_dependente` INT NOT NULL AUTO_INCREMENT,
 `matricula_func` VARCHAR(100) NOT NULL,
 `nome` VARCHAR(100) NOT NULL,
 `data_nascimento` DATE NOT NULL,
 `parentesco` ENUM('filho(a)', 'cônjuge', 'genitor(a)') NOT NULL,
 `idade` INT,
 PRIMARY KEY (`id_dependente`),
 FOREIGN KEY (`matricula_func`) REFERENCES `Funcionario` (`matricula`) ON 
DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Cliente` (
 `cpf` CHAR(11) NOT NULL,
 `nome` VARCHAR(100) NOT NULL,
 `rg` VARCHAR(15) NOT NULL,
 `orgao_emissor` VARCHAR(10) NOT NULL,
 `uf` CHAR(2) NOT NULL,
 `data_nascimento` DATE NOT NULL,
 `endereco` TEXT NOT NULL,
 PRIMARY KEY (`cpf`)
) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Telefone` (
 `id_telefone` INT NOT NULL AUTO_INCREMENT,
 `cpf_cliente` CHAR(11) NOT NULL,
 `numero` VARCHAR(15) NOT NULL,
 PRIMARY KEY (`id_telefone`),
 FOREIGN KEY (`cpf_cliente`) REFERENCES `Cliente` (`cpf`) ON DELETE 
CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Email` (
 `id_email` INT NOT NULL AUTO_INCREMENT,
 `cpf_cliente` CHAR(11) NOT NULL,
 `email` VARCHAR(254) NOT NULL,
 PRIMARY KEY (`id_email`),
 FOREIGN KEY (`cpf_cliente`) REFERENCES `Cliente` (`cpf`) ON DELETE 
CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Conta` (
 `num_conta` INT NOT NULL AUTO_INCREMENT,
 `saldo` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
 `senha` VARCHAR(255) NOT NULL, -- Senha criptografada
 `tipo_conta` ENUM('conta-corrente', 'poupança', 'conta especial') NOT NULL,
 `taxa_juros` DECIMAL(5,2) DEFAULT NULL, -- Apenas para poupança
 `limite_credito` DECIMAL(10,2) DEFAULT NULL, -- Apenas para conta especial
 `data_aniversario` DATE DEFAULT NULL, -- Apenas para conta-corrente
 `num_ag` INT NOT NULL,
 `gerente_matricula` VARCHAR(100) NOT NULL,
 PRIMARY KEY (`num_conta`),
 FOREIGN KEY (`num_ag`) REFERENCES `Agencia` (`num_ag`) ON DELETE 
CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (`gerente_matricula`) REFERENCES `Funcionario` (`matricula`) ON 
DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Cliente_Conta` (
 `cpf_cliente` CHAR(11) NOT NULL,
 `num_conta` INT NOT NULL,
 PRIMARY KEY (`cpf_cliente`, `num_conta`),
 FOREIGN KEY (`cpf_cliente`) REFERENCES `Cliente` (`cpf`) ON DELETE 
CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (`num_conta`) REFERENCES `Conta` (`num_conta`) ON DELETE 
CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Transacao` (
 `num_transacao` INT NOT NULL AUTO_INCREMENT,
 `tipo_transacao` ENUM('saque', 'pagamento', 'deposito', 'estorno', 'transferencia', 'PIX') 
NOT NULL,
 `data_hora` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 `valor_transacao` DECIMAL(10,2) NOT NULL,
 `num_conta` INT NOT NULL,
 PRIMARY KEY (`num_transacao`),
 FOREIGN KEY (`num_conta`) REFERENCES `Conta` (`num_conta`) ON DELETE 
CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;


-- TRIGGERS PARA ATUALIZAÇÃO AUTOMÁTICA DO SALÁRIO TOTAL DAS 
AGÊNCIAS
DELIMITER $$
-- Trigger para INSERÇÃO de funcionário
CREATE TRIGGER after_insert_funcionario
AFTER INSERT ON `Funcionario`
FOR EACH ROW
BEGIN
 UPDATE `Agencia`
 SET sal_total = (SELECT IFNULL(SUM(salario), 0) FROM `Funcionario` WHERE 
num_ag = NEW.num_ag)
 WHERE num_ag = NEW.num_ag;
END$$
-- Trigger para ATUALIZAÇÃO de salário ou mudança de agência
CREATE TRIGGER after_update_funcionario
AFTER UPDATE ON `Funcionario`
FOR EACH ROW
BEGIN
 IF OLD.salario <> NEW.salario OR OLD.num_ag <> NEW.num_ag THEN
 -- Atualiza a agência antiga
 UPDATE `Agencia`
 SET sal_total = (SELECT IFNULL(SUM(salario), 0) FROM `Funcionario` WHERE 
num_ag = OLD.num_ag)
 WHERE num_ag = OLD.num_ag;
 -- Atualiza a agência nova
 UPDATE `Agencia`
 SET sal_total = (SELECT IFNULL(SUM(salario), 0) FROM `Funcionario` WHERE 
num_ag = NEW.num_ag)
 WHERE num_ag = NEW.num_ag;
 END IF;
END$$
-- Trigger para REMOÇÃO de funcionário
CREATE TRIGGER after_delete_funcionario
AFTER DELETE ON `Funcionario`
FOR EACH ROW
BEGIN
 UPDATE `Agencia`
 SET sal_total = (SELECT IFNULL(SUM(salario), 0) FROM `Funcionario` WHERE 
num_ag = OLD.num_ag)
 WHERE num_ag = OLD.num_ag;
END$$
DELIMITER ;