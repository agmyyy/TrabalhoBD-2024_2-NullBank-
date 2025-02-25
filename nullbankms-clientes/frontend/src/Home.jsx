import React from 'react'
import { useState, useEffect } from 'react'
import axios from 'axios'
import { Link } from 'react-router-dom';
import "./style.css"

function Home() {
	// objeto do tipo map() para armazenar as informações vindas da requisição ao banco
	const [data, setData] = useState([]);
	useEffect(() => {
		axios.get('http://localhost:8081/') // enderenço do servidor do backend (Node)
			.then(res => setData(res.data))
			.catch(err => console.log(err));
	}, [])

	// corpo da tabela com as informações dos Clientes
	return (
		<div className='d-flex vh-100 justify-content-center align-items-center loginForm'>
			<div className='w-90 bg-white rounded p-3'>
				<h2>Clientes Registrados</h2>
				<div className='d-flex justify-content-end'>
					<Link to='/create' className='btn btn-success'>Create +</Link>
				</div>
				<table className='table'>
					<thead>
						<tr>
							<th>CPF</th>
							<th>Nome</th>
							<th>RG</th>
							<th>UF</th>
							<th>Orgao Emissor</th>
							<th>Endereco</th>
							<th>Data de Nascimento</th>
						</tr>
					</thead>
					<tbody>
						{data.map((clients, index) => {
							return <tr key={index}>
								<td>{clients.cpf}</td>
								<td>{clients.nome_dependente}</td>
								<td>{clients.RG}</td>
								<td>{clients.UF}</td>
								<td>{clients.orgao_emissor}</td>
								<td>{clients.endereco}</td>
								<td>{clients.data_nascimento}</td>
								<td>
									<button className='btn btn-sm btn-primary mx-2'>Edit</button>
									<button className='btn btn-sm btn-danger'>Delete</button>
								</td>
							</tr>
						})}
					</tbody>
				</table>
			</div>
		</div>
	)
}

export default Home


// <Link to={`/read/${clients.cpf}`} className='btn btn-sm btn-info'>Read</Link>