set :whenever_environment, defer { stage }
set :whenever_identifier, defer { "#{application}_#{stage}" }
set :whenever_command, "bundle exec whenever"
set :whenever_variables, defer { "'environment=#{rails_env}&current_path=#{current_path}'" }
#require 'whenever/capistrano'
