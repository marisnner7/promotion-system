# Sistema de Promoções 
Plataforma de gerenciamento de promoções e cupons de desconto.

Aplicação pode ser visitada em: 
```bash
https://promo-sys.herokuapp.com
```

## Features
  Somente usuários autenticados podem criar promoções e cupons de descontos. Promoção para ser aprovada, precisa ser aprovada por outro adm logado. Promoções podem ser deletadas por outros adm logados. Categorias de produtos pode ser feito CRUD, e devem ser promoções devem ser atreladas a isso. Cupons podem ser emitidos atrelado a uma promoções e API disponibilizada para consumo de cupons. 
  Cupons podem ser manualmente ativados ou desativados. 


## Instalação
  Para clonar essa aplicação e rodar localmente, você precisará: [Git](https://git-scm.com), <b>Ruby '2.7.2' </b>, <b>Rails'~> 6.1.1' </b> and for Datebase <b> PostgreSql</b>. 

```bash
# Clone this repository
$ git clone git@qsd.campuscode.com.br:marisnner7/promotion_system_v2.git

# Go into the repository
$ cd promotion-system

# Install dependencies
$ bundle install

#  Create,migrate and seed the DEV_database
$ rails db:setup


# Testing with rspec
$ rspec

# Run the app
$ rails s
```

## Algumas Gem's usadas:
Some Gem's used: devise, faker, simple_form, font-awesome, rspec, rubocop, factory_bot, capybara, simplecov

## Corbetura de testes: 
  Simple_COV
  All Files ( 98.68% covered)
 
## Contribuindo
Pull requests (merge requests) são bem vindos. Para grandes mudanças, por favor abra uma issue primeiro para uma discursão sobre o que você gostaria de modificar. Por favor garanta que os testes cubram a mudança.
