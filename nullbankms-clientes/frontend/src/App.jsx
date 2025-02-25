import React from 'react'
import { BrowserRouter, Routes, Route } from 'react-router-dom'
import 'bootstrap/dist/css/bootstrap.min.css'
import Home from './Home'
import Create from './Create'

function App() {
	return (
		// Utilizando da bilbiotecas Router para definir as rotas com as funções epecíficas de cada componente (Inserir, Visualizar, Atualizar e Deletar)
		<BrowserRouter>
			<Routes>
				<Route path='/' element={<Home />} />
				<Route path='/create' element={<Create />} />
			</Routes>
		</BrowserRouter>
	)
}

export default App


// v1 -> 8:20
// <Route path='/read/:id' element={<Read />} />