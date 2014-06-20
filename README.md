# Legislative: A Monitoring Platform
[![Build Status](https://travis-ci.org/ciudadanointeligente/legislative.png?branch=master)](https://travis-ci.org/ciudadanointeligente/legislative)
[![Coverage Status](https://coveralls.io/repos/ciudadanointeligente/legislative/badge.png)](https://coveralls.io/r/ciudadanointeligente/legislative)
[![Code Climate](https://codeclimate.com/github/ciudadanointeligente/legislative.png)](https://codeclimate.com/github/ciudadanointeligente/legislative)

[Trunk](http://beta.congresoabierto.cl)

Legislative is a channel of participation and seeks to bring information to the public what is happening to our Congress. Built using POPLUS environment.

## Dependencies

Make sure you're using ruby 2.0 or above (we highly recommend using [rvm](http://rvm.io/)), and that [bundler](http://bundler.io/) is installed.

Legislative uses the following Poplus components: [Pop-it](http://popit.poplus.org/), [Write-it](http://writeit.poplus.org/) and [Bill-it](github.com/ciudadanointeligente/bill-it). You should create an instance of the services, or have your own installation in order for all features to be available.

## System requirements

The following system requirements are also needed, for image manipulation:

Red Hat / Fedora / CentOS

    sudo yum install ImageMagick-devel

Debian / Ubuntu (for 13.04 and Wheezy also install `libmagickwand-dev`)

    sudo apt-get install imagemagick libmagickwand-dev

Ubuntu (14.04) need install sqlite3 and sqlite3-dev

    sudo apt-get install sqlite3 sqlite3-dev

OS X

    brew update
    brew install ImageMagick
    gem install rmagick

## Quick start

Clone the git repo - `git clone https://github.com/ciudadanointeligente/legislative.git` - or [download it](https://github.com/ciudadanointeligente/legislative/zipball/master)

Go to your legislative folder and run install

    sh setup.sh

Install the required ruby gems

    bundle install

Create the config files

    cp config/database.yml.example config/database.yml

Then run your server

    rails s

Check at [http://localhost:3000](http://localhost:3000)

You can try loggin in with `admin@ciudadanointeligente.org / benito`

### Bill-it

Legislative need you have an instances of Bill-it for store all yours bills, for more information visits [Github Bill-it page](https://github.com/ciudadanointeligente/bill-it/)

### Pop-it

Legislative need you have an instance of Popit for store your congressmen personal data, for more information please visits [Github Project Page](https://github.com/mysociety/popit/) or [Popit website](http://popit.poplus.org/)

### Enable / Disable Display Agenda

in Chile, an Agenda is the roadmap of a congressman when works out of the congress, 
then, the agenda is a recopilation of what are they doing in is own District that represent.
for default the config of display this section is disabled and if you wanna enable this one, only need add the following 
line on your private_legislative.yml with the url pointing to an API, like [Morph.io](http://morph.io/), to consume this information
if you dont use Morph.io just forget the line 'morph_io_api_key'

    morph_io_api_key: ~
    agendas_url: ~
    agendas_enabled: ~

the API response need an Array of bills, [here is an example](https://api.morph.io/ciudadanointeligente/pmocl-agendas/data.json?key=YOUR_API_KEY&query=select%20*%20from%20%27data%27)

### Picture profile of a congressman

if you need adjust the crop size of the thumbnails, only need setup a few values on private_legislative.yml
adding the following values

    congressman_pic_x: '15'
    congressman_pic_y: '15'
    congressman_pic_w: '160'
    congressman_pic_h: '150'

for default the values are: 15,15,160,150 wich represents x, y, width and heigth


### Deploying to production

This section will not be relevant to most people. It will however be relevant if you're deploying to a production server.

#### Production environment

Create the follow config files, and edit them with your project's specific values.

    cp config/newrelic.yml.example config/newrelic.yml
    cp config/schedule.rb.example config/schedule.rb
    cp config/private_legislative.yml.example config/private_legislative.yml

The private_legislative.yml is the file that holds all your private config values. While legislative.yml gets synced to your github repo, private_legislativeyml does not.

#### Deploy

We recommend the follow commands in the job for automatic deploy and the use of [phusion passenger](https://www.phusionpassenger.com/) as web server and application server with apache or nginx in production.

    bundle install
    rake db:migrate
    rake tmp:cache:clear
    rake assets:clean
    rake assets:precompile

#### Tasks using cron

To run tasks like send notifications emails of changes in bills the project use [whenever](https://github.com/javan/whenever), this tool generate cron jobs from the `config/schedule.rb` file.

Add the jobs to crontab:

    bundle exec whenever --update-crontab legislative

Clear the jobs associated with a app name:

    bundle exec whenever --clear-crontab legislative

#### MariaDB

For improve the performance in production is a good idea change the db engine from sqlite3 to mariaDB or postgreSQL. To use mariaDB you need edit `config/database.yml` config file.

Red Hat / Fedora / CentOS

    yum install mariadb-server mariadb-devel

Debian / Ubuntu

    apt-get install mariadb-server libmariadbd-dev

OS X

    brew install mariadb

## Features

##### [HTML5 Boilerplate](https://github.com/h5bp/html5-boilerplate/)

##### [Twitter Bootstrap 3](http://twitter.github.com/bootstrap/index.html)

##### [HAML Template Engine](http://haml.info/)

##### [Ruby on Rails 4.0.0](http://rubyonrails.org/)
* Security Authentication system
* Remember me
* Users CRUD


### Databases support

* SQLite (Default)
* MySQL / MariaDB

### Best practices
---
Change the cookie secret token at
`config/initializers/secret_token.rb`
<pre>
# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Legislative::Application.config.secret_token = 'YOUR-NEW-TOKEN-HERE'
</pre>

To run the RSpec tests
<pre>
rspec
</pre>


#### Todo
---

* You can found this in the [Issues page](https://github.com/ciudadanointeligente/legislative/issues).

## License

### Major components:

* jQuery: MIT/GPL license
* Modernizr: MIT/BSD license
* Normalize.css: Public Domain
* Twitter bootstrap: [Apache License, Version 2.0 (the "License")](http://www.apache.org/licenses/LICENSE-2.0)
* Ruby on Rails: MIT license
* RailStrap scripts: Public Domain

## Does Legislative have a mascot?

Yes.

[![Benito](http://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-ash3/1098148_10151780926822943_1641758220_n.jpg "Legislative's mascot: Benito")](https://www.google.com/search?site=&tbm=isch&source=hp&biw=1263&bih=630&q=perros+adorables+de+chile)


## Thanks you!

Legislative is made possible by the continued contributions and insights from kind-hearted developers everywhere. Just to name a few:

* [@rezzo](https://github.com/rezzo)
* [@maugsbur](https://github.com/maugsbur)
* [@jdgarrido](https://github.com/jdgarrido)
* [@pdaire](https://github.com/pdaire)
* [@lfalvarez](https://github.com/lfalvarez)
* [@kathemalis](https://github.com/kathemalis)
* [@CamiloG](https://github.com/CamiloG)
* [@camargozzini](https://github.com/camargozzini)
* [@melizeche](https://github.com/melizeche)
* [@martinszy](https://github.com/martinszy)


This project is licensed under the GNU Affero General Public License (AGPL). For more information you can access to the [digital license edition here](http://www.gnu.org/licenses/agpl-3.0.html).

### Everything else:

For more information about us, our site [Fundación Ciudadano Inteligente](http://www.ciudadanointeligente.org/).
And if you want help with patches, report bugs or replicate our project check [our repositories](https://github.com/ciudadanointeligente/).
