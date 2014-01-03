source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '4.0.0'

gem 'journey', :git => 'git://github.com/rails/journey.git'
gem 'arel'
gem 'activerecord-deprecated_finders', :git => 'git://github.com/rails/activerecord-deprecated_finders.git'

# ORM
#gem 'pg', :group => :production

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'coveralls', require: false
end

group :test do
  gem 'webmock'
end

gem 'json'

# For using protected attributes
gem 'protected_attributes'

# Server
gem 'unicorn'

# Template Engine
gem 'haml-rails'

gem 'bcrypt-ruby', :require => 'bcrypt'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sprockets-rails'
  gem 'sass-rails', :git => 'git://github.com/rails/sass-rails.git'
  gem 'coffee-rails', :git => 'git://github.com/rails/coffee-rails.git'

  # gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '1.0.3'
end

# POPLUS integration
gem 'roar', '0.11.19'
gem 'roar-rails', '0.1.0'
gem 'faraday', '0.8.1'
gem 'billit_representers', '~>0.7.0'
gem 'popit_representers'

# Support to XLS export
gem 'ekuseru'

# UI
gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'coveralls', require: false
gem 'rake', '10.1.1'
gem 'rails-i18n', '~> 4.0.0'
gem 'route_translator'
