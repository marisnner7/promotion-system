# Sistema de Promoções 
Plataforma de gerenciamento de promoções e cupons de desconto.

Aplicação pode ser visitada em: 
```bash
https://promo-sys.herokuapp.com
```

## Features
  Somente usuários autenticados podem criar promoções e cupons de descontos. Promoção para ser valida, precisa ser aprovada por outro adm logado. Promoções podem ser deletadas por outros adm logados. Categorias de produtos pode ser feito CRUD, e promoções devem ser atreladas a isso. Cupons podem ser emitidos, atrelado a uma promoção e API disponibilizada para consumo de cupons. 
  Cupons podem ser manualmente ativados ou desativados. 

## Docker
  Depois de clonar você pode navegar pela aplicação localmente em um container.

```bash
$ git clone git@qsd.campuscode.com.br:marisnner7/promotion_system_v2.git
$ cd promotion_system_v2
$ docker-compose build 
$ docker-compose run --service-ports rails bash
```

Dentro do container: 
```bash
$ bin/setup
$ rspec
$ rails s -b 0.0.0.0
```
Visite a aplicação localmente em localhost:3000

## Instalação
  Para clonar essa aplicação e rodar localmente, você precisará: [Git](https://git-scm.com), <b>Ruby '2.7.2' </b>, <b>Rails'~> 6.1.1' </b> and for Datebase <b> PostgreSql</b>. 

```bash
# Clone this repository
$ git clone git@qsd.campuscode.com.br:marisnner7/promotion_system_v2.git

# Go into the repository
$ cd promotion-system

# Install dependencies
$ bin/setup

#  Create,migrate and seed the DEV_database
$ rails db:setup

# Testing with rspec
$ rspec

# Run the app
$ rails s
```
Visite localmente em localhost:3000

## Algumas Gem's usadas:
Some Gem's used: devise, faker, simple_form, font-awesome, rspec, rubocop, factory_bot, capybara, simplecov

## Corbetura de testes: 
  Simple_COV
  All Files ( 98.68% covered)
 
## Contribuindo
Pull requests (merge requests) são bem vindos. Para grandes mudanças, por favor abra uma issue primeiro para uma discursão sobre o que você gostaria de modificar. Por favor garanta que os testes cubram a mudança.
