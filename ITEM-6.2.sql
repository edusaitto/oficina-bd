USE oficina;

SELECT * FROM cliente;

SELECT * FROM servico;

SELECT * FROM oficina WHERE oficina_id = 1;

SELECT * FROM mecanico WHERE mecanico_id = 1;

SELECT modelo FROM veiculo WHERE marca="peugeot";

SELECT marca FROM veiculo GROUP BY marca;

SELECT valor_total, aprovado FROM orcamentos ORDER BY valor_total DESC; 

SELECT cliente_id, valor_total FROM orcamentos WHERE valor_total > 1000;

SELECT mecanico_id, nome FROM mecanico WHERE mecanico_id=(SELECT mecanico_id FROM servicos_realizados WHERE servico_id=2);

SELECT veiculo_id, placa FROM veiculo WHERE veiculo_id=(SELECT veiculo_id FROM orcamentos_solicitados WHERE cliente_id=2);

SELECT nome FROM cliente WHERE cliente_id=(SELECT cliente_id FROM orcamentos WHERE aprovado=1 AND valor_total > 500);