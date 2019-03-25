source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 5.2.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pg_search'
gem 'pry'
gem 'bootsnap'
gem 'devise'
gem 'delayed_job_active_record'
gem 'pundit', '~> 2.0', '>= 2.0.1'

group :web do
  gem 'puma', '~> 3.11'
  gem 'kaminari'
  gem 'simple-navigation'
  gem 'simple_navigation_bootstrap'
  gem 'octicons_helper'
  gem "bootstrap_form", ">= 4.0.0.alpha1"
end

group :assets do
  gem 'uglifier', '>= 1.3.0'
  gem 'sass-rails', '~> 5.0'
  gem 'coffee-rails', '~> 4.2'
  gem 'jquery-rails'
  gem 'turbolinks', '~> 5'
  gem 'bootstrap', '~> 4.1'
end

group :workers do
  gem 'isbn_extractor', github: 'mbobin/isbn_extractor'
  gem 'booksr', github: "mbobin/booksr"
  gem 'marcel'
  gem 'daemons'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.8'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'mina', require: false
  gem 'mina-puma', require: false#, github: 'untitledkingdom/mina-puma'
  gem 'mina-delayed_job', require: false, github: 'mbobin/mina-delayed_job'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
