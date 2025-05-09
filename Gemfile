source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.8'
# Use postgresql as the database for Active Record
gem 'pg' #, '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma' #, '~> 5.6.5'
# Use Bootstrap framework for HTML formatting
gem 'bootstrap-sass' #, '~> 3.4.1'
# Use SCSS for stylesheets
gem 'sass-rails' #, '~> 6.0'
# Use fontawesome for arrows
gem 'font-awesome-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier' #, '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# With ruby 3.4 a bunch of default gems failed and had to be added manually
gem 'bigdecimal'
gem 'mutex_m'
gem 'benchmark'
gem 'drb'
gem 'csv'
gem 'timeout'
gem 'base64'
gem 'json'
gem 'irb'
gem 'reline'
gem 'rdoc'
gem 'logger'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails' #, '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
#gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder' #, '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt' #, '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# JQuery
gem 'jquery-rails' #, '>= 3.1.0'
gem 'jquery-ui-rails'

# Enable nested forms
gem 'cocoon'

# Enable jQuery select boxes
gem 'select2-rails' #, '~> 3.2.1'

# Until update rails to 7.1, direct dependency on concurrent, which has dependency on logger
# https://stackoverflow.com/questions/79360526/uninitialized-constant-activesupportloggerthreadsafelevellogger-nameerror
gem 'concurrent-ruby', '1.3.4'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails' #, '~> 5.1.2'
  # Needed by rspec
  gem 'rexml'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara' #, '>= 2.15'
  gem 'factory_bot_rails'
  gem 'database_cleaner'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console'# , '>= 3.3.0'
  gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen' #, '~> 2.0.0'
end

group :test do
  gem 'selenium-webdriver'#, '-> 4.11'
  gem 'capybara-selenium'
  # Easy installation and use of chromedriver to run system tests with Chrome
  #gem 'chromedriver-helper'
  # gem 'webdrivers' #, '~> 4.4.1'
  gem 'database_cleaner-active_record'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
#gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
