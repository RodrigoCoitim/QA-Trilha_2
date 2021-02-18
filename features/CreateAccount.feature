Feature: Criacao Conta


    Para que eu possa comprar na loja
    Sendo um usuario devo possuir cadastro e de modo a obter tal
    Preciso me dirigir a pagina de cadastro e preencher o formulario com os meus dados
    
    @Cenario_1
    Scenario: Cadastro efetuado com sucesso

        Given que estou em "https://magento.nublue.co.uk/customer/account/create/"
        When  preencho os campos com dados validos respeitando as máscaras de dados do campo e-mail e senha
        And   realizo o envio do formulario
        Then  meu usuario sera criado e devo ser direcionado a pagina de minha conta

    
    @Cenario_2
    Scenario: Informacao inserida no campo Senha nao atende aos requerimentos minimos

        Given que estou em "https://magento.nublue.co.uk/customer/account/create/"
        When preencho o campo senha com uma senha que nao se adequa ao tamanho minimo E nao possui ao menos tres dos seguintes elementos um caractere em Uppercase, Lowercase, caractere especial, dígito, como "nhg"
        And realizo o envio do formulario
        Then uma mensagem de alerta deve ser exibida

    @Cenario_3
    Scenario: Campo Senha nao confere com campo Confirme a Senha

        Given que estou em "https://magento.nublue.co.uk/customer/account/create/"
        When preencho o campo senha com "Y_32K)c4"
        And  preencho o campo Confirme a Senha com um valor diferente "GivenTake123"
        And  realizo o envio do formulario
        Then uma mensagem de alerta deve ser exibida

    @Cenario_4
    Scenario: Informação inserida no campo E-mail nao atende aos requerimentos

        Given que estou em "https://magento.nublue.co.uk/customer/account/create/"
        When preencho o campo E-mail sem informar o dominio ex "rodrigo.coitim@webjump"
        And  realizo o envio do formulario
        Then uma mensagem de alerta deve ser exibida

    @Cenario_5
    Scenario: um ou mais Campos com informacao faltando

        Given que estou em "https://magento.nublue.co.uk/customer/account/create/"
        When deixo de preencher um ou mais campos
        And  realizo o envio do formulario
        Then uma mensagem de alerta deve ser exibida
