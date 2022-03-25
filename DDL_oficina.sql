CREATE DATABASE oficina;

USE oficina;

CREATE TABLE oficina (
	oficina_id INT(5) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    endereco VARCHAR(60)
);

CREATE TABLE mecanico (
	mecanico_id INT(5) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    oficina_id INT(5) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    telefone VARCHAR(13) NOT NULL
);

ALTER TABLE mecanico ADD CONSTRAINT FK_oficina_id
FOREIGN KEY (oficina_id) REFERENCES oficina(oficina_id);

CREATE TABLE modelo (
	modelo_id INT(5) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(30) NOT NULL,
    modelo VARCHAR(30) NOT NULL
);

CREATE TABLE veiculo (
	veiculo_id INT(5) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT(5) NOT NULL,
    modelo_id INT(5) NOT NULL,
    placa VARCHAR(7) NOT NULL,
    ano INT(4)
);

ALTER TABLE veiculo ADD CONSTRAINT FK_cliente_id
FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id);

ALTER TABLE veiculo ADD CONSTRAINT FK_modelo_id
FOREIGN KEY (modelo_id) REFERENCES modelo(modelo_id);

CREATE TABLE cliente (
	cliente_id INT(5) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    telefone VARCHAR(13),
    endereco VARCHAR(60)
);

CREATE TABLE orcamentos (
	orcamento_id INT(5) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT(5) NOT NULL,
    veiculo_id INT(5) NOT NULL,
    mecanico_id INT(5),
    valor_total DECIMAL(7,2),
    aprovado BOOLEAN
);

ALTER TABLE orcamentos ADD CONSTRAINT FK_cliente_id
FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id);

ALTER TABLE orcamentos ADD CONSTRAINT FK_veiculo_id
FOREIGN KEY (veiculo_id) REFERENCES veiculo(veiculo_id);

ALTER TABLE orcamentos ADD CONSTRAINT FK_mecanico_id
FOREIGN KEY (mecanico_id) REFERENCES mecanico(mecanico_id);

CREATE TABLE orcamentos_solicitados (
	orcamento_solicitado_id INT(5) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    orcamento_id INT(5) NOT NULL,
    cliente_id INT(5) NOT NULL,
    veiculo_id INT(5) NOT NULL,
    data_solicitacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE orcamentos_solicitados ADD CONSTRAINT FK_orcamento_id
FOREIGN KEY (orcamento_id) REFERENCES orcamentos(orcamento_id);

ALTER TABLE orcamentos_solicitados ADD CONSTRAINT FK_cliente_id
FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id);

ALTER TABLE orcamentos_solicitados ADD CONSTRAINT FK_veiculo_id
FOREIGN KEY (veiculo_id) REFERENCES veiculo(veiculo_id);

CREATE TABLE orcamentos_realizados (
	orcamento_realizado_id INT(5) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    orcamento_id INT(5) NOT NULL,
    mecanico_id INT(5) NOT NULL,
    data_orcamento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE orcamentos_realizados ADD CONSTRAINT FK_mecanico_id
FOREIGN KEY (mecanico_id) REFERENCES mecanico(mecanico_id);

ALTER TABLE orcamentos_realizados ADD CONSTRAINT FK_orcamento_id
FOREIGN KEY (orcamento_id) REFERENCES orcamentos(orcamento_id);

CREATE TABLE servicos (
	servico_id INT(5) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tipo_servico VARCHAR(30) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    valor DECIMAL(7,2) NOT NULL
);

CREATE TABLE servicos_orcados (
	servico_orcado_id INT(5) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    orcamento_id INT(5) NOT NULL,
    servico_id INT(5) NOT NULL
);

ALTER TABLE servicos_orcados ADD CONSTRAINT FK_servico_id
FOREIGN KEY (servico_id) REFERENCES servico(servico_id);

ALTER TABLE servicos_orcados ADD CONSTRAINT FK_orcamento_id
FOREIGN KEY (orcamento_id) REFERENCES orcamentos(orcamento_id);

CREATE TABLE servicos_realizados (
	servico_realizado_id INT(5) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    servico_id INT(5) NOT NULL,
    mecanico_id INT(5) NOT NULL,
    data_realizacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE servicos_realizados ADD CONSTRAINT FK_servico_id
FOREIGN KEY (servico_id) REFERENCES servico(servico_id);

ALTER TABLE servicos_realizados ADD CONSTRAINT FK_mecanico_id
FOREIGN KEY (mecanico_id) REFERENCES mecanico(mecanico_id);