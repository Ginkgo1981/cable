namespace :resume_dics do
  desc 'import_industry_from_json'
  task import_industry_from_json: :environment do
    File.open('features/industry_json.txt', 'r') do |f|
      f.each_line do |line|
        json = JSON(line)
        puts json['name']
        ResumeDicIndustry.create! name: json['name']
      end
    end
  end


  desc 'import_experience_from_json'
  task import_experience_from_json: :environment do
    File.open('features/experience_json.txt', 'r') do |f|
      f.each_line do |line|
        json = JSON(line)
        puts json['industry_name']
        industry = ResumeDicIndustry.find_by name: json['industry_name']
        if industry
          ResumeDicExperience.create! industry_id: industry.id,
                                      industry_name: industry.name,
                                      name: json['title'],
                                      content: json['content']

        else
          puts 'NO industry found' + json['industry_name']
        end
      end
    end
  end



  desc 'import_honors_from_json'
  task import_honors_from_json: :environment do
    File.open('features/honors_json.txt', 'r') do |f|
      f.each_line do |line|
        json = JSON(line)
        puts json['name']
        ResumeDicHonorTip.create! name: json['name'],
                                  tips: json['tips']
      end
    end
  end
end
