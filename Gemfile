source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "2.5.0"

gem "rails", "~> 5.2.0"

gem "autoprefixer-rails"
gem "bootsnap", require: false
gem "clearance"
gem "es6-promise-rails"
gem "fetch-rails"
gem "flutie"
gem "honeybadger"
gem "httparty"
gem "js-routes"
gem "pg", "~> 0.18"
gem "puma"
gem "rack-canonical-host"
gem "recipient_interceptor"
gem "sass-rails", "~> 5.0"
gem "skylight"
gem "sprockets", ">= 3.0.0"
gem "sprockets-es6"
gem "suspenders"
gem "title"
gem "uglifier"

group :development do
  gem "letter_opener"
  gem "listen"
  gem "rack-mini-profiler", require: false
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "bundler-audit", ">= 0.5.0", require: false
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-byebug"
  gem "pry-rails"
  gem "refills"
  gem "rspec-rails", "~> 3.6"
  gem "rspec_junit_formatter"
end

group :test do
  gem "capybara-webkit"
  gem "email_spec"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
end

group :production do
  gem "rack-timeout"
end

gem "bourbon", "~> 5.0"
gem "delayed_job_active_record"
gem "high_voltage"
gem "neat", "~> 2.1"
gem "simple_form"
