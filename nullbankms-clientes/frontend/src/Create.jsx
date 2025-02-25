import axios from 'axios';
import React from 'react'
import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom';
import "./style.css"

function Create() {

    // objeto do tipo map() para armazenar as informações do formulário
    const [values, setValues] = useState({
        cpf: '',
        nome_dependente: '',
        RG: '',
        UF: '',
        orgao_emissor: '',
        endereco: '',
        data_nascimento: ''
    })
    const navigate = useNavigate();
    
    // função para submeter as informações do formulario para a querry SQL
    const handleSubmit = (e) => {
        e.preventDefault();
        console.log("Enviando:", values);  // Verificar se os valores estão corretos
        axios.post('http://localhost:8081/create', values)
        .then(res => {
            console.log(res);
            navigate('/');
        })
        .catch(err => console.log(err))
    }

    return (

    // corpo do Furmulário
    <div className='d-flex vh-100 justify-content-center align-items-center loginForm'>
        <div className='w-50 bg-white rounded p-3'>
            <form onSubmit={handleSubmit}>
                <h2>Adicionar Novo Cliente</h2>
                <div>
                    <label htmlFor=''>CPF</label>
                    <input type='text' placeholder='Digite o CPF' className='form-control' 
                    onChange={e => setValues({...values, cpf: e.target.value})}/>
                </div>
                <div className='mb-2'>
                    <label htmlFor=''>Nome</label>
                    <input type='text' placeholder='Digite o nome' className='form-control'
                    onChange={e => setValues({...values, nome_dependente: e.target.value})}/>
                </div>
                <div className='mb-2'>
                    <label htmlFor=''>RG</label>
                    <input type='text' placeholder='Digite o RG' className='form-control'
                    onChange={e => setValues({...values, RG: e.target.value})}/>
                </div>
                <div className='mb-2'>
                    <label htmlFor=''>UF</label>
                    <input type='text' placeholder='Digite a UF do estado' className='form-control'
                    onChange={e => setValues({...values, UF: e.target.value})}/>
                </div>
                <div className='mb-2'>
                    <label htmlFor=''>Orgão Emissor</label>
                    <input type='text' placeholder='Digite o código do orgão emissor' className='form-control'
                    onChange={e => setValues({...values, orgao_emissor: e.target.value})}/>
                </div>
                <div className='mb-2'>
                    <label htmlFor=''>Endereço</label>
                    <input type='text' placeholder='Digite o endereço' className='form-control'
                    onChange={e => setValues({...values, endereco: e.target.value})}/>
                </div>
                <div className='mb-2'>
                    <label htmlFor=''>Data de Nascimento</label>
                    <input type='text' placeholder='Digite a data de nascimento' className='form-control'
                    onChange={e => setValues({...values, data_nascimento: e.target.value})}/>
                </div>
                <button className='btn btn-success'>Submit</button>
            </form>
        </div>
    </div>
  )
}

export default Create