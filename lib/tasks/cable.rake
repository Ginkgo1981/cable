namespace :cable do


  desc 'setup'
  task setup: :environment do
    u = University.last
    u.name ='天马志愿团队'
    u.logo = 'http://images.gaokao2017.cn/skymatter-logo.png'
    u.save
  end

  desc 'new student notification'
  task new_student_notification: :environment do
    s = Student.last
    n = NotificationMessage.create! direction: 'teacher',
                                    content: "欢迎新同学 #{s.nickname} 加入"
    n.attached_students << s
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


  desc 'generate majors'
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


  desc 'set city & province'
  task set_province_to_university: :environment do
    #
    # %W(  南京大学
    #     东南大学
    #     南京航空航天大学
    #     南京理工大学
    #     河海大学
    #     南京农业大学
    #     中国药科大学
    #     南京邮电大学
    #     南京林业大学
    #     南京信息工程大学
    #     南京工业大学
    #     南京师范大学
    #     南京财经大学
    #     南京医科大学
    #     南京中医药大学
    #     南京审计学院
    #     南京体育学院
    #     南京艺术学院
    #     南京工程学院
    #     南京晓庄学院
    #     江苏警官学院
    #     金陵科技学院
    #     三江学院
    #     南京森林警察学院*
    #     江苏联合职业技术学院
    #     南京工业职业技术学院
    #     南京交通职业技术学院
    #     南京化工职业技术学院
    #     江苏经贸职业技术学院
    #     南京信息职业技术学院
    #     南京特殊教育职业技术学院
    #     江苏海事职业技术学院
    #     南京铁道职业技术学院
    #     江苏城市职业学院
    #     南京机电职业技术学院
    #     南京旅游职业学院
    #     应天职业技术学院
    #     钟山职业技术学院
    #     正德职业技术学院
    #     金肯职业技术学院
    #     南京视觉艺术职业学院
    #     江苏建康职业学院
    #     南京城市职业学院
    #     江苏第二师范学院).each do |name|
    #
    #   u = University.find_by(name: name)
    #   if u
    #     u.province = '江苏'
    #     u.city = '南京'
    #     u.save!
    #     pp "#{u.name} saved"
    #   end
    # end


    %W(
        江苏大学
        江苏科技大学
        镇江市高等专科学校
        江苏农林职业技术学院
        金山职业技术学院
      ).each do |name|
        u = University.find_by(name: name)
        if u
          u.province = '江苏'
          u.city = '镇江'
          u.save!
          pp "#{u.name} saved"
        end
    end


  end

end
