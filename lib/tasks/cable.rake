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


  desc 'gerenate universities'
  task generate_universities: :environment do
    YxDetail.all.each do |yx|
      u = University.create name: yx.yxmc,
          code: yx.yxdm,
          city: yx.dq,
          address: yx.xxdz,
          website: yx.xxwz,
          tel: yx.xxdh,
          brief: yx.xxjj

      pp u.id
    end
  end

  desc 'gerenate dsin to universities'
  task generate_dsin_to_universities: :environment do
    University.all.each do |university|
      pp university.id
      university.create_bean
    end
  end

  desc 'gerenate dsin to major'
  task generate_dsin_to_majors: :environment do
    Major.all.each do |major|
      pp major.id
      major.create_bean
    end
  end

  desc 'generate dsin to bean'
  task generate_dsin_to_bean: :environment do
    Bean.all.each do |bean|
      bean.save!
      pp bean.id
    end

  end



  desc 'generate majoys'
  task generate_majors: :environment do
    connection = ActiveRecord::Base.connection
    University.all.each do |u|
      sql = "select * from yx_zys where yxmc='#{u.name}'"
      result = connection.exec_query(sql)
      result.rows.each do |r|
        m = u.majors.create! name: r[2], code: r[3]
        pp m.id
      end
    end
  end

end
