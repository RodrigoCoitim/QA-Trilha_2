Feature: Fluxo E2E

    Para que eu possa comprar produtos na loja
    Sendo um usuario com perfil já criado
    Preciso me logar, navegar pelo site e comprar um produto qualquer

    @Cenario_Login
    Scenario: Login

        Given Que já possuo conta, mas não estou logado e estou em "https://magento.nublue.co.uk/customer/account/login"
        When Inserir minhas credenciais e clicar em logar
        Then Devo ser contemplado com uma mensagem de boas-vindas no header da pagina


    @Cenario_Fluxo
    Scenario: Fluxo

        Given que estou logado com um usuario especifico que já possui endereço cadastrado em "https://magento.nublue.co.uk/customer/account/login"
        When Busco por um produto e adiciono-o ao meu carrinho
        And Prossigo para tela de checkout e escolho um método de pagamento para finalizacao da comprar
        Then Devo ser contemplado com a mensagem correspondente a sucesso na finalizacao do pedido