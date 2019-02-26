source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.5.3"
gem "bcrypt", "3.1.12"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap-sass", "~> 3.3", ">= 3.3.7"
gem "bootstrap-will_paginate"
gem "cancancan", "~> 2.0"
gem "carrierwave"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "devise", "~> 4.1"
gem "faker"
gem "i18n-js"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "jquery-ui-rails"
gem "mini_magick", "4.7.0"
gem "mysql2", ">= 0.4.4", "< 0.6.0"
gem "puma", "~> 3.11"
gem "rails", "~> 5.2.2"
gem "rails-controller-testing"
gem "ransack"
gem "rubocop", "~> 0.54.0", require: false
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "will_paginate"

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :production do
  gem "fog", "1.42"
  gem "pg", "~> 0.18"
  gem "rails_12factor", "0.0.2"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails", require: false
  gem "rspec-rails"
end


group :test do
  gem "capybara", ">= 2.15"
  gem "chromedriver-helper"
  gem "guard-rspec"
  gem "launchy"
  gem "minitest"
  gem "minitest-reporters"
  gem "rails-controller-testing"
  gem "shoulda-matchers", github: "thoughtbot/shoulda-matchers"
  gem "selenium-webdriver"
  gem "selenium-webdriver"
  gem "simplecov", require: false
end
