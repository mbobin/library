source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 5.2.0.rc1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pg_search'
gem 'puma', '~> 3.11'
gem 'devise'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
# gem 'bootsnap', '>= 1.2.0', require: false
gem 'bootsnap', github: 'ojab/bootsnap', require: false
gem 'bootstrap', '~> 4.0.0'
gem 'jquery-rails'
gem 'octicons_helper'
gem 'isbn_extractor', github: 'mbobin/isbn_extractor'
gem 'delayed_job_active_record'
gem 'pry'
gem 'daemons'
gem 'kaminari'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
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
