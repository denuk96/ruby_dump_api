source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"
gem "rails", "~> 6"

# == default ==
gem "pg", "~> 1.2", ">= 1.2.3"
gem "puma", "~> 5.0"
# == redis ==
gem "hiredis"
# == background ==
gem "sidekiq", "~> 5.2"
gem "sidekiq-cron", "~> 1.2"
# == api doc ==
gem "rswag"
# == other ==
gem "active_model_serializers", "~> 0.10.0"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", ">= 1.4.4", require: false
gem "jwt"
gem "rack-cors"


# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails", "~> 3.9"
end

group :development do
  gem "annotate"
  gem "listen", "~> 3.2"
  gem "rack-mini-profiler", "~> 2.0"
  gem "rubocop", "0.90.0"
  gem "rubocop-performance", "1.8.0", require: false
  gem "rubocop-rails", "2.8.0", require: false
  gem "spring"
  gem "web-console", ">= 4.0.3"
end

group :test do
  gem "database_cleaner"
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
