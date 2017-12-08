# conf_file = File.join('config', 'redis.yml')
# conf = YAML.load(File.read(conf_file))
# Elasticsearch::Model.client = Elasticsearch::Client.new host: "#{conf[Rails.env.to_s]['host']}:9200", log: true
# Elasticsearch::Model.client = Elasticsearch::Client.new host: 'localhost:9200', log: isLog
# Elasticsearch::Model.client.transport.logger.formatter = proc { |s, d, p, m| "\e[32m#{p}\n\e[0m" }

if Rails.env.to_s == 'production'
  Elasticsearch::Model.client = Elasticsearch::Client.new host: 'loop4m:9200', log: false
else
 Elasticsearch::Model.client = Elasticsearch::Client.new host: 'localhost:9200', log: true
 Elasticsearch::Model.client.transport.logger.formatter = proc { |s, d, p, m| "\e[32m#{p}\n\e[0m" }
end

