namespace :geo do
  desc 'set_university_geo'
  task set_university_geo: :environment do
    University.all.each do |u|
      begin
        coordinates = Geocoder.coordinates(u.name)
        puts "university : #{u.name}, #{coordinates}"
        sleep 1
        u.latitude = coordinates[0]
        u.longitude = coordinates[1]
        u.save!
      rescue => e
        puts "err: #{e} #{u.name}"
      end
    end
  end
end
