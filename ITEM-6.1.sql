USE oficina;

INSERT INTO oficina (nome) VALUES ("Project Cars");
INSERT INTO oficina (nome, endereco) VALUES ("AutoSuper", "Rua França, 30");
UPDATE oficina
SET endereco="Av. General Carlos Cavalcanti, 123" 
WHERE oficina_id=1;
DELETE FROM oficina WHERE oficina_id=1;
SELECT * FROM oficina;

INSERT INTO cliente (nome, cpf, telefone, endereco) VALUES ("Eduardo Saito", "09466435981", "5542984326218", "Rua Suíça, 99");
INSERT INTO cliente (nome, cpf) VALUES ("Neymar Júnior", "84567932133");
UPDATE cliente
SET endereco="Rua Suiça, 400"
WHERE cliente_id=1;
DELETE FROM cliente WHERE cliente_id=1;
SELECT * FROM cliente;

INSERT INTO modelo (marca, modelo) VALUES ("PEUGEOT", "207");
INSERT INTO modelo (marca, modelo) VALUES ("PEUGEOT", "206");
INSERT INTO modelo (marca, modelo) VALUES ("VOLKSWAGEN", "GOLF");
INSERT INTO modelo (marca, modelo) VALUES ("VOLKSWAGEN", "JETTA");
INSERT INTO modelo (marca, modelo) VALUES ("BMW", "Z4");
INSERT INTO modelo (marca, modelo) VALUES ("FIAT", "PUNTO");
UPDATE modelo
SET modelo="206"
WHERE modelo_id=1;
DELETE FROM modelo WHERE modelo_id=1;
SELECT * FROM modelo;

INSERT INTO veiculo (cliente_id, modelo_id, placa, ano) VALUES (14, 1, "ACO7888", 2012);
UPDATE veiculo
SET placa="ACO7G77"
WHERE veiculo_id=1;
DELETE FROM veiculo WHERE veiculo_id=1;
SELECT * FROM veiculo;

INSERT INTO mecanico (oficina_id, nome, telefone) VALUES (1, "João da Silva", "5542998067030");
INSERT INTO mecanico (oficina_id, nome, telefone) VALUES (2, "Mario Antônio", "5542983211718");
INSERT INTO mecanico (oficina_id, nome, telefone) VALUES (2, "Marco Vinícius", "5542983211718");
UPDATE mecanico
SET telefone="5542999330099"
WHERE mecanico_id=3;
DELETE FROM mecanico WHERE mecanico_id=1;
SELECT * FROM mecanico;

INSERT INTO orcamentos (cliente_id, veiculo_id) VALUES (1, 2);
INSERT INTO orcamentos (cliente_id, veiculo_id) VALUES (2, 4);
UPDATE orcamentos
SET mecanico_id=3, valor_total=2200
WHERE orcamento_id=4;
UPDATE orcamentos
SET aprovado = 1
WHERE orcamento_id=4;
DELETE FROM orcamentos WHERE orcamento_id=2;
SELECT * FROM orcamentos;

INSERT INTO orcamentos_realizados (orcamento_id, mecanico_id, data_orcamento) VALUES (1,2,'2022-03-10 18:00:00');
UPDATE orcamentos_realizados
SET mecanico_id=3
WHERE orcamento_realizado_id=1;
DELETE FROM orcamentos_realizados WHERE orcamento_realizado_id=1;
SELECT * FROM orcamentos_realizados;

INSERT INTO orcamentos_solicitados (orcamento_id, cliente_id, veiculo_id, data_solicitacao) VALUES (1,2,4,'2022-03-09 18:00:00');
UPDATE orcamentos_solicitados
SET cliente_id=3
WHERE orcamento_solicitado_id=1;
DELETE FROM orcamentos_solicitados WHERE orcamento_solicitado_id=3;
SELECT * FROM orcamentos_solicitados;

INSERT INTO servicos (tipo_servico, descricao, valor) 
VALUES ('troca de oleo comum', 'troca de óleo em carros com motor 3 ou 4 cilindros', 250);
INSERT INTO servicos (tipo_servico, descricao, valor) 
VALUES ('troca de oleo premium', 'troca de óleo para carros que utilizam semi sintético ou motores V6 e acima', 500);
UPDATE servicos
SET valor=300
WHERE servico_id=1;
DELETE FROM servicos WHERE servico_id=1;
SELECT * FROM servicos;

INSERT INTO servicos_orcados (orcamento_id, servico_id) VALUES (1,1);
UPDATE servicos_orcados
SET servico_id=2
WHERE servico_orcado_id=1;
DELETE FROM servicos_orcados WHERE servico_orcado_id=1;
SELECT * FROM servicos_orcados;

INSERT INTO servicos_realizados (servico_id, mecanico_id, data_realizacao) 
VALUES (2,2,'2022-03-11 18:00:00');
UPDATE servicos_realizados
SET servico_id=2
WHERE servico_realizado_id=1;
DELETE FROM servicos_realizados WHERE servico_realizado_id=1;
SELECT * FROM servicos_realizados;