source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails',          '5.0.0'
gem 'pg',             '~> 0.18.4'
gem 'jbuilder',       '~> 2.0'
gem 'sdoc',           '~> 0.4.0', group: :doc
gem 'braintree',      '~> 2.63' # Payments
gem 'figaro',         '1.1.1'
gem 'faker',          '~> 1.6', '>= 1.6.3'
gem 'whenever',       '~> 0.9.7'
gem 'twilio-ruby',    '~> 4.11.1'
gem 'kaminari',       '~> 0.16.3' # Pagination
gem 'pg_search',      '~> 1.0', '>= 1.0.6' # Search
gem 'annotate',       '2.7.1'

# Image Upload
gem 'carrierwave', '>= 1.0.0.rc', '< 2.0'
gem 'carrierwave-base64', '~> 2.3', '>= 2.3.4'

# Email Processing
gem 'griddler', '~> 1.3', '>= 1.3.1'
gem 'griddler-sendgrid', '~> 0.0.1'

# Authentication
gem 'jwt', '~> 1.5', '>= 1.5.4'
gem 'bcrypt',         '~> 3.1', '>= 3.1.11'
gem 'rack-cors',      '~> 0.4.0'

group :development, :test do
  gem 'byebug'
  gem 'thin', '~> 1.7'
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails', '~> 4.7'
  gem 'database_cleaner', '~> 1.5', '>= 1.5.3'
  gem 'spring'
  gem 'pry'
  gem 'railroady'
  gem 'simplecov', require: false
end

group :development do
  gem 'web-console', '~> 3.3', '>= 3.3.1'
  gem 'letter_opener'
end

group :production do
	gem	'rails_12factor',	'0.0.3'
	gem 'puma', '~> 3.4'
end
