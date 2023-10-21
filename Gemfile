source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 3.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 7.0.6"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails", ">= 3.4.1"

# Use postgresql as the database for Active Record
gem "pg"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.0"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails", "~> 1.0", ">= 1.0.1"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails", "~> 1.2"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder", github: "excid3/jbuilder", branch: "partial-paths" # "~> 2.11"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 5.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.12"

# Security update
gem "nokogiri", ">= 1.12.5"

group :development, :test do
  # Optional debugging tools
  # gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  # gem "pry-rails"

  gem "annotate", ">= 3.2.0"
  gem "letter_opener_web", "~> 2.0"
  gem "standard", require: false
  gem "erb_lint", require: false

  # Security tooling to
  # gem "brakeman"
  # gem "bundler-audit", github: "rubysec/bundler-audit"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console", ">= 4.1.0"

  # A fully configurable and extendable Git hook manager
  gem "overcommit", require: false

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler", ">= 2.3.3"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara", ">= 3.39"
  gem "selenium-webdriver", ">= 4.11.0"
  gem "webmock"
end

# Jumpstart Pro dependencies
eval_gemfile "Gemfile.jumpstart"

# We recommend using strong migrations when your app is in production
# gem "strong_migrations", "~> 0.7.6"

gem "roo", "~> 2.10.0"
gem "roo-xls"
# gem 'activerecord-import', '~> 0.15.0'

gem "aws-sdk-s3", require: false
gem "acts_as_list"
gem "ruby-openai"