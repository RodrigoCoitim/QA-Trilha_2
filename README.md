# QA-Trilha_2
Atividades referentes a trilha 2 da Academia WebJump voltada a area de qualidade (QA)

Desenvolvido utilizando as ferramentas:
Windows 10 (64-bits)
Ruby 2.7.2p137
Cucumber 5.2.0
Firefox 85.0.2 (64-bits)

O objetivo do projeto é automatizar os procedimentos de criação de conta, login e fluxo de compra em um site de testes no modelo e-commerce.

Foi utilizado escrita em BDD para os cenários de testes em conjunto com implementação do cucumber.


Instalação:

Caso já possua  Ruby na versão 2.7.2p137 ou superior instalado, abra um terminal de sua preferência e instale o bundler ao executar a seguinte linha de comando no diretório raíz do projeto:

gem install bundler -v 2.2.4

após a instalação, o bundler devera ser executado para que o mesmo instale todas as gems necessárias para o projeto, execute o comando:

bundle install

este comando deve instalar as bibliotecas necessárias para executar o projeto.

Para executar os testes, insira o comando no terminal:

cucumber

E caso deseje executar um cenário especifico isoladamente, adiciona a tag a linha de comando anterior, por exemplo:

cucumber -t @Cenario_1
