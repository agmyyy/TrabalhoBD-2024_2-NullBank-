import express from 'express';
import mysql from 'mysql2';
import cors from 'cors';
import config from './config.js';

// Declaração das Variaveis de Importação
const app = express();
app.use(cors());
app.use(express.json());

// Conexão com o banco de dados MySQL
const db = mysql.createConnection({
    // host: 'localhost',
    // port: 3306,
    // user: 'root',
    // password: '@admin',
    // database: 'teste-bd'
    host: config.database.host,
    port: config.database.port,
    user: config.database.user,
    password: config.database.password,
    database: config.database.database
});



// Rota para listar Clientes
app.get('/', (req, res) => {
    const sql = "SELECT * FROM `Clientes`";
    db.query(sql, (err, result) => {
        if (err) return res.json({ Message: "Erro inside server" });
        return res.json(result);
    });
});



// função para formatar a data
const formatarData = (data) => {
    const partes = data.split('-'); // Divide a string pelo "-"
    return `${partes[2]}-${partes[1]}-${partes[0]}`; // Reorganiza para YYYY-MM-DD
};

// Rota para inserir Clientes
app.post('/create', (req, res) => {
    const sql = "INSERT INTO `Clientes` (cpf, `nome_dependente`, `RG`, `UF`, `orgao_emissor`, `endereco`, `data_nascimento`) VALUES (?, ?, ?, ?, ?, ?, ?)";
    
    const values = [
        req.body.cpf,
        req.body.nome_dependente,
        req.body.RG,
        req.body.UF,
        req.body.orgao_emissor,
        req.body.endereco,
        formatarData(req.body.data_nascimento)
    ];

    db.query(sql, values, (err, result) => {
        if (err) {
            console.error("Erro ao inserir:", err);
            return res.json({ error: "Erro ao inserir usuário", details: err });
        }
        console.log("Usuário inserido com sucesso:", result);
        return res.json({ message: "Usuário inserido com sucesso!", result });
    });
});

// Inicialização do Node para o BackEnd
app.listen(8081, () => {
    console.log('Listening');
});