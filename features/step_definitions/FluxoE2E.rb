#Variaveis para execução da massa de testes, o login e senha são padrão (mockado) por definição dos testes

v_email = "rodrigo.teste2@mailinator.com"
v_Senha = "Vc9cetgu.al"
v_Rua = Faker::Address.street_address
v_Cidade = Faker::Address.city
v_Postal = Faker::Address.postcode
v_Phone = Faker::PhoneNumber.phone_number

#Cenario_Login

Given("Que já possuo conta, mas não estou logado e estou em {string}") do |link|
  visit link
  sleep 1
  page.driver.browser.manage.window.maximize
end

When("Inserir minhas credenciais e clicar em logar") do
  find("input[id=email]").set v_email
  find("input[id=pass]").set v_Senha
  sleep 5
  find("button[id=send2]").click
  sleep 5
end

Then("Devo ser contemplado com uma mensagem de boas-vindas no header da pagina") do
  expect(page).to have_content("Rodrigo")
end

#Cenario_Fluxo

Given("que estou logado com um usuario especifico que já possui endereço cadastrado em {string}") do |link|
  #realiza login novamente, assim o cenário pode ser executado apartado do cenário de login

  visit link
  sleep 1
  page.driver.browser.manage.window.maximize
  sleep 5
  find("input[id=email]").set v_email
  find("input[id=pass]").set v_Senha
  sleep 2
  find("button[id=send2]").click
  sleep 5
  expect(page).to have_content("Rodrigo")
end

When("Busco por um produto e adiciono-o ao meu carrinho") do
  sleep 2
  find("input[id=search]").set "product" #insere no campo de busca os dizeres "product" na barra de pesquisa
  sleep 1
  find("button[title=Search]").click #clica no botão para buscar
  sleep 1
  first("a[Class=product-item-link]").click #seleciona um dado resultado da busca

  #find(:xpath, "(//button[@title='Add to Cart'])[1]").hover.click
  sleep 3
  find("button[id=product-addtocart-button]").click #adiciona o item ao carrinho
  sleep 3
  visit "https://magento.nublue.co.uk/checkout/" #navega para a tela de checkout
  sleep 2
end

When("Prossigo para tela de checkout e escolho um método de pagamento para finalizacao da comprar") do
  if page.has_content?("New Address")
    #confirmou que há um endereço cadastrado

    sleep 3
    find("input[value=flatrate_flatrate]").click #acha a opção de frete e selecion
    sleep 5
    find("button[data-role='opc-continue']").click #acha o botão next e clica
  else
    #cadastra um endereço para prosseguir com checkout
    sleep 1
    find(:xpath, "(//*[@class='input-text' ][@name='street[0]'])").set v_Rua #acha e digita no campo rua
    sleep 1
    find(:xpath, "(//*[@class='input-text' ][@name='city'])").set v_Cidade #acha e digita no campo cidade
    sleep 1
    find(:xpath, "(//*[@class='input-text' ][@name='postcode'])").set v_Postal #acha e digita no campo codigo postal
    sleep 1
    find(:xpath, "(//*[@class='input-text' ][@name='telephone'])").set v_Phone #acha e digita no campo telefone
    sleep 1
    find(:xpath, "(//*[@class='select' ][@name='region_id'])").select :Alaska #acha e seta o campo Estado/Provincia
    sleep 1
    find(:xpath, "(//*[@class='select' ][@name='country_id'])").select :Afghanistan #acha e seta o campo País
    sleep 1
    find(:xpath, "(//*[@class='radio' ][@value='flatrate_flatrate'])").click #acha a opção de frete e seleciona
    sleep 1
    find(:xpath, "(//*[@class='button action continue primary'])").click #acha o botão next e clica
  end
  sleep 10

  find("div[class=primary]").click #finaliza e gera um pedido ao clicar em "Place Order"

  sleep 5
end

Then("Devo ser contemplado com a mensagem correspondente a sucesso na finalizacao do pedido") do
  sleep 5
  expect(page).to have_content("Thank you for your purchase!") #mensagem esperada ao final do pedido gerado
end
