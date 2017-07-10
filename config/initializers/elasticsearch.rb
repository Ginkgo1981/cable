Elasticsearch::Model.client = Elasticsearch::Client.new host: 'http://139.224.65.151:9200', log: true
Elasticsearch::Model.client.transport.logger.formatter = proc { |s, d, p, m| "\e[32m#{m}\n\e[0m" }