# Cabildo Abierto

## Descripción

Canal de participación y de información que busca acercar al ciudadano lo que sucede en nuestro Congreso Nacional. Construido haciendo uso del ambiente POPLUS.

## Instalación

La máquina requiere contar, en sistema, con un intérprete de JavaScript. Por ejemplo V8, o el paquete de Node.js que lo incluye.

    sudo apt-get install nodejs

A continuación instalar las gemas requeridas por el proyecto.

    bundle install --path=vendor/gems

## Tests

    bundle exec rspec

## Ejecución

    bundle exec rails s
