source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.4' # lock to your version should you so choose

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
gem 'actionpack', '~> 5.2', '>= 5.2.4.3'
# Use Puma as the app server
gem 'puma', '~> 4.3.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'pg', '~> 0.21'
gem 'sdoc', '~> 1.1', group: :doc


group :development, :test do
  gem 'byebug'
end

# problemas com bootstrap_flash_messages e jquery-datatables-rails no rails g

# others
gem 'acts_as_tree'
gem 'bootstrap-wysihtml5-rails'
gem 'bootstrap_flash_messages', git: 'https://github.com/useruby/bootstrap_flash_messages.git'
gem 'breadcrumbs_on_rails'
gem 'cancancan'
gem 'has_scope', '~> 0.7.2'
gem 'devise'
gem 'devise_invitable'
gem 'draper', '~> 4.0', '>= 4.0.1'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.5'
gem 'has_scope', '~> 0.7.2'
gem 'humanize_boolean'
gem 'iconv'
gem 'inherited_resources', '~> 1.11'
gem 'lazyload-rails'
gem 'paperclip', '~> 5.2.0'
gem 'paranoia', '~> 2.0'
gem 'responders'
gem 'scoped_search'
gem 'searchkick'
gem 'selectize-rails'
gem 'sidekiq', '~> 4.0.0'
gem 'simple-navigation'
gem 'simple_form'
gem 'slim'
gem 'will_paginate-bootstrap'
gem 'sweet-alert2-rails'

gem 'ajax-datatables-rails'
gem 'jquery-datatables'
gem 'yajl-ruby', require: 'yajl'

source 'https://rails-assets.org' do
  gem 'rails-assets-adminlte'
  gem 'rails-assets-bootstrap-datepicker'
  gem 'rails-assets-bootstrap-switch'
  gem 'rails-assets-bootstrap'
  gem 'rails-assets-jQuery-Mask-Plugin'
  gem 'rails-assets-jquery.slimscroll'
  gem 'rails-assets-momentjs'
  gem 'rails-assets-notifyjs'
  gem 'rails-assets-sweetalert2', '~> 5.1.1'
  gem 'rails-assets-toastr'
end
