# WS_Backup - Ferramenta de Backup

O WS_Backup é uma API Rest desenvolvida para facilitar o processo de backup de bancos de dados do cliente para um servidor remoto. A solução é composta por duas partes principais: o `BackupCliente`, que reside no cliente, e o `WS_Backup`, que é a API de destino para receber os backups.

## Características Principais

- **Backup Cliente:** Uma ferramenta localizada no cliente que gerencia o processo de backup do banco de dados e o envia para o servidor remoto.
- **API Rest (WS_Backup):** Uma API Restful desenvolvida com a biblioteca [Horse](https://github.com/HashLoad/horse) da HashLoad, que recebe e gerencia os backups enviados pelos clientes.

## Requisitos

- [Rad Studio 10 Seattle](#) - O projeto foi desenvolvido utilizando esta versão do Rad Studio.
- [Horse](https://github.com/HashLoad/horse) - A biblioteca utilizada para construir a API Rest.

## Como Contribuir

Se deseja contribuir para o projeto, siga estas etapas:

1. Faça um fork do repositório.
2. Crie uma branch para a sua contribuição (`git checkout -b feature/sua-contribuicao`).
3. Faça as alterações desejadas.
4. Faça commit das suas alterações (`git commit -m 'Adiciona nova funcionalidade'`).
5. Envie as alterações para o seu fork (`git push origin feature/sua-contribuicao`).
6. Crie um Pull Request para revisão.

