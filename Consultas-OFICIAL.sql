USE meubd;

----------------------- 1.1 --------------------------------------
SELECT 
    f.nome_completo AS NomeFuncionario,
    f.cargo AS Cargo,
    f.endereco AS Endereco,
    f.cidade AS Cidade,
    f.salario AS Salario,
    COUNT(d.id_dependentes) AS NumDependentes
FROM 
    Funcionario f
LEFT JOIN 
    Dependentes d ON f.id_funcionarios = d.id_funcionarios
WHERE 
    f.id_agencia = 2
GROUP BY 
    f.id_funcionarios
ORDER BY 
    f.nome_completo;
    
----------------------------------- 1.2 -----------------------------------
SELECT 
    c.nome_dependente AS NomeCliente,
    cb.tipos_conta AS TipoConta
FROM 
    conta_e_cliente cec
JOIN 
    Clientes c ON cec.cpf = c.cpf
JOIN 
    conta_bancaria cb ON cec.num_conta = cb.num_conta
WHERE 
    cb.id_agencia = 1
ORDER BY 
    cb.tipos_conta;
    
----------------------------------- 1.3 --------------------------------
SELECT 
    ce.num_conta AS NumConta,
    (cb.saldo - ce.limite_credito) AS SaldoDevedor
FROM 
    conta_especial ce
JOIN 
    conta_bancaria cb ON ce.num_conta = cb.num_conta
WHERE 
    cb.saldo < 0
ORDER BY 
    SaldoDevedor DESC;
    
-------------------------------- 1.4 -----------------------------
SELECT 
    p.num_conta AS NumConta,
    cb.saldo AS Saldo
FROM 
    poupanca p
JOIN 
    conta_bancaria cb ON p.num_conta = cb.num_conta
WHERE 
    cb.saldo > 0
ORDER BY 
    cb.saldo DESC;

----------------------------- 1.5 ---------------------------------------
-- 7 dias
SELECT 
    cb.num_conta AS NumConta,
    COUNT(t.id_transacao) AS NumTransacoes
FROM 
    transacao t
JOIN 
    conta_bancaria cb ON t.num_conta = cb.num_conta
WHERE 
    cb.tipos_conta = 'corrente'
    AND t.data_hora >= NOW() - INTERVAL 7 DAY
GROUP BY 
    cb.num_conta
ORDER BY 
    NumTransacoes DESC;

-- 30 dias
SELECT 
    cb.num_conta AS NumConta,
    COUNT(t.id_transacao) AS NumTransacoes
FROM 
    transacao t
JOIN 
    conta_bancaria cb ON t.num_conta = cb.num_conta
WHERE 
    cb.tipos_conta = 'corrente'
    AND t.data_hora >= NOW() - INTERVAL 30 DAY
GROUP BY 
    cb.num_conta
ORDER BY 
    NumTransacoes DESC;

-- 365 dias
SELECT 
    cb.num_conta AS NumConta,
    COUNT(t.id_transacao) AS NumTransacoes
FROM 
    transacao t
JOIN 
    conta_bancaria cb ON t.num_conta = cb.num_conta
WHERE 
    cb.tipos_conta = 'corrente'
    AND t.data_hora >= NOW() - INTERVAL 365 DAY
GROUP BY 
    cb.num_conta
ORDER BY 
    NumTransacoes DESC;
    
----------------------------- 1.6 -------------------------------
-- 7 dias
SELECT 
    cb.num_conta AS NumConta,
    SUM(t.valor) AS VolumeMovimentacoes
FROM 
    transacao t
JOIN 
    conta_bancaria cb ON t.num_conta = cb.num_conta
WHERE 
    t.data_hora >= NOW() - INTERVAL 7 DAY
GROUP BY 
    cb.num_conta
ORDER BY 
    VolumeMovimentacoes DESC;

-- 30 dias
SELECT 
    cb.num_conta AS NumConta,
    SUM(t.valor) AS VolumeMovimentacoes
FROM 
    transacao t
JOIN 
    conta_bancaria cb ON t.num_conta = cb.num_conta
WHERE 
    t.data_hora >= NOW() - INTERVAL 30 DAY
GROUP BY 
    cb.num_conta
ORDER BY 
    VolumeMovimentacoes DESC;

-- 365 dias
SELECT 
    cb.num_conta AS NumConta,
    SUM(t.valor) AS VolumeMovimentacoes
FROM 
    transacao t
JOIN 
    conta_bancaria cb ON t.num_conta = cb.num_conta
WHERE 
    t.data_hora >= NOW() - INTERVAL 365 DAY
GROUP BY 
    cb.num_conta
ORDER BY 
    VolumeMovimentacoes DESC;
    
-- ------------------------- 2.1 ---------------------------------
SELECT 
    cb.num_conta AS NumConta,
    cb.tipos_conta AS TipoConta,
    a.nome_agencia AS Agencia,
    f.nome_completo AS Gerente,
    cb.saldo AS Saldo
FROM 
    conta_e_cliente cec
JOIN 
    conta_bancaria cb ON cec.num_conta = cb.num_conta
JOIN 
    agencia a ON cb.id_agencia = a.id_agencia
JOIN 
    Funcionario f ON cb.id_funcionarios = f.id_funcionarios
WHERE 
    cec.cpf = 2147483647;
    
-- ----------------------------- 2.2 --------------------------------------
SELECT 
    c.nome_dependente AS NomeCliente,
    c.cpf AS CPF
FROM 
    conta_e_cliente cec
JOIN 
    Clientes c ON cec.cpf = c.cpf
WHERE 
    cec.num_conta IN (
        SELECT num_conta
        FROM conta_e_cliente
        WHERE cpf = 1356597834
    )
    AND cec.cpf != 1356597834;
    
-- ------------------------------ 2.3 ----------------------------------------
-- 7 dias
SELECT 
    cb.num_conta AS NumConta,
    COUNT(t.id_transacao) AS NumTransacoes
FROM 
    transacao t
JOIN 
    conta_bancaria cb ON t.num_conta = cb.num_conta
JOIN 
    conta_e_cliente cec ON cb.num_conta = cec.num_conta
WHERE 
    cec.cpf = 1234568792
    AND cb.tipos_conta = 'corrente'
    AND t.data_hora >= NOW() - INTERVAL 7 DAY
GROUP BY 
    cb.num_conta
ORDER BY 
    NumTransacoes DESC;
    
-- 30 dias
SELECT 
    cb.num_conta AS NumConta,
    COUNT(t.id_transacao) AS NumTransacoes
FROM 
    transacao t
JOIN 
    conta_bancaria cb ON t.num_conta = cb.num_conta
JOIN 
    conta_e_cliente cec ON cb.num_conta = cec.num_conta
WHERE 
    cec.cpf = 1234568792
    AND cb.tipos_conta = 'corrente'
    AND t.data_hora >= NOW() - INTERVAL 30 DAY
GROUP BY 
    cb.num_conta
ORDER BY 
    NumTransacoes DESC;

-- 365 dias
SELECT 
    cb.num_conta AS NumConta,
    COUNT(t.id_transacao) AS NumTransacoes
FROM 
    transacao t
JOIN 
    conta_bancaria cb ON t.num_conta = cb.num_conta
JOIN 
    conta_e_cliente cec ON cb.num_conta = cec.num_conta
WHERE 
    cec.cpf = 1234568792
    AND cb.tipos_conta = 'corrente'
    AND t.data_hora >= NOW() - INTERVAL 365 DAY
GROUP BY 
    cb.num_conta
ORDER BY 
    NumTransacoes DESC;
   
-- ------------------ 2.4 ------------------------------------
-- 7 dias
SELECT 
    cb.num_conta AS NumConta,
    SUM(t.valor) AS VolumeMovimentacoes
FROM 
    transacao t
JOIN 
    conta_bancaria cb ON t.num_conta = cb.num_conta
JOIN 
    conta_e_cliente cec ON cb.num_conta = cec.num_conta
WHERE 
    cec.cpf = 1234568792
    AND t.data_hora >= NOW() - INTERVAL 7 DAY
GROUP BY 
    cb.num_conta
ORDER BY 
    VolumeMovimentacoes DESC;

-- 30 dias
SELECT 
    cb.num_conta AS NumConta,
    SUM(t.valor) AS VolumeMovimentacoes
FROM 
    transacao t
JOIN 
    conta_bancaria cb ON t.num_conta = cb.num_conta
JOIN 
    conta_e_cliente cec ON cb.num_conta = cec.num_conta
WHERE 
    cec.cpf = 1234568792
    AND t.data_hora >= NOW() - INTERVAL 30 DAY
GROUP BY 
    cb.num_conta
ORDER BY 
    VolumeMovimentacoes DESC;
    
-- 365 dias
SELECT 
    cb.num_conta AS NumConta,
    SUM(t.valor) AS VolumeMovimentacoes
FROM 
    transacao t
JOIN 
    conta_bancaria cb ON t.num_conta = cb.num_conta
JOIN 
    conta_e_cliente cec ON cb.num_conta = cec.num_conta
WHERE 
    cec.cpf = 1234568792
    AND t.data_hora >= NOW() - INTERVAL 365 DAY
GROUP BY 
    cb.num_conta
ORDER BY 
    VolumeMovimentacoes DESC;

-- ------------------ 3.1 ----------------------------------------
SELECT 
    nome_dependente AS NomeCliente,
    endereco AS Endereco,
    TIMESTAMPDIFF(YEAR, data_nascimento, NOW()) AS Idade
FROM 
    Clientes
WHERE 
    cidade = 'Sobral'
ORDER BY 
    Idade;
    
-- ---------------------- 3.2 ----------------------------------
SELECT 
    f.nome_completo AS NomeFuncionario,
    f.endereco AS Endereco,
    f.cargo AS Cargo,
    f.salario AS Salario,
    a.nome_agencia AS Agencia
FROM 
    Funcionario f
JOIN 
    agencia a ON f.id_agencia = a.id_agencia
WHERE 
    a.cidade = 'Fortaleza'
ORDER BY 
    a.nome_agencia, f.cargo, f.salario;
    
-- --------------------------------- 3.3 ---------------------------------
SELECT 
    a.nome_agencia AS Agencia,
    SUM(f.salario) AS SalarioTotal
FROM 
    Funcionario f
JOIN 
    agencia a ON f.id_agencia = a.id_agencia
WHERE 
    a.cidade = 'Juazeiro do Norte'
GROUP BY 
    a.nome_agencia
ORDER BY 
    SalarioTotal DESC;
    
-------------------------------- 4.0 -------------------------------
CREATE VIEW ContasGerente AS
SELECT 
    cb.num_conta AS NumConta,
    cb.tipos_conta AS TipoConta,
    cb.saldo AS Saldo,
    c.nome_dependente AS NomeCliente
FROM 
    conta_bancaria cb
JOIN 
    conta_e_cliente cec ON cb.num_conta = cec.num_conta
JOIN 
    Clientes c ON cec.cpf = c.cpf
WHERE 
    cb.id_funcionarios = 105;
    
-------------------------------- 5.0 -----------------------------------
CREATE VIEW ExtratoConta1 AS
SELECT 
    t.id_transacao AS TransacaoID,
    t.tipo_transacao AS TipoTransacao,
    t.data_hora AS DataHora,
    t.valor AS Valor
FROM 
    transacao t
WHERE 
    t.num_conta = 101767
    AND t.data_hora >= NOW() - INTERVAL 365 DAY;
    
    CREATE VIEW ExtratoConta2 AS
SELECT 
    t.id_transacao AS TransacaoID,
    t.tipo_transacao AS TipoTransacao,
    t.data_hora AS DataHora,
    t.valor AS Valor
FROM 
    transacao t
WHERE 
    t.num_conta = 156848
    AND t.data_hora >= NOW() - INTERVAL 365 DAY;
    
CREATE VIEW ExtratoConta3 AS
SELECT 
    t.id_transacao AS TransacaoID,
    t.tipo_transacao AS TipoTransacao,
    t.data_hora AS DataHora,
    t.valor AS Valor
FROM 
    transacao t
WHERE 
    t.num_conta = 176325
    AND t.data_hora >= NOW() - INTERVAL 365 DAY;
    
-- -------------------------- 6.0 ---------------------------------
DELIMITER //
CREATE TRIGGER AtualizarSalarioTotalAgencia
AFTER INSERT ON Funcionario
FOR EACH ROW
BEGIN
    UPDATE agencia
    SET salario_total = salario_total + NEW.salario
    WHERE id_agencia = NEW.id_agencia;
END //
DELIMITER ;

-- ------------------------------- 7.0 -------------------------------
DELIMITER //
CREATE TRIGGER AtualizarSaldoConta
AFTER INSERT ON transacao
FOR EACH ROW
BEGIN
    IF NEW.tipo_transacao = 'deposito' THEN
        UPDATE conta_bancaria
        SET saldo = saldo + NEW.valor
        WHERE num_conta = NEW.num_conta;
    ELSEIF NEW.tipo_transacao = 'saque' THEN
        UPDATE conta_bancaria
        SET saldo = saldo - NEW.valor
        WHERE num_conta = NEW.num_conta;
    END IF;
END //
DELIMITER ;

-- ---------------------------- 8.0 -----------------------------
START TRANSACTION;

UPDATE conta_bancaria
SET saldo = saldo - 50.00
WHERE num_conta = 101767;

UPDATE conta_bancaria
SET saldo = saldo + 50.00
WHERE num_conta = 156348;

INSERT INTO transacao (id_transacao, num_conta, tipo_transacao, data_hora, valor)
VALUES (1, 101767, 'saque', NOW(), 50.00);

INSERT INTO transacao (id_transacao, num_conta, tipo_transacao, data_hora, valor)
VALUES (2, 156348, 'deposito', NOW(), 50.00);

COMMIT;

----------------------- 9.0 ---------------------------
-- funcionários que não tem dependentes
SELECT 
    f.nome_completo AS NomeFuncionario,
    f.cargo AS Cargo
FROM 
    Funcionario f
LEFT JOIN 
    Dependentes d ON f.id_funcionarios = d.id_funcionarios
WHERE 
    d.id_dependentes IS NULL;

----------------------- 10.0 --------------------------
-- clientes que não possuem contas conjuntas
SELECT 
    c.nome_dependente AS NomeCliente,
    c.cpf AS CPF
FROM 
    Clientes c
JOIN 
    conta_e_cliente cec ON c.cpf = cec.cpf
GROUP BY 
    c.cpf
HAVING 
    COUNT(cec.num_conta) = 1;