#Variaveis para execução da massa de testes:

v_FirstName = Faker::Name.first_name
v_LastName = Faker::Name.last_name
v_email = Faker::Internet.email
v_Senha = Faker::Internet.password(min_length: 8, max_length: 16, mix_case: true)
v_Trigger_Mensagem_Retorno = 0

#Acessa url de cadastro
Given("que estou em {string}") do |url|
  visit url
  sleep 1
  page.driver.browser.manage.window.maximize
end

When("preencho os campos com dados validos respeitando as máscaras de dados do campo e-mail e senha") do

  #Cenario 1, cadastro é efetuado com sucesso

  find("input[id=firstname]").set v_FirstName
  sleep 1
  find("input[id=lastname]").set v_LastName
  sleep 1
  find("input[id=email_address]").set v_email
  sleep 1
  find("input[id=password]").set v_Senha
  sleep 1
  find("input[id=password-confirmation]").set v_Senha
  sleep 1
end

When("realizo o envio do formulario") do
  sleep 2
  find(:xpath, "(//*[@class='action submit primary' ][@title='Create an Account'])").click
  sleep 5
end

Then("meu usuario sera criado e devo ser direcionado a pagina de minha conta") do
  expect(page).to have_content("My Account")
end

When("preencho o campo senha com uma senha que nao se adequa ao tamanho minimo E nao possui ao menos tres dos seguintes elementos um caractere em Uppercase, Lowercase, caractere especial, dígito, como {string}") do |senha_invalida|

  #Cenario 2, formulario é preenchido com senha inválida por estrutura

  v_Senha = Faker::Internet.password(min_length: 6, max_length: 18, mix_case: false, special_characters: false)

  #preenchimento dos campos

  find("input[id=firstname]").set v_FirstName
  sleep 1
  find("input[id=lastname]").set v_LastName
  sleep 1
  find("input[id=email_address]").set v_email
  sleep 1
  find("input[id=password]").set v_Senha
  sleep 1
  find("input[id=password-confirmation]").set v_Senha
  sleep 1
  v_Trigger_Mensagem_Retorno = 2 #seta condição de retorno para o step entender qual cenário foi utilizado e realizar a validação da frase esperada de acordo
end

Then("uma mensagem de alerta deve ser exibida") do

  #Step que captura a mensagem de erro esperada de acordo com o cenário executado, para tal utiliza uma variavel para "chavear" a ação do step

  #o cenario é o unico com 2 possibilidades de mensagens a ser validadas:

  #campo senha com uma senha que nao se adequa ao tamanho minimo E nao possui ao menos tres dos seguintes elementos um caractere em Uppercase, Lowercase, caractere especial, dígito, como "nhg"

  #há duas possibilidades, a qyabtudade de caracteres é inferior a 8 e/ou a senha não possui um minimo de 3 caracteres entre: Lower case, Upper case, digitos, caracteres especiais

  if v_Trigger_Mensagem_Retorno == 2
    if page.has_content?("Minimum of different classes of characters in password is 3. Classes of characters: Lower Case, Upper Case, Digits, Special Characters.")
    else
      expect(page).to have_content("Minimum length of this field must be equal or greater than 8 symbols. Leading and trailing spaces will be ignored.")
    end
  end
  #demais cenarios:

  #cenario 3: preencho o campo Confirme a Senha com um valor diferente do valor digitado no campo senha

  if v_Trigger_Mensagem_Retorno == 3
    expect(page).to have_content("Please enter the same value again.")
  end

  #Cenario 4: preencho o campo E-mail sem informar o dominio

  if v_Trigger_Mensagem_Retorno == 4
    expect(page).to have_content("Please enter a valid email address (Ex: johndoe@domain.com).")
  end

  #Cenario 5: deixo de preencher um ou mais campos obrigatórios

  if v_Trigger_Mensagem_Retorno == 5
    expect(page).to have_content("This is a required field.")
  end
end

When("preencho o campo senha com {string}") do |senha_valida|

  #Preencho campo de senha no formulario com senha "X"

  find("input[id=firstname]").set v_FirstName
  sleep 1
  find("input[id=lastname]").set v_LastName
  sleep 1
  find("input[id=email_address]").set v_email
  sleep 1
  find("input[id=password]").set senha_valida
  sleep 1
end

#em seguida preencho campo de confirmação de senha no formulária com um valor "Y" diferente do valor inserido anteriormente

When("preencho o campo Confirme a Senha com um valor diferente {string}") do |senha_diferente|
  find("input[id=password-confirmation]").set senha_diferente
  v_Trigger_Mensagem_Retorno = 3 #seta condição de retorno para o step entender qual cenário foi utilizado e realizar a validação da frase esperada de acordo
end

When("preencho o campo E-mail sem informar o dominio ex {string}") do |email_invalido|

  #Cenario onde espero e-mail invalido

  find("input[id=firstname]").set v_FirstName
  sleep 1
  find("input[id=lastname]").set v_LastName
  sleep 1
  find("input[id=email_address]").set email_invalido
  sleep 1
  find("input[id=password]").set v_Senha
  sleep 1
  find("input[id=password-confirmation]").set v_Senha
  sleep 1

  v_Trigger_Mensagem_Retorno = 4 #seta condição de retorno para o step entender qual cenário foi utilizado e realizar a validação da frase esperada de acordo
end

When("deixo de preencher um ou mais campos") do

  #Cenario onde espero obter campos vazios, preencho somente estes 2

  find("input[id=lastname]").set v_LastName
  sleep 1
  find("input[id=email_address]").set v_email
  sleep 1
  v_Trigger_Mensagem_Retorno = 5 #seta condição de retorno para o step entender qual cenário foi utilizado e realizar a validação da frase esperada de acordo
end
