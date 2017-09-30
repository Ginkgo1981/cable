class EntryCompletion < Struct.new(:soap_client,:json_raw)
  def call
    company_job_json = JSON.parse(json_raw)
    document = {:body => company_job_json['job_description'].strip}
    #do features
    response = soap_client.doFeature([document].collect { |p| p.nil? ? "{}" : p.to_json.to_s })
    job_tags = response['return'].split(',').map { |p| p.split('=')[0] }
    company_job_json.merge! job_tags: job_tags
    puts "[entry] call company_job_json #{company_job_json}"
    Job.create_after_check(company_job_json)
  end
end