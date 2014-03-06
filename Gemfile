source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use Devise for user authentication
gem 'devise', :git => 'git://github.com/plataformatec/devise.git', :ref => '49aebde'

# Database
#gem 'pg', :group => :production
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

group :development do
  # Using thin for development server
  gem 'thin'
  # Replaces default rails error page with a much better and more useful error page
  gem 'better_errors'
  # Turns off the rails asset pipeline log
  gem 'quiet_assets'
  gem 'binding_of_caller'
end

# Support to XLS export
gem 'ekuseru'

# Support for localization
gem 'rails-i18n', '~> 4.0.0'
gem 'route_translator'

# POPLUS integration
gem 'roar', '0.11.19'
gem 'roar-rails', '0.1.0'
gem 'faraday', '0.8.1'
gem 'billit_representers', '0.8.9'
gem 'popit_representers', '0.0.13'
gem 'writeit-rails', :git => 'git://github.com/ciudadanointeligente/writeit-rails.git'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'coveralls', require: false
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
end

gem 'httparty'
gem 'json'
gem 'protected_attributes'
gem 'rake', '10.1.1'
