source 'https://rubygems.org'

gem 'rails', '3.2.9'
gem 'bcrypt-ruby', '~> 3.0.0', :require => "bcrypt"
gem 'faker', '1.0.1'
gem 'will_paginate', '3.0.3'
gem "RedCloth", "~> 4.2.9"
gem 'jquery-rails'

group :development, :test do
  gem 'sqlite3', '1.3.6'
  gem 'rspec-rails', '2.10.0'
  gem 'guard-rspec', '0.5.5'
  gem 'annotate', '~> 2.4.1.beta'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.3'
  gem 'coffee-rails', '3.2.1'
  gem 'uglifier', '1.0.3'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'rspec-rails', '2.10.0'
  gem 'growl', '1.0.3'
  gem 'factory_girl_rails', '1.4.0'
  gem 'cucumber-rails', '1.2.1', :require => false
  gem 'database_cleaner', '0.7.0'
end

group :production do
  gem 'pg', '0.12.2'
end