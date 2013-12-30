source 'https://rubygems.org'

gem 'rails', '3.2.13'

gem 'pg'
group :production do
  gem 'rails_12factor'
  gem 'haml-rails'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'cucumber-rails', :require => false
  gem 'zeus'
end
gem 'selenium-webdriver'

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'haml-rails'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'inherited_resources'

ruby '2.0.0'

