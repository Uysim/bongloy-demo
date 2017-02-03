source 'https://rubygems.org'

ruby(File.read(".ruby-version").strip) if ENV["GEMFILE_LOAD_RUBY_VERSION"].to_i == 1 && File.exist?(".ruby-version")

gem 'rails', '4.2.7.1'
gem 'devise'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'haml'
gem 'puma'
gem 'pg'
gem 'font-awesome-rails'
gem 'bootstrap-sass'
gem 'autoprefixer-rails'
gem 'omniauth-facebook'
gem 'bongloy', :github => "dwilkie/bongloy-ruby"
gem 'simple_form', :github => "plataformatec/simple_form"
gem 'rails-assets-jquery.payment.cambodia', :source => 'https://rails-assets.org'

group :development, :test do
  gem 'rspec-rails'
  gem 'foreman'
  gem 'pry'
  gem 'dotenv'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'selenium-webdriver'
  gem 'poltergeist'
  gem 'shoulda-matchers', '~> 2.8.0', :require => false
  gem "bongloy-spec-helpers", :github => "dwilkie/bongloy-spec-helpers"
end

group :production do
  gem 'rails_12factor'
end
