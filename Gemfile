source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
# Use sqlite3 as the database for Active Record

# Use Puma as the app server
gem 'puma', '~> 5.6', '>= 5.6.2'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
gem 'geocoder', '~> 1.7'
gem 'devise', '~> 4.8'
gem 'carrierwave', '~> 2.2', '>= 2.2.2'
gem 'file_validators', '~> 3.0'
gem 'mini_magick', '~> 4.11'
gem 'rmagick', '~> 4.2', '>= 4.2.3'
gem 'nokogiri', '~> 1.13'
gem 'bootstrap', '~> 5.1.3'
gem 'bootstrap_form', '~> 5.0'
gem 'jquery-rails', '~> 4.4.0'
gem 'pry', '~> 0.14.1'
gem 'cancancan', '~> 3.3'
gem 'whenever', '~> 1.0', require: false
gem 'date', '~> 3.2', '>= 3.2.2'
gem 'delayed_job_active_record', '~> 4.1', '>= 4.1.7'
gem 'delayed_job_recurring', '~> 0.3.9'
gem 'repost', '~> 0.3.8'
gem 'sassc', '~> 2.4'
gem 'jsbundling-rails'
gem 'bundler', '~> 2.3', '>= 2.3.10'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.11', '>= 1.11.1', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.1'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'sqlite3', '~> 1.4'
end

group :production do
	gem 'pg', '~> 1.3', '>= 1.3.4'
	# gem 'rails_12factor', '0.0.2'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'whenever-test', '~> 1.0', '>= 1.0.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
