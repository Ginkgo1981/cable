require 'soap/wsdlDriver'
namespace :channel do
  desc 'read from redis then sink to elasticksearch'
  task index: :environment do
    # logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
    # logger.tagged('BCX') { logger.info 'Stuff' }
    feature_ws_url = 'http://localhost:8082/AxisWS/asia.wildfire.Featurer?wsdl'
    soap_client = SOAP::WSDLDriverFactory.new(feature_ws_url).create_rpc_driver
    queues = ['crawler:91job_normal_json_queue','crawler:js_market_json_queue', 'crawler:91job_campus_json_queue', 'crawler:wutongguo_json_queue']
    flag = true

    while flag
      begin
        json_raw = $redis.get_from_queues queues
        if json_raw
          entry = EntryCompletion.new(soap_client,json_raw).call
        else
          flag = false
          sleep 10
          puts "[cable] sink empty 0 '' ''"
        end
      rescue Exception => e
        puts "[cable] sink error 0 '#{e.to_s}' ''"
      end
    end
  end


  desc 'test'
  task :test, [:queue] => :environment do |task, args|
    feature_ws_url = 'http://localhost:8082/AxisWS/asia.wildfire.Featurer?wsdl'
    soap_client = SOAP::WSDLDriverFactory.new(feature_ws_url).create_rpc_driver
    json_raw = $redis.get_from_queues [args.queue]
    entry = EntryCompletion.new(soap_client,json_raw).call
  end


end
