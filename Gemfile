source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'

# Use Devise for user authentication
gem 'devise', :git => 'git://github.com/plataformatec/devise.git', :ref => '49aebde'

# Database
gem 'sqlite3'

# Template Engine
gem 'haml', '~> 4.0.5'
gem 'haml-rails', '~> 0.5.3', :group => :development

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 3.1.1'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 2.2.2'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# An interface to the ImageMagick and GraphicsMagick image processing libraries
gem 'rmagick'

# Adam Shaw's fullcalendar jquery plugin
gem 'fullcalendar-rails'

# Support to XLS export
gem 'ekuseru'

# Support for localization
gem 'rails-i18n', '~> 4.0.2'
gem 'route_translator', '~> 3.2.4'

# Library to facilitate encoding and decoding of named entities in HTML and XHTML documents
gem 'htmlentities'

# Caching
gem 'actionpack-page_caching', '~> 1.0.2'
gem 'actionpack-action_caching', '~> 1.1.1'

# Clean ruby syntax for writing and deploying cron jobs (for rvm)
gem 'whenever', :git => 'https://github.com/Insomniware/whenever.git', :require => false
#gem 'whenever', :require => false #for non rvm

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'libv8', '~> 3.16.14.7'
gem 'therubyracer', platforms: :ruby

# Monologue is a basic blogging engine
gem 'monologue', github: 'jipiboily/monologue'

# Mysql library for Ruby, binding to libmysql. It also forces the use of UTF-8 for the connection
gem 'mysql2'

group :production do
  gem 'newrelic_rpm'
end

group :development do
  gem 'thin'
  gem 'better_errors'
  gem 'quiet_assets'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'coveralls', require: false
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'webmock'
end

# POPLUS integration
gem 'roar', '0.11.19'
gem 'roar-rails', '0.1.0'
gem 'faraday', '0.8.1'
gem 'billit_representers', '0.9.7'
gem 'popit_representers', '0.0.17'
gem 'writeit-rails', :git => 'git://github.com/ciudadanointeligente/writeit-rails.git'

gem 'httparty'
gem 'json'
gem 'protected_attributes'
gem 'rake', '10.1.1'
gem 'popolo', :github => 'opennorth/popolo-engine'
gem 'pupa', :github => 'opennorth/pupa-ruby'
