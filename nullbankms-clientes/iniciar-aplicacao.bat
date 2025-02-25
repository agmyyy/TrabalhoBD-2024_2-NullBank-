@echo off
title Inicializando Aplicação Web

:: Inicia o backend (Node.js) e o frontend (React) no mesmo terminal
cd /d backend
echo Iniciando servidor Node.js...
start "Backend" /b cmd /c "npm install && npm start

cd /d ../frontend
echo Iniciando React...
start "Frontend" /b cmd /c "npm install && npm run dev

:: Aguarda o usuário fechar a janela para encerrar os processos
echo.
echo Pressione qualquer tecla para encerrar os servidores...
pause >nul

:: Mata os processos do Node.js e React quando a janela for fechada
taskkill /F /IM node.exe /T
taskkill /F /IM cmd.exe /T
exit
