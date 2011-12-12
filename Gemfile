source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'pg'
gem 'jquery-rails'
gem 'thin', '1.2.11'
gem 'haml', '3.1.3'
gem 'haml-rails', '0.3.4'
gem 'friendly_id', '~> 4.0.0.beta14'
gem 'bcrypt-ruby', '3.0.1'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
  gem "compass", "~> 0.12.alpha.0"
end

group :development do
  gem 'rspec-rails', '2.7.0'
  gem 'rb-fsevent', '0.4.3.1', require: false if RUBY_PLATFORM =~ /darwin/i
  gem 'growl', '1.0.3'
  gem 'guard-rspec', '0.5.2'
  gem 'guard-spork', '0.3.1'
  gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
  gem 'foreman', '0.26.0'
  gem 'heroku'
  gem 'silent-postgres', '0.1.1'
end

group :test do
  gem 'rspec-rails', '2.7.0'
  gem 'capybara', '1.1.1'
  gem 'factory_girl_rails', '1.3.0'
  gem 'database_cleaner', '0.6.7'
end
