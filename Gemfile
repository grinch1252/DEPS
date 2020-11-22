source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.1'
gem 'bootstrap', '~> 4.3.1'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'coffee-rails', '4.2.2'
gem 'jquery-rails', '4.3.3'
gem 'jquery-ui-rails'
gem 'uglifier'
gem 'haml-rails', '~> 2.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'faker',          '1.9.3'
gem 'will_paginate',           '3.1.7'
gem 'bootstrap-will_paginate', '1.0.0'
gem 'carrierwave',             '1.2.2'
gem 'mini_magick',             '4.7.0'
gem 'omniauth-twitter'
gem 'kaminari'
gem 'kaminari-bootstrap'
gem 'chartkick'
gem 'fullcalendar-rails'
gem 'momentjs-rails'
gem 'font-awesome-rails'
gem 'dotenv-rails'

group :development, :test do
  gem 'sqlite3'
  gem 'byebug',  '9.0.6', platform: :mri
  gem 'rspec-rails', '~> 3.8'
  gem 'spring-commands-rspec'
  gem 'capybara'
  gem 'webdrivers'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


group :production, :staging do
  gem 'pg', '0.20.0'
  gem 'unicorn'
  gem 'fog-aws'
end
