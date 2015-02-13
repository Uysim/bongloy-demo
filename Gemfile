source 'https://rubygems.org'
source 'https://rails-assets.org'

ruby "2.2.0"

gem 'rails', '4.2.0'
gem 'devise'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'haml'
gem 'unicorn'
gem 'pg'
gem 'font-awesome-rails'
gem 'bootstrap-sass'
gem 'autoprefixer-rails'
gem 'omniauth-facebook'
gem 'bongloy', :github => "dwilkie/bongloy-ruby"
gem 'simple_form', :github => "plataformatec/simple_form"
gem 'rails-assets-jquery-payment'

group :development, :test do
  gem 'rspec-rails'
  gem 'foreman'
  gem 'pry'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', :require => false
  gem "bongloy-spec-helpers", :github => "dwilkie/bongloy-spec-helpers"
end

group :production do
  gem 'rails_12factor'
end
