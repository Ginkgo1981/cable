source 'https://gems.ruby-china.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'
# gem 'mysql2'
gem 'pg'
gem 'sidekiq'
gem 'sinatra', require: nil
gem 'whenever'
gem 'crypt_keeper'
gem 'puma', '~> 3.0'
gem 'carrierwave', github: 'carrierwaveuploader/carrierwave'
gem 'carrierwave-base64', git: 'https://github.com/SkyMatters/carrierwave-base64.git', branch: 'master'
gem 'carrierwave-qiniu', '~> 1.1.0'
gem 'rqrcode'
gem 'kaminari'
gem 'awesome_print'

gem 'sidekiq'


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
gem 'redis'
gem 'redis-namespace'
gem 'state_machine'
gem 'active_model_serializers'
gem 'qiniu'
gem 'listen', '~> 3.0.5'
gem 'soap2r'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'elasticsearch-dsl', git: 'git://github.com/elasticsearch/elasticsearch-ruby.git', branch: '5.x'
gem 'elasticsearch-model', github: 'elastic/elasticsearch-rails', branch: '5.x'
gem 'elasticsearch-rails', github: 'elastic/elasticsearch-rails', branch: '5.x'
gem 'elasticsearch-persistence', git: 'git://github.com/elastic/elasticsearch-rails.git', branch: '5.x'
# gem 'elasticsearch-model'
# gem 'elasticsearch-persistence'
# gem 'elasticsearch-rails'
# gem 'elasticsearch-dsl'
gem 'uuidtools'
gem 'mechanize'
gem 'nokogiri'
gem 'geocoder'
gem 'geokit-rails'

gem 'selenium'
gem 'selenium-webdriver'

gem 'pry'
gem 'pry-nav'
gem 'pry-rails'
gem 'simhash'
gem 'imgkit'
gem 'wkhtmltoimage-binary'

gem 'aliyun-mns', github: 'ginkgo1981/aliyun-mns', branch: 'master'

group :development, :test do
  gem 'annotate', git: 'https://github.com/ctran/annotate_models.git'
end

group :development do
  gem 'mina', '~> 0.3.8'
  gem 'mina-sidekiq'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

