Gestor de Campanhas de Desconto

Este é um aplicativo web desenvolvido em Ruby on Rails para gerenciar campanhas de desconto em produtos. Ele utiliza a API da Fake Store para listar os produtos disponíveis.

Funcionalidades

Listagem de Produtos: Um aplicativo integrado à API da Fake Store para listar os produtos disponíveis.

Criação de Descontos: Interface para gerenciamento de descontos em produtos específicos, permitindo a definição de descontos do tipo "porcentagem/fixo".

Visualização de Campanhas: Permite visualizar e editar campanhas de desconto criadas, exibindo o preço original e o preço com desconto.

Persistência de Dados: As campanhas de desconto são salvas em um banco de dados relacional para persistência entre as sessões.

Status dos Descontos: Implementa funcionalidades para definir e visualizar o status dos descontos, como ativo, expirado, etc.

Histórico de Descontos: Registra e permite visualizar o histórico de alterações feitas nos descontos, incluindo dados, hora e usuário responsável por cada alteração.



![campanha](/home/raquel/Vídeos/campanha.png)















Requisitos Não Funcionais

Banco de Dados Relacional: Utiliza SQL para persistência de dados.

Framework Rails: Desenvolvido utilizando o framework Ruby on Rails.

Estilização: Bootstrap para estilização.

Testes Unitários: Desenvolvimento de testes unitários Rspec para componentes chave.

Integração com API da Fake Store: Integração com a API da Fake Store para listar produtos.

Para executar este aplicativo localmente, siga estas etapas:

Clone o repositório do projeto para o seu ambiente local utilizando o seguinte comando:

    git clone https://github.com/RaquelFonsec/cresce_cuts_ror_pleno_junho_2024.git

   Após clonar o repositório, siga estas etapas: cd cresce_cuts_ror_pleno_junho_2024

   bundle install
   rails db:migrate
   rails server

   Acesse o aplicativo no navegador em: 
   
   http://localhost:3000
   Utilize as seguintes credenciais para fazer login:


Email: raque-leto@hotmail.com
Senha: 123456
Após fazer login, você pode gerenciar as campanhas de desconto acessando http://127.0.0.1:3000/campaigns. 

Nesta rota, você poderá:

Visualizar todas as campanhas: A lista de campanhas inclui a descrição, o preço original, o preço com desconto e o status.
Editar campanhas existentes: Há um botão de edição para cada campanha que redireciona para a página de edição.
Criar novas campanhas: Há um botão para criar uma nova campanha, que redireciona para a página de criação de campanha.

Se você encontrou este fork interessante e gostaria de contribuir com melhorias, ficaremos felizes em receber suas sugestões e correções. Sinta-se à vontade para enviar um pull request na página do projeto no GitHub. Agradecemos sua colaboração em tornar este fork ainda mais robusto e útil para a comunidade!
