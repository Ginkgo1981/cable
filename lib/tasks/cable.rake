namespace :cable do


  desc 'clean'
  task clean: :environment do

    #user delete_all
    Student.delete_all
    Staff.delete_all
    Teacher.delete_all
    User.delete_all


    #message delete_all
    Message.delete_all
    $redis.flushall


    #relation_delete_all
    Following.delete_all

  end


  desc 'generate notification message'
  task generate_notification_messages: :environment do
    staff = Staff.create!
    User.create! cell: '13913913901', name: 'staff_1', token: 'staff_1n', identity: staff
    attachment = YxDetail.first
    (1..10).each do |i|
      NotificationMessage.create! user: staff.user, attachment: attachment, content: "这是系统消息,感谢你的收听#{i}"
    end
  end


  desc 'student register, then send a welcome message to them'
  task generate_students: :environment do

    (1..9).each do |i|
      student = Student.create! province: '江苏', city: '南京', school: '南京建业中学'
      user = User.create! cell: "1381381380#{i}", name: "student_#{i}", token: "student_#{i}", identity: student

      #notification messages
    end

  end

  task generate_staffs: :environment do


  end

  desc 'generate teachers'
  task generate_teachers: :environment do
    (1..9).each do |i|
      teacher = Teacher.create yxmc: '南京林业大学', yxdm: '10298'
      user = User.create! cell: "1311381380#{i}", name: "teacher_#{i}", token: "teacher_#{i}", identity: teacher
    end

  end


  task generate_subscription_messages: :environment do



  end


  task generate_point_messages: :environment do


  end

end
