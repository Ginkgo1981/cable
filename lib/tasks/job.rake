namespace :job do

  desc 'clean job published 1 month ago'
  task clean_expired_job: :environment do
    jobs  = Job.where('job_published_at < ?', 10.days.ago)
    jobs.each do |job|
      begin
      company = job.company
      company.destroy
      rescue => err
        puts err
      end
    end
  end


end
