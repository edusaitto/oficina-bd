USE oficina;

CREATE OR REPLACE VIEW nomes_mecanicos AS
SELECT nome FROM mecanico;
SELECT * FROM nomes_mecanicos;

CREATE OR REPLACE VIEW marcas_veiculos AS
SELECT marca FROM veiculo GROUP BY marca;
SELECT * FROM marcas_veiculos;

CREATE OR REPLACE VIEW orcamentos_aprovados AS
SELECT * FROM orcamentos WHERE aprovado=1;
SELECT * FROM orcamentos_aprovados;

CREATE OR REPLACE VIEW orcamentos_nome_cliente AS
SELECT o.orcamento_id, c.nome, o.veiculo_id, o.mecanico_id, o.valor_total, o.aprovado
FROM orcamentos AS o
INNER JOIN cliente AS c ON c.cliente_id = o.cliente_id;
SELECT * FROM orcamentos_nome_cliente;

CREATE OR REPLACE VIEW orcamentos_nome_mecanico AS
SELECT o.orcamento_id, o.nome AS cliente, o.veiculo_id, m.nome AS mecanico, o.valor_total, o.aprovado
FROM orcamentos_nome_cliente AS o
INNER JOIN mecanico AS m ON m.mecanico_id = o.mecanico_id;
SELECT * FROM orcamentos_nome_mecanico;

CREATE OR REPLACE VIEW orcamentos_completos AS
SELECT o.orcamento_id, o.cliente, v.placa AS placa, o.mecanico, o.valor_total, o.aprovado
FROM orcamentos_nome_mecanico AS o
INNER JOIN veiculo AS v ON v.veiculo_id = o.veiculo_id;
SELECT * FROM orcamentos_completos;

CREATE OR REPLACE VIEW orcamentos_incompletos AS
SELECT o.orcamento_id, o.nome, v.placa AS placa, o.mecanico_id, o.valor_total, o.aprovado
FROM orcamentos_nome_cliente AS o
INNER JOIN veiculo AS v ON v.veiculo_id = o.veiculo_id WHERE mecanico_id IS NULL;
SELECT * FROM orcamentos_incompletos;

CREATE OR REPLACE VIEW veiculos_clientes_nomes AS
SELECT v.veiculo_id, c.cliente_id, c.nome, v.placa, v.marca, v.modelo, v.ano
FROM veiculo AS v
INNER JOIN cliente AS c ON v.cliente_id = c.cliente_id;
SELECT * FROM veiculos_clientes_nomes;

##Trigger para quando o cliente realizar a solicitação do orçamento
DELIMITER $$
CREATE TRIGGER tgr_solicita_orcamento AFTER INSERT
ON orcamentos
FOR EACH ROW
BEGIN
    CALL prc_solicita_orcamento (new.orcamento_id, new.cliente_id, new.veiculo_id);
END $$
DELIMITER ;

##Trigger para quando o mecanico realizar o orçamento
DELIMITER $$
CREATE TRIGGER tgr_realiza_orcamento AFTER UPDATE
ON orcamentos
FOR EACH ROW
BEGIN
	IF new.aprovado IS NULL THEN
		CALL prc_realiza_orcamento (new.orcamento_id, new.mecanico_id);
	END IF;
END $$
DELIMITER ;

##Trigger para excluir cliente junto com veiculos
DELIMITER $$
CREATE TRIGGER tgr_excluir_cliente AFTER DELETE
ON cliente
FOR EACH ROW
BEGIN
	DELETE FROM veiculo WHERE cliente_id=old.cliente_id;
END $$
DELIMITER ;

##Trigger para excluir oficina junto com mecanicos
DELIMITER $$
CREATE TRIGGER tgr_excluir_oficina AFTER DELETE
ON oficina
FOR EACH ROW
BEGIN
	DELETE FROM mecanico WHERE oficina_id=old.oficina_id;
END $$
DELIMITER ;

##Procedure para quando o cliente realizar a solicitação do orçamento
DELIMITER $$
	CREATE PROCEDURE `prc_solicita_orcamento`(orcamento_id INT(5), cliente_id INT(5), veiculo_id INT(5))
    BEGIN
		INSERT INTO orcamentos_solicitados(orcamento_id, cliente_id, veiculo_id) VALUES (orcamento_id, cliente_id, veiculo_id);
    END $$
DELIMITER ;

##Procedure para quando o mecanico realizar o orçamento
DELIMITER $$
	CREATE PROCEDURE `prc_realiza_orcamento`(orcamento_id INT(5), mecanico_id INT(5))
    BEGIN
		INSERT INTO orcamentos_realizados(orcamento_id, mecanico_id) VALUES (orcamento_id, mecanico_id);
    END $$
DELIMITER ;

##Procedure para serviço realizado
DELIMITER $$
	CREATE PROCEDURE `prc_servico_realizado`(mecanico_id INT(5), servico_id INT(5))
    BEGIN
		INSERT INTO servicos_realizados(mecanico_id, servico_id) VALUES (mecanico_id, servico_id);
    END $$
DELIMITER ;

##Procedure para serviço orçado
DELIMITER $$
	CREATE PROCEDURE `prc_servico_orcado`(orcamento_id INT(5), servico_id INT(5))
    BEGIN
		INSERT INTO servicos_orcados(orcamento_id, servico_id) VALUES (orcamento_id, servico_id);
    END $$
DELIMITER ;

##Procedure para atualizar status de aprovado do orcamento
DELIMITER $$
	CREATE PROCEDURE `prc_status_aprovado`(orcamento_id INT(5), aprovado BOOLEAN)
    BEGIN
		UPDATE orcamentos SET aprovado=aprovado WHERE orcamento_id=orcamento_id;
    END $$
DELIMITER ;

##Procedure para calcular valor total do orcamento
DELIMITER $$
	CREATE PROCEDURE `prc_valor_total`(orcamento_id INT(5))
    BEGIN
        UPDATE orcamentos
		SET valor_total = (SELECT SUM(valor) FROM servicos INNER JOIN servicos_orcados ON servicos.servico_id = servicos_orcados.servico_id WHERE servicos_orcados.orcamento_id=orcamento_id)
		WHERE orcamentos.orcamento_id=orcamento_id;
    END $$
DELIMITER ;