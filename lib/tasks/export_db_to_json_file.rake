namespace :export_db_to_json_file do

  # job
  desc 'job'
  task job: :environment do
    reg = /([\[|\、|\，|\s|\（\公\（\(\）|0|\-|您|你|《|实习|计划|招聘|诚募|应届|储备|\&|\/|\】])|[a-z0-9|A-Z]/
    jobs = Job.all.map(&:job_name).select{|name| name !~ reg }.uniq
    File.open('features/positions.txt', 'w') do |file|
      jobs.each  do |j|
        file.puts j
      end
    end
  end


  # university
  desc 'university'
  task university: :environment do
    File.open('features/university_json.txt', 'w') do |file|
      University.all.each do |e|
        puts e.id
        file.puts e.to_json
      end
    end
  end


  # major
  desc 'major'
  task major: :environment do
    File.open('features/major_json.txt', 'w') do |file|
      Major.all.each do |e|
        puts e.id
        file.puts e.to_json
      end
    end
  end

  # city
  desc 'city'
  task city: :environment do
    File.open('features/city_json.txt', 'w') do |file|
      City.all.each do |e|
        puts e.id
        file.puts e.to_json
      end
    end
  end

  # resume_dic_skill
  desc 'resume_dic_skill'
  task resume_dic_skill: :environment do
    File.open('features/resume_dic_skill_json.txt', 'w') do |file|
      ResumeDicSkill.all.each do |e|
        puts e.id
        file.puts e.to_json
      end
    end
  end

  # resume_dic_experience
  desc 'resume_dic_experience'
  task resume_dic_experience: :environment do
    File.open('features/resume_dic_experience_json.txt', 'w') do |file|
      ResumeDicExperience.all.each do |e|
        puts e.id
        file.puts e.to_json
      end
    end
  end


end
