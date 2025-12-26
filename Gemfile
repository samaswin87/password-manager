source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.5'
gem 'drb' # Required for Ruby 3.4+ compatibility
gem 'logger' # Required for Ruby 3.3+ compatibility
gem 'mutex_m' # Required for Ruby 3.4+ compatibility
gem 'rails', '~> 7.2.2'
# Use Puma as the app server
gem 'puma', '~> 6.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Hotwire's SPA-like page accelerator
gem 'turbo-rails'
# Hotwire's modest JavaScript framework
gem 'stimulus-rails'
# Use JavaScript bundling with esbuild
gem 'jsbundling-rails'
# Use CSS bundling with cssbundling
gem 'cssbundling-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'cucumber'
gem 'email_validator'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # Security tools
  gem 'brakeman', require: false        # Security vulnerability scanner
  gem 'bundler-audit', require: false   # Check for vulnerable versions of gems
  gem 'rubocop', require: false         # Code style checker
  gem 'rubocop-performance', require: false # Performance-related RuboCop rules
  gem 'rubocop-rails', require: false # Rails-specific RuboCop rules
end

group :development do
  gem 'annotate'
  gem 'dotenv-rails'
  gem 'faker'
  gem 'guard'
  gem 'guard-shell'
  gem 'pry-rails'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'cucumber-rails', require: false
  gem 'webdrivers', '~> 4.0'
  # database_cleaner is not mandatory, but highly recommended
  gem 'database_cleaner'
  gem 'simplecov', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'pg', '~> 1.5'
gem 'sdoc', '~> 1.1', group: :doc

# others
gem 'aasm'
gem 'activerecord-import'
gem 'acts_as_tree'
gem 'after_commit_everywhere', '~> 0.1', '>= 0.1.5'
gem 'ajax-datatables-rails'
gem 'bootstrap_flash_messages', git: 'https://github.com/useruby/bootstrap_flash_messages.git'
gem 'bootstrap-wysihtml5-rails'
gem 'breadcrumbs_on_rails'
gem 'cancancan'
gem 'data_migrate'
gem 'devise'
gem 'devise_invitable'
gem 'draper', '~> 4.0', '>= 4.0.1'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.5'
gem 'has_scope', '~> 0.7.2'
gem 'humanize_boolean'
gem 'iconv'
gem 'image_processing', '~> 1.2'
gem 'inherited_resources', '~> 1.11'
gem 'jquery-datatables'
gem 'jquery-fileupload-rails'
gem 'lazyload-rails'
gem 'mini_magick', '~> 4.11'
gem 'pagy'
gem 'paperclip'
gem 'paper_trail'
gem 'paranoia', '~> 3.0'
gem 'rails-controller-testing'
gem 'redis-rails'
gem 'responders'
gem 'scoped_search'
gem 'searchkick'
gem 'selectize-rails'
gem 'sidekiq'
gem 'sidekiq-status'
gem 'simple_form'
gem 'simple-navigation', git: 'https://github.com/samaswin87/simple-navigation.git', branch: 'master'
gem 'slim'
gem 'smarter_csv'
gem 'yajl-ruby', require: 'yajl'
# Webpacker removed in Rails 7.0, replaced with jsbundling-rails
# gem 'webpacker', '~> 5.1.1'
gem 'bootstrap-toggle-rails'
gem 'select2-rails'

source 'https://rails-assets.org' do
  gem 'rails-assets-adminlte'
  gem 'rails-assets-bootstrap'
  gem 'rails-assets-bootstrap-datepicker'
  gem 'rails-assets-bootstrap-switch'
  gem 'rails-assets-jquery.slimscroll'
  gem 'rails-assets-jQuery-Mask-Plugin'
  gem 'rails-assets-momentjs'
  gem 'rails-assets-notifyjs'
  gem 'rails-assets-toastr'
end
