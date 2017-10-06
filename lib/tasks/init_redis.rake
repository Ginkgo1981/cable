namespace :init_redis do
  desc 'init'
  task init: :environment do
    puts 'init begin'
    universities = University.all.map(&:name)
    cities = City.all.map { |u| u.name }
    majors = Major.all.map { |u| u.name }
    positions = File.open('features/positions.txt').read.split /\n/
    hot_positions = File.open('features/hot_positions.txt').read.split /\n/
    industries = ResumeDicIndustry.all.map(&:format)
    tips = ResumeDicHonorTip.all.map(&:tips).flatten.map { |r| {content: r} }
    skills = ResumeDicSkill.all.map(&:name)
    experiences = ResumeDicExperience.all.select { |r| r.name =~ /xx/ }.map(&:name)
    industries_tag_list = File.open('features/industries_tag_list.txt').read.split(/\n/)
    skills_tag_list = File.open('features/skills_tag_list.txt').read.split(/\n/)
    $redis_cable.set('libs:universities', JSON(universities))
    $redis_cable.set('libs:cities', JSON(cities))
    $redis_cable.set('libs:majors', JSON(majors))
    $redis_cable.set('libs:positions', JSON(positions))
    $redis_cable.set('libs:hot_positions', JSON(hot_positions))
    $redis_cable.set('libs:industries', JSON(industries))
    $redis_cable.set('libs:tips', JSON(tips))
    $redis_cable.set('libs:skills', JSON(skills))
    $redis_cable.set('libs:experiences', JSON(experiences))
    $redis_cable.set('libs:industries_tag_list', JSON(industries_tag_list))
    $redis_cable.set('libs:skills_tag_list', JSON(skills_tag_list))
    puts 'init end'
  end


end
