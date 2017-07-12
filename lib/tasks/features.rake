namespace :features do
  desc 'generate_features'
  task generate_fetures: :environment do

    dics = []
    Dir.glob("#{Rails.root}/features/*").each do |file_name|
      puts file_name
      text=File.open(file_name).read
      dics.concat text.split(/\n/)
    end
    puts dics.uniq.count
    File.open('features/features-skymatter.txt', 'w') do |file|
      dics.each do |b|
        file.puts "#{b}\t#{b}"
      end
    end


  end

  desc 'generate_ik_dics'
  task generate_ik_dics: :environment do
    dics = []
    Dir.glob("#{Rails.root}/features/*").each do |file_name|
      puts file_name
      text=File.open(file_name).read
      dics.concat text.split(/\n/)
    end
    puts dics.uniq.count
    File.open('features/skymatter.dic', 'w') do |file|
      dics.each do |b|
        file.puts b
      end
    end
  end

end
