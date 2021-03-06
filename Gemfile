source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use sqlite3 as the database for Active Record

gem 'mysql2'

# Use Puma as the app server
gem 'puma', '~> 3.0'

gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'carrierwave-base64', git: 'https://github.com/SkyMatters/carrierwave-base64.git', branch: 'master'
gem 'carrierwave-qiniu', '~> 1.1.0'
gem 'rqrcode'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
gem 'faraday'
# gem 'rb-readline'
gem 'redis'
gem 'state_machine'
gem 'active_model_serializers'
gem 'qiniu'
gem 'listen', '~> 3.0.5'
gem 'soap2r'

gem 'elasticsearch-model'
gem 'elasticsearch-persistence'
gem 'elasticsearch-rails'
gem 'elasticsearch-dsl'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry'
  gem 'pry-nav'
  gem 'pry-rails'
  gem 'annotate', git: 'https://github.com/ctran/annotate_models.git'
  #gem 'byebug', platform: :mri
end

group :development do
  gem 'mina', '~> 0.3.8'
  gem 'mina-sidekiq'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
