# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 2.6'

gem 'zeitwerk'

# gem 'tzinfo-data'
# gem 'american_date' # allows parsing of dates using MM/DD/YYYY, the way ruby 1.8 used to do it

gem 'roo', '~> 2.8'
gem 'roo-xls', '~> 1.2'
gem 'xport', '~> 0.3'

gem 'caxlsx', '~> 3.0'
#  --- OR ---
# gem 'axlsx', '~> 1.3'
# gem 'zip-zip'

group :development do
  gem 'rubocop'
  gem 'solargraph', '0.40.0'

  gem 'rspec'
  gem 'simplecov', '~> 0.19', require: false

  gem 'guard', '~> 2.15'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'listen', '~> 3.2'
end
