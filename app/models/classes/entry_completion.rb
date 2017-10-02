class EntryCompletion < Struct.new(:host_dics,:soap_client,:json_raw)
  def call
    company_job_json = JSON.parse(json_raw)
    document = {:body => company_job_json['job_description'].strip}
    #do features
    response = soap_client.doFeature([document].collect { |p| p.nil? ? "{}" : p.to_json.to_s })
    job_tags = response['return'].split(',').map { |p| p.split('=')[0] }
    host_dic = host_dics.find{|h| h[:host] == URI(company_job_json['company_origin_url']).host}
    company_job_json['job_origin_web_site_name'] = host_dic[:name] if host_dic
    company_job_json.merge! job_tags: job_tags
    # puts "[entry] call company_job_json #{company_job_json}"
    Job.create_after_check(company_job_json)
  end
end