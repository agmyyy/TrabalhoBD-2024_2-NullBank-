# 1.1
SELECT 
    f.nome AS nome_funcionario,
    f.cargo,
    f.endereco,
    f.cidade,
    f.salario,
    COUNT(d.id_dependente) AS num_dependentes
FROM 
    Funcionario f
LEFT JOIN 
    Dependente d ON f.matricula = d.matricula_func
GROUP BY 
    f.matricula
ORDER BY 
    f.nome ASC;
    
#1.2
    SELECT 
    c.nome AS nome_cliente,
    cc.num_conta,
    co.tipo_conta
FROM 
    Cliente c
JOIN 
    Cliente_Conta cc ON c.cpf = cc.cpf_cliente
JOIN 
    Conta co ON cc.num_conta = co.num_conta
JOIN 
    Agencia a ON co.num_ag = a.num_ag
WHERE 
    a.num_ag = 1
ORDER BY 
    co.tipo_conta, c.nome;
    
#1.3
SELECT 
    num_conta,
    saldo AS saldo_devedor
FROM 
    Conta
WHERE 
    tipo_conta = 'conta especial' AND saldo < 0
ORDER BY 
    saldo ASC; 
    
#1.4
SELECT 
    num_conta,
    saldo
FROM 
    Conta
WHERE 
    tipo_conta = 'poupança' AND saldo > 0
ORDER BY 
    saldo DESC;
    
#1.5
# últimos 7 dias
SELECT 
    t.num_conta,
    COUNT(t.num_transacao) AS num_transacoes
FROM 
    Transacao t
JOIN 
    Conta c ON t.num_conta = c.num_conta
WHERE 
    c.tipo_conta = 'conta-corrente'
    AND t.data_hora >= NOW() - INTERVAL 7 DAY
GROUP BY 
    t.num_conta
ORDER BY 
    num_transacoes DESC;

# ultimos 30 dias
SELECT 
    t.num_conta,
    COUNT(t.num_transacao) AS num_transacoes
FROM 
    Transacao t
JOIN 
    Conta c ON t.num_conta = c.num_conta
WHERE 
    c.tipo_conta = 'conta-corrente'
    AND t.data_hora >= NOW() - INTERVAL 30 DAY
GROUP BY 
    t.num_conta
ORDER BY 
    num_transacoes DESC;
    
# ultimos 365 dias
SELECT 
    t.num_conta,
    COUNT(t.num_transacao) AS num_transacoes
FROM 
    Transacao t
JOIN 
    Conta c ON t.num_conta = c.num_conta
WHERE 
    c.tipo_conta = 'conta-corrente'
    AND t.data_hora >= NOW() - INTERVAL 365 DAY
GROUP BY 
    t.num_conta
ORDER BY 
    num_transacoes DESC;
    
# 1.6
# ultimos 7 dias
SELECT 
    t.num_conta,
    SUM(t.valor_transacao) AS volume_movimentacoes
FROM 
    Transacao t
WHERE 
    t.data_hora >= NOW() - INTERVAL 7 DAY
GROUP BY 
    t.num_conta
ORDER BY 
    volume_movimentacoes DESC;
    
# ultimos 30 dias
SELECT 
    t.num_conta,
    SUM(t.valor_transacao) AS volume_movimentacoes
FROM 
    Transacao t
WHERE 
    t.data_hora >= NOW() - INTERVAL 30 DAY
GROUP BY 
    t.num_conta
ORDER BY 
    volume_movimentacoes DESC;
    
# ultimos 365 dias
SELECT 
    t.num_conta,
    SUM(t.valor_transacao) AS volume_movimentacoes
FROM 
    Transacao t
WHERE 
    t.data_hora >= NOW() - INTERVAL 365 DAY
GROUP BY 
    t.num_conta
ORDER BY 
    volume_movimentacoes DESC;