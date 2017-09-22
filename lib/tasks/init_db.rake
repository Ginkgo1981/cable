namespace :init_db do
  # resume_dic_industry'
  desc 'resume_dic_industry'
  task resume_dic_industry: :environment do
    File.open('features/industry_json.txt', 'r') do |f|
      f.each_line do |line|
        json = JSON(line)
        puts json['name']
        ResumeDicIndustry.create! name: json['name']
      end
    end
  end

  # resume_dic_experience'
  desc 'resume_dic_experience'
  task resume_dic_experience: :environment do
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

  # resume_dic_honor_tip
  desc 'resume_dic_honor_tip'
  task resume_dic_honor_tip: :environment do
    File.open('features/honors_json.txt', 'r') do |f|
      f.each_line do |line|
        json = JSON(line)
        puts json['name']
        ResumeDicHonorTip.create! name: json['name'],
                                  tips: json['tips']
      end
    end
  end

  # resume_dic_skill
  desc 'resume_dic_skill'
  task resume_dic_skill: :environment do
    File.open('features/resume_dic_skill_json.txt', 'r') do |f|
      f.each_line do |line|
        json = JSON(line)
        puts json['name']
        ResumeDicSkill.create! name: json['name']
      end
    end
  end


  # university
  desc 'university'
  task university: :environment do
    File.open('features/university_json.txt', 'r') do |f|
      f.each_line do |line|
        json = JSON(line)
        puts json['name']
        University.create! name: json['name'],
                           latitude: json['latitude'],
                           longitude: json['longitude']
      end
    end
  end


  # major
  desc 'major'
  task major: :environment do
    File.open('features/major_json.txt', 'r') do |f|
      f.each_line do |line|
        json = JSON(line)
        puts json['name']
        Major.create! name: json['name']
      end
    end
  end

  # city
  desc 'city'
  task city: :environment do
    File.open('features/city_json.txt', 'r') do |f|
      f.each_line do |line|
        json = JSON(line)
        puts json['name']
        City.create! name: json['name']
      end
    end
  end

  # position
  desc 'position'
  task position: :environment do
    File.open('features/positions.txt', 'r') do |f|
      f.each_line do |name|
        puts name
        Position.create! name: name
      end
    end
  end

  #all
  desc 'all'
  task all: [:resume_dic_industry,
              :resume_dic_experience,
              :resume_dic_honor_tip,
              :resume_dic_skill,
              :university,
              :major,
              :city,
              :position] do
  end
end
