# Gestor de Campanhas de Desconto







## Visão Geral

O Gestor de Campanhas de Desconto é uma aplicação web desenvolvida em Ruby on Rails que permite criar, gerenciar e monitorar campanhas de desconto em produtos. Integrada à API da Fake Store, a aplicação lista produtos disponíveis e oferece ferramentas para definir descontos personalizados, rastrear alterações e visualizar históricos detalhados.

## Funcionalidades Principais

1. **Listagem de Produtos**
   - Integração com API da Fake Store para obter informações detalhadas dos produtos.

2. **Criação de Descontos**
   - Interface intuitiva para definir descontos em produtos, com opções de porcentagem ou valor fixo.

3. **Visualização de Campanhas**
   - Exibe detalhes completos de cada campanha, incluindo foto do produto,Descriçao, preço original, preço com desconto aplicado, status (ativo, expirado), datas de início e término.
   - Histórico de alterações registra todas as modificações feitas nas campanhas, proporcionando transparência e rastreabilidade.

4. **Persistência de Dados**
   - Utiliza PostgreSQL como banco de dados relacional para assegurar a consistência e segurança dos dados.

5. **Status dos Descontos**
   - Permite definir e visualizar o status atual de cada desconto (ativo, expirado).

6. **Histórico de Descontos**
   - Registra todas as mudanças realizadas nos descontos, incluindo quem fez a alteração e quando.

## Tecnologias Utilizadas

- **Framework**: Ruby on Rails
- **ORM**: Active Record
- **Frontend**: Bootstrap para uma interface moderna e responsiva.

## Gems Utilizadas

- **Autenticação**: devise
- **Testes**: rspec-rails, capybara, factory_bot_rails, database_cleaner-active_record,rails-controller-testing,faker
- **Integração com APIs**: httparty
- **Auditoria de Alterações**: paper_trail para versionamento de registros
- **Paginação**: will_paginate para navegação por páginas

## Estrutura do Banco de Dados

### Tabelas Principais

1. **products**
   - Armazena informações dos produtos obtidos da API da Fake Store.

   | Coluna       | Tipo         | Descrição                            |
   |--------------|--------------|--------------------------------------|
   | name         | string       | Nome do produto                      |
   | price        | float        | Preço do produto                     |
   | description  | string       | Descrição detalhada do produto       |

2. **campaigns**
   - Gerencia as campanhas de desconto.

   | Coluna            | Tipo          | Descrição                             |
   |-------------------|---------------|---------------------------------------|
   | title             | string        | Título da campanha                    |
   | description       | text          | Descrição detalhada da campanha       |
   | start_date        | date          | Data de início da campanha            |
   | end_date          | date          | Data de término da campanha           |
   | product_id        | bigint        | Referência ao produto da campanha     |
   | user_id           | bigint        | ID do usuário criador da campanha     |
   | discounted_price  | float         | Preço com desconto aplicado           |
   | status            | integer       | Status da campanha (ativo, expirado)  |
   | created_by        | string        | Nome do criador da campanha           |

3. **discounts**
   - Detalhes específicos dos descontos aplicados.

   | Coluna              | Tipo          | Descrição                             |
   |---------------------|---------------|---------------------------------------|
   | discount_type       | string        | Tipo de desconto (porcentagem, fixo)   |
   | discount_value      | float         | Valor do desconto                     |
   | status              | integer       | Status do desconto (ativo, expirado)  |
   | applied_by          | integer       | ID do usuário que aplicou o desconto  |
   | applied_at          | datetime      | Data e hora da aplicação do desconto  |
   | activation_date     | date          | Data de ativação do desconto          |
   | deactivation_date   | date          | Data de desativação do desconto       |

4. **users**
   - Informações de usuários para autenticação.

   | Coluna              | Tipo          | Descrição                             |
   |---------------------|---------------|---------------------------------------|
   | email               | string        | Email do usuário                      |
   | encrypted_password  | string        | Senha criptografada do usuário        |
   | name                | string        | Nome completo do usuário              |

5. **campaign_histories**
   - Histórico detalhado das alterações nas campanhas.

   | Coluna         | Tipo          | Descrição                                 |
   |----------------|---------------|-------------------------------------------|
   | campaign_id    | bigint        | Referência à campanha                      |
   | user_id        | bigint        | ID do usuário responsável pela alteração   |
   | status         | integer       | Novo status da campanha                    |
   | data_hora      | datetime      | Data e hora da alteração                   |

### Tabelas de Suporte

- **active_storage_attachments, active_storage_blobs**: Gerenciamento de uploads de arquivos.
- **versions**: Registra versões dos registros para auditoria de dados.

## Instruções de Instalação
# Clonar o Repositório

Para iniciar, clone o repositório do projeto para seu ambiente local usando o seguinte comando:

git clone https://github.com/RaquelFonsec/cresce_cuts_ror_pleno_junho_2024.git

# Instalação das Dependências

Navegue até o diretório do projeto clonado:

cd cresce_cuts_ror_pleno_junho_2024

Instale as dependências do projeto usando Bundler:

bundle install

# Configuração do Banco de Dados

Execute as migrações para configurar o banco de dados:

rails db:migrate
 rails db:seed

 
Inicie o servidor Rails localmente:

rails server

Abra um navegador e acesse o seguinte URL:

http://localhost:3000

# Credenciais de Login

Utilize as seguintes credenciais para fazer login no aplicativo:

Email: raque-leto@hotmail.com
Senha: 123456

# Uso do Aplicativo

Após iniciar o servidor e acessar o aplicativo no navegador, você poderá:

- Visualizar campanhas existentes acessando:
  http://localhost:3000/campaigns

- Criar novas campanhas clicando no botão "Criar nova campanha".

- Editar campanhas existentes usando o botão de edição disponível para cada campanha listada.

**Histórico de alterações nos descontos**: O sistema mantém um registro detalhado de todas as mudanças nos descontos. Isso inclui o momento da criação da campanha, bem como todas as edições subsequentes feitas no desconto aplicado, como ajustes de preço, datas, entre outros detalhes.

Se você encontrou algum problema ou deseja contribuir com melhorias, sinta-se à vontade para enviar um pull request . Agradecemos sua colaboração em tornar este aplicativo ainda melhor para todos!

Para mais informações ou suporte adicional, entre em contato através do email [raque-leto@hotmail.com]
 
