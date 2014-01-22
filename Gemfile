source 'https://rubygems.org'

gem 'rails', '3.2.13'

gem 'pg'
group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'zeus'
  gem 'quiet_assets'
end


group :test do
  gem 'cucumber'
  gem 'cucumber-rails', :require => false
  gem 'mocha', require: false
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'poltergeist'
  gem 'factory_girl_rails'
  gem 'fuubar-cucumber'

  #gem 'rspec-expectations'
  #gem 'rspec-rails-mocha'
  #gem 'assert_difference'
  #gem 'nyan-cat-formatter', require: false
  #gem 'simplecov'
  #gem 'simplecov-html'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'haml-rails'
gem 'inherited_resources'

ruby '2.0.0'

