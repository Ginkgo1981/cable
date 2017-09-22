namespace :jobs do
  desc 'export_job_to_txt'
  task export_job_to_txt: :environment do
    reg = /([\[|\、|\，|\s|\（\公\（\(\）|0|\-|您|你|《|实习|计划|招聘|诚募|应届|储备|\&|\/|\】])|[a-z0-9|A-Z]/
    jobs = Job.all.map(&:job_name).select{|name| name !~ reg }.uniq
    File.open('features/positions.txt', 'w') do |file|
      jobs.each  do |j|
        file.puts j
      end
    end
  end

end
