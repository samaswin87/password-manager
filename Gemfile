source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.5'

# Core Rails
gem 'rails', '~> 7.2.2'

# Ruby 3.3+ compatibility
gem 'drb'
gem 'logger'
gem 'mutex_m'

# Server
gem 'puma', '~> 6.0'

# Database
gem 'pg', '~> 1.5'

# Asset Pipeline & Frontend
gem 'cssbundling-rails', '~> 1.4'
gem 'jsbundling-rails', '~> 1.3'
gem 'stimulus-rails', '~> 1.3'
gem 'turbo-rails', '~> 2.0'

# JavaScript & UI Libraries
gem 'jquery-datatables', '~> 1.10'
gem 'jquery-rails', '~> 4.6'
gem 'jquery-ui-rails', '~> 7.0'
gem 'select2-rails', '~> 4.0'
gem 'selectize-rails', '~> 0.12'

# File Uploads & Image Processing
gem 'image_processing', '~> 1.13'
gem 'mini_magick', '~> 4.13'

# Authentication & Authorization
gem 'cancancan', '~> 3.6'
gem 'devise', '~> 4.9'
gem 'devise_invitable', '~> 2.0'

# State Machine & Workflow
gem 'aasm', '~> 5.5'

# Background Jobs & Cache
gem 'redis', '~> 5.3'
gem 'sidekiq', '~> 7.3'
gem 'sidekiq-status', '~> 3.0'

# Data Management
gem 'activerecord-import', '~> 1.8'
gem 'acts_as_tree', '~> 2.9'
gem 'data_migrate', '~> 11.1'
gem 'pagy', '~> 9.3'
gem 'paper_trail', '~> 15.2'
gem 'paranoia', '~> 3.0'
gem 'searchkick', '~> 5.3'

# Views & Templates
gem 'ajax-datatables-rails', '~> 1.4'
gem 'breadcrumbs_on_rails', '~> 4.1'
gem 'draper', '~> 4.0'
gem 'inherited_resources', '~> 1.14'
gem 'jbuilder', '~> 2.13'
gem 'responders', '~> 3.1'
gem 'simple_form', '~> 5.3'
gem 'slim', '~> 5.2'

# Utilities
gem 'after_commit_everywhere', '~> 1.4'
gem 'email_validator', '~> 2.2'
gem 'has_scope', '~> 0.8'
gem 'humanize_boolean', '~> 0.0.2'
gem 'smarter_csv', '~> 1.12'
gem 'yajl-ruby', '~> 1.4', require: 'yajl'

# Custom UI Components (from git repos)
gem 'bootstrap_flash_messages', git: 'https://github.com/useruby/bootstrap_flash_messages.git'
gem 'simple-navigation', git: 'https://github.com/samaswin87/simple-navigation.git', branch: 'master'

# Legacy gems (consider migrating away from these)
gem 'bootstrap-toggle-rails'
gem 'font-awesome-rails', '~> 4.7'
gem 'jquery-fileupload-rails'
gem 'lazyload-rails'
gem 'scoped_search'

# Windows timezone data
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  # Debugging
  gem 'byebug', '~> 11.1', platforms: %i[mri windows]
  gem 'pry-rails', '~> 0.3'

  # Code Quality & Security
  gem 'brakeman', '~> 6.2', require: false
  gem 'bundler-audit', '~> 0.9', require: false
  gem 'rubocop', '~> 1.69', require: false
  gem 'rubocop-performance', '~> 1.23', require: false
  gem 'rubocop-rails', '~> 2.27', require: false

  # Testing
  gem 'factory_bot_rails', '~> 6.4'
  gem 'rspec-rails', '~> 7.1'
end

group :development do
  # Code Annotations & Documentation
  gem 'annotate', '~> 3.2'

  # Development Tools
  gem 'dotenv-rails', '~> 3.1'
  gem 'faker', '~> 3.5'
  gem 'listen', '~> 3.9'
  gem 'web-console', '~> 4.2'

  # File Watching (optional)
  gem 'guard', '~> 2.18', require: false
  gem 'guard-shell', '~> 0.7', require: false
end

group :test do
  # System Testing
  gem 'capybara', '~> 3.40'
  gem 'selenium-webdriver', '~> 4.27'

  # BDD Testing
  gem 'cucumber', '~> 9.2'
  gem 'cucumber-rails', '~> 3.1', require: false

  # Test Database Management
  gem 'database_cleaner-active_record', '~> 2.2'

  # Code Coverage
  gem 'simplecov', '~> 0.22', require: false

  # Rails Testing
  gem 'rails-controller-testing', '~> 1.0'
end
