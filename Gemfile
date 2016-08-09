source 'https://rubygems.org'

gem 'rails', '~> 4.0.0'
gem 'rack'
gem 'ransack'
gem 'carrierwave'
gem "pg", "~> 0.17.0"
gem 'rmagick', '~> 2.15.4'
gem 'simple_form'
gem 'geocoder'
gem 'cancancan'
#gem 'strong_parameters' #doesn't work with Rails 4
#gem "taps"
#gem 'validates_timeliness', '~> 3.0'

#Handles authentication
gem 'devise', '~> 3.0'

group :test, :development do
  gem 'thin'
  gem "rspec-rails"
  gem 'rspec-activemodel-mocks' # TODO: remove if we no longer need mock_model or stub_model
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec", require: false
  gem 'guard-livereload'
  gem 'sqlite3'
  gem "mailcatcher"
  gem "launchy"
  gem "letter_opener"
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'database_cleaner', '1.0.1'
  gem 'test-unit'
  gem 'poltergeist'
  gem 'pry'
end

group :test do
  gem 'shoulda-matchers'
end

gem 'jquery-rails'

gem 'sass-rails'
#gem 'sass-rails', '~> 4.0.4'
# http://stackoverflow.com/questions/26416065/which-gem-is-breaking-rails-application-css-scss-wrong-number-of-arguments-3-for
# gem 'sass-rails', github: 'rails/sass-rails', branch: '4-0-stable'

gem 'coffee-rails'
#The following provides the stylinmg for the datatables, among other things
gem 'jquery-ui-rails'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', :platforms => :ruby

gem 'uglifier', '>= 1.0.3'
gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'
gem 'bootstrap-sass', '2.3.2.0'
gem 'chosen-rails'

# before switching to strong params:
# /Users/david/.gems/gems/activemodel-4.0.13/lib/active_model/deprecated_mass_assignment_security.rb:14:in
# `attr_accessible': `attr_accessible` is extracted out of Rails into
# a gem. Please use new recommended protection model for
# params(strong_parameters) or add `protected_attributes` to your
# Gemfile to use old one. (RuntimeError)

gem 'protected_attributes'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
 gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano', '~> 2.15'
# This is used by Capistrano, but 2.8 has issues
gem "net-ssh", "~> 2.7.0"

# To use debugger
# gem 'debugger'

gem 'sprockets', '~> 2.12.4'
gem 'sprockets-rails', '~> 2.3.2'
