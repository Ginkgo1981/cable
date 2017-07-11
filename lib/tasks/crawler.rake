require 'soap/wsdlDriver'
namespace :crawler do
  desc 'read from redis then sink to elasticksearch'
  task fetch_then_sink_to_es: :environment do

    # logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
    # logger.tagged('BCX') { logger.info 'Stuff' }
    feature_ws_url = 'http://localhost:8082/AxisWS/asia.wildfire.Featurer?wsdl'
    soap_client = SOAP::WSDLDriverFactory.new(feature_ws_url).create_rpc_driver
    queue = 'crawler:company_job_json_queue'
    while true
      begin
        json_raw = $redis.zrange(queue, 0, 0).first
        if json_raw
          $redis.zrem queue, json_raw
          company_job_json = JSON.parse(json_raw)
          document = {:body => company_job_json['job_description'].strip}
          #do features
          response = soap_client.doFeature([document].collect { |p| p.nil? ? "{}" : p.to_json.to_s })
          job_tags = response['return'].split(',').map{|p| p.split('=')[0]}
          company_job_json.merge! job_tags: job_tags
          #comapny_json
          company_json = company_job_json.select{|k,v| k =~ /company/}
          company = Company.create! company_json
          #job_json
          job_json = company_job_json.select{|k,v| k =~ /job/}
          job = Job.create! job_json.merge({company: company})
          puts "[cable] sink-to-es succ 0 '#{company.company_name}-#{job.job_name}'"
        else
          sleep 10
          puts "[cable] sink-to-es empty 0 ''"
        end
      rescue Exception => e
        puts "[cable] sink-to-es error 0 '#{e.to_s}'"
      end
    end
  end
end
