require 'soap/wsdlDriver'
namespace :channel do
  desc 'read from redis then sink to elasticksearch'
  task sink: :environment do

    # logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
    # logger.tagged('BCX') { logger.info 'Stuff' }
    feature_ws_url = 'http://localhost:8081/AxisWS/asia.wildfire.Featurer?wsdl'
    soap_client = SOAP::WSDLDriverFactory.new(feature_ws_url).create_rpc_driver
    queues = ['crawler:91job_normal_json_queue','crawler:js_market_json_queue', 'crawler:91job_campus_json_queue' ]

    while true
      begin
        json_raw = $redis.get_from_queues queues
        if json_raw
          company_job_json = JSON.parse(json_raw)
          document = {:body => company_job_json['job_description'].strip}
          #do features
          response = soap_client.doFeature([document].collect { |p| p.nil? ? "{}" : p.to_json.to_s })
          job_tags = response['return'].split(',').map { |p| p.split('=')[0] }
          company_job_json.merge! job_tags: job_tags
          Job.create_after_check(company_job_json)
        else
          sleep 10
          puts "[cable] sink empty 0 '' ''"
        end
      rescue Exception => e
        puts "[cable] sink error 0 '#{e.to_s}' ''"
      end
    end
  end
end
