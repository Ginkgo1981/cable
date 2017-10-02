require 'soap/wsdlDriver'
namespace :channel do
  desc 'read from redis then sink to elasticksearch'
  task index_to_elasticsearch: :environment do
    # logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
    # logger.tagged('BCX') { logger.info 'Stuff' }
    Rails.logger = nil
    Elasticsearch::Model.client.transport.logger = nil
    feature_ws_url = 'http://localhost:8082/AxisWS/asia.wildfire.Featurer?wsdl'
    soap_client = SOAP::WSDLDriverFactory.new(feature_ws_url).create_rpc_driver
    # queues = ['crawler:91job_normal_json_queue','crawler:js_market_json_queue', 'crawler:91job_campus_json_queue', 'crawler:wutongguo_json_queue']
    flag = true

    text=File.open('features/host_json.txt').read
    host_dics = text.split(/\n/).map{|s|
      name,host  = s.split(',')
      {name: name, host:host}
    }
    while flag
      json_raw = nil
      begin
        json_raw = $redis_crawler.lpop 'company_job_json_list'
        if json_raw
          entry = EntryCompletion.new(host_dics, soap_client,json_raw).call
          sleep 1
          puts "[cable] index_to_elasticsearch succ 0 '' ''"
        else
          flag = false
          puts "[cable] index_to_elasticsearch empty 0 '#{Time.now.to_s}' ''"
        end
      rescue Exception => e
        puts "[cable] index_to_elasticsearch error 0 '#{e.to_s}' '#{json_raw}'"
      end
    end
  end


  desc 'test'
  task :test, [:queue] => :environment do |task, args|

    text=File.open('features/host_json.txt').read
    host_dics = text.split(/\n/).map{|s|
      name,host  = s.split(',')
      {name: name, host:host}
    }


    feature_ws_url = 'http://localhost:8082/AxisWS/asia.wildfire.Featurer?wsdl'
    soap_client = SOAP::WSDLDriverFactory.new(feature_ws_url).create_rpc_driver
    json_raw = $redis_crawler.get_from_queues [args.queue]
    entry = EntryCompletion.new(host_dics, soap_client,json_raw).call
  end


end
