require 'mina/rails'
require 'mina/git'
require 'mina/chruby'
require 'mina/bundler'
require 'mina/puma'
require 'mina/delayed_job'

set :application_name, 'library'
set :domain, 'library.lan'
set :deploy_to, '/home/marius/apps/library'
set :repository, 'git@github.com:mbobin/library.git'
set :branch, 'master'

set :user, 'marius'
set :forward_agent, true

set :shared_dirs, fetch(:shared_dirs, []).push('log', 'tmp/pids', 'tmp/sockets', 'public/assets')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/storage.yml', 'config/secrets.yml', 'config/puma.rb')

set :chruby_path, '/usr/local/share/chruby/chruby.sh'
task :remote_environment do
  invoke :chruby, 'ruby-2.5'
end

task :setup do
  command %[touch "#{fetch(:shared_path)}/config/database.yml"]
  command %[touch "#{fetch(:shared_path)}/config/secrets.yml"]
  command %[touch "#{fetch(:shared_path)}/config/storage.yml"]
  command %[touch "#{fetch(:shared_path)}/config/puma.rb"]
end

desc "Deploys the current version to the server."
task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        invoke :'puma:phased_restart'
        invoke :'delayed_job:restart'
      end
    end
  end
end
