namespace :cable do


  desc 'city-lib'
  task set_city: :environment do
    City.delete_all
    cities = "北京,上海,广州,深圳,成都,杭州,武汉,南京,镇江,南通,徐州,连云港,重庆,天津,苏州,西安,长沙,沈阳,青岛,郑州,大连,东莞,宁波,厦门,福州,无锡,合肥,昆明,哈尔滨,济南,佛山,长春,温州,石家庄,南宁,常州,泉州,南昌,贵阳,太原,金华,珠海,惠州,烟台,嘉兴,乌鲁木齐,绍兴,中山,台州,兰州,海口,潍坊,保定,扬州,桂林,唐山,三亚,呼和浩特,廊坊,洛阳,威海,盐城,临沂,江门,泰州,漳州,邯郸,济宁,芜湖,淄博,银川,柳州,绵阳,湛江,鞍山,湖州,汕头,南平,赣州,大庆,宜昌,包头,咸阳,秦皇岛,株洲,莆田,吉林,淮安,肇庆,宁德,衡阳,丹东,丽江,揭阳,舟山,孝感,齐齐哈尔,九江,龙岩,沧州,抚顺,襄阳,上饶,营口,蚌埠,丽水,岳阳,清远,荆州,泰安,衢州,盘锦,东营,南阳,马鞍山,南充,西宁,三明,乐山,湘潭,遵义,宿迁,新乡,信阳,滁州,锦州,潮州,黄冈,开封,德阳,德州".split(",")
    cities.each do |name|
      pp "=== name === #{name}"
      City.create! name: name
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


end
