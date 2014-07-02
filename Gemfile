source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use Devise for user authentication
gem 'devise', :git => 'git://github.com/plataformatec/devise.git', :ref => '49aebde'

# Database
gem 'sqlite3'

# Template Engine
gem 'haml'
gem 'haml-rails', :group => :development

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# bcrypt-ruby is a Ruby binding for the OpenBSD bcrypt() password hashing algorithm
gem 'bcrypt-ruby', :require => 'bcrypt'

# An interface to the ImageMagick and GraphicsMagick image processing libraries
gem 'rmagick'

# Adam Shaw's fullcalendar jquery plugin
gem 'fullcalendar-rails'

# Support to XLS export
gem 'ekuseru'

# Support for localization
gem 'rails-i18n', '~> 4.0.0'
gem 'route_translator'

# Caching
gem 'actionpack-page_caching'
gem 'actionpack-action_caching'

# Clean ruby syntax for writing and deploying cron jobs (for rvm)
gem 'whenever', :git => 'https://github.com/Insomniware/whenever.git', :require => false
#gem 'whenever', :require => false #for non rvm

group :production do
  gem 'mysql'
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
gem 'popit_representers', '0.0.15'
gem 'writeit-rails', :git => 'git://github.com/ciudadanointeligente/writeit-rails.git'

gem 'httparty'
gem 'json'
gem 'protected_attributes'
gem 'rake', '10.1.1'
