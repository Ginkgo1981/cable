namespace :cable do


  desc 'city-lib'
  task set_city: :environment do
    City.delete_all
    cities = "北京市,上海市,广州市,深圳市,成都,杭州,武汉,南京,镇江,南通市,徐州市,连云港市,重庆,天津,苏州,西安,长沙,沈阳,青岛,郑州,大连,东莞,宁波,厦门市,福州市,无锡市,合肥市,昆明市,哈尔滨市,济南市,佛山市,长春市,温州市,石家庄市,南宁市,常州市,泉州市,南昌市,贵阳市,太原市,金华市,珠海市,惠州市,烟台市,嘉兴市,乌鲁木齐市,绍兴市,中山市,台州市,兰州市,海口市,潍坊市,保定市,扬州市,桂林市,唐山市,三亚市,呼和浩特市,廊坊市,洛阳市,威海市,盐城市,临沂市,江门市,泰州市,漳州市,邯郸市,济宁市,芜湖市,淄博市,银川市,柳州市,绵阳市,湛江市,鞍山市,湖州市,汕头市,南平市,赣州市,大庆市,宜昌市,包头市,咸阳市,秦皇岛市,株洲市,莆田市,吉林市,淮安市,肇庆市,宁德市,衡阳市,丹东市,丽江市,揭阳市,舟山市,孝感市,齐齐哈尔市,九江市,龙岩市,沧州市,抚顺市,襄阳市,上饶市,营口市,蚌埠市,丽水市,岳阳市,清远市,荆州市,泰安市,衢州市,盘锦市,东营市,南阳市,马鞍山市,南充市,西宁市,三明市,乐山市,湘潭市,遵义市,宿迁市,新乡市,信阳市,滁州市,锦州市,潮州市,黄冈市,开封市,德阳市,德州市".split(",")
    cities.each do |name|
      pp "=== name === #{name}"
      City.create! name: name
    end
  end



  desc 'setup'
  task setup: :environment do
    u = University.last
    u.name ='天马志愿团队'
    u.logo = 'http://images.gaokao2017.cn/skymatter-logo.png'
    u.save
  end



  desc 'disable-university'
  task disable_university: :environment do

    ["北京大学",
     "中国人民大学",
     "清华大学",
     "北京交通大学",
     "北京工业大学",
     "北京航空航天大学",
     "北京理工大学",
     "北京科技大学",
     "北方工业大学",
     "北京化工大学",
     "北京服装学院",
     "北京邮电大学",
     "北京印刷学院",
     "北京建筑工程学院",
     "北京石油化工学院",
     "北京电子科技学院",
     "中国农业大学",
     "北京农学院",
     "北京林业大学",
     "中国协和医科大学",
     "首都医科大学",
     "北京中医药大学",
     "北京师范大学",
     "首都师范大学",
     "首都体育学院",
     "北京外国语大学",
     "北京第二外国语学院",
     "北京语言大学",
     "中国传媒大学",
     "中央财经大学",
     "对外经济贸易大学",
     "北京物资学院",
     "外交学院",
     "中国人民公安大学",
     "国际关系学院",
     "中国政法大学",
     "北京信息工程学院",
     "北京机械工业学院",
     "北京联合大学",
     "北京城市学院",
     "中国青年政治学院",
     "北京青年政治学院",
     "首钢工学院",
     "首都经济贸易大学",
     "北京工商大学",
     "北京警察学院",
     "南开大学",
     "天津大学",
     "天津科技大学",
     "天津工业大学",
     "中国民用航空学院",
     "天津理工大学",
     "天津中医药大学",
     "天津师范大学",
     "天津工程师范学院",
     "天津外国语学院",
     "天津商学院",
     "天津财经大学",
     "河北工业大学",
     "天津城市建设学院",
     "天津农学院",
     "天津医科大学",
     "河北大学",
     "河北工程大学",
     "石家庄经济学院",
     "河北理工大学",
     "河北科技大学",
     "河北建筑工程学院",
     "承德医学院",
     "河北师范大学",
     "河北科技师范学院",
     "华北科技学院",
     "山西大学",
     "太原科技大学",
     "中北大学",
     "太原理工大学",
     "山西农业大学",
     "山西医科大学",
     "长治医学院",
     "山西师范大学",
     "太原师范学院",
     "山西大同大学",
     "山西财经大学",
     "山西中医学院",
     "辽宁大学",
     "大连理工大学",
     "沈阳工业大学",
     "沈阳航空工业学院",
     "沈阳理工大学",
     "东北大学",
     "鞍山科技大学",
     "辽宁工程技术大学",
     "辽宁石油化工大学",
     "沈阳化工学院",
     "大连交通大学",
     "大连海事大学",
     "大连轻工业学院",
     "沈阳建筑大学",
     "辽宁工学院",
     "沈阳农业大学",
     "大连水产学院",
     "中国医科大学",
     "大连外国语学院",
     "东北财经大学",
     "中国刑事警察学院",
     "沈阳体育学院",
     "沈阳音乐学院",
     "鲁迅美术学院",
     "沈阳大学",
     "大连民族学院",
     "大连大学",
     "辽宁科技学院",
     "吉林大学",
     "延边大学",
     "长春理工大学",
     "长春大学",
     "北华大学",
     "长春工程学院",
     "黑龙江大学",
     "哈尔滨工业大学",
     "哈尔滨工程大学",
     "黑龙江科技学院",
     "大庆石油学院",
     "齐齐哈尔大学",
     "复旦大学",
     "同济大学",
     "上海交通大学",
     "华东理工大学",
     "上海理工大学",
     "上海海事大学",
     "东华大学",
     "上海电力学院",
     "上海水产大学",
     "上海中医药大学",
     "华东师范大学",
     "上海师范大学",
     "上海外国语大学",
     "上海财经大学",
     "上海对外贸易学院",
     "华东政法学院",
     "上海体育学院",
     "上海音乐学院",
     "上海戏剧学院",
     "上海工程技术大学",
     "上海立信会计学院",
     "上海电机学院",
     "上海金融学院",
     "上海杉达学院",
     "上海大学",
     "上海应用技术学院",
     "上海商学院",
     "上海政法学院",
     "南京大学",
     "苏州大学",
     "东南大学",
     "南京航空航天大学",
     "南京理工大学",
     "江苏科技大学",
     "中国矿业大学",
     "南京工业大学",
     "江苏工业学院",
     "南京邮电大学",
     "河海大学",
     "江南大学",
     "南京林业大学",
     "江苏大学",
     "南京信息工程大学",
     "盐城工学院",
     "南京农业大学",
     "南京医科大学",
     "徐州医学院",
     "南京中医药大学",
     "中国药科大学",
     "南京师范大学",
     "徐州师范大学",
     "淮阴师范学院",
     "盐城师范学院",
     "南京财经大学",
     "江苏警官学院",
     "南京体育学院",
     "常熟理工学院",
     "淮阴工学院",
     "常州工学院",
     "扬州大学",
     "南京审计学院",
     "江苏技术师范学院",
     "淮海工学院",
     "三江学院",
     "南京晓庄学院",
     "南京工程学院",
     "苏州科技学院",
     "浙江大学",
     "杭州电子科技大学",
     "浙江工业大学",
     "浙江理工大学",
     "浙江海洋学院",
     "浙江林学院",
     "温州医学院",
     "浙江中医药大学",
     "浙江师范大学",
     "杭州师范学院",
     "台州学院",
     "温州大学",
     "丽水学院",
     "浙江工商大学",
     "中国美术学院",
     "中国计量学院",
     "浙江万里学院",
     "浙江科技学院",
     "宁波工程学院",
     "浙江财经学院",
     "宁波大学",
     "浙江传媒学院",
     "浙江树人学院",
     "嘉兴学院",
     "浙江大学城市学院",
     "南京艺术学院",
     "安徽大学",
     "中国科学技术大学",
     "合肥工业大学",
     "安徽工业大学",
     "安徽理工大学",
     "安徽工程科技学院",
     "安徽农业大学",
     "安徽医科大学",
     "安徽师范大学",
     "阜阳师范学院",
     "安庆师范学院",
     "黄山学院",
     "滁州学院",
     "安徽财经大学",
     "宿州学院",
     "巢湖学院",
     "淮南师范学院",
     "铜陵学院",
     "安徽建筑工业学院",
     "安徽科技学院",
     "合肥学院",
     "皖西学院",
     "厦门大学",
     "华侨大学",
     "福州大学",
     "南昌大学",
     "九江学院",
     "山东大学",
     "中国海洋大学",
     "山东科技大学",
     "青岛科技大学",
     "青岛理工大学",
     "山东建筑大学",
     "山东轻工业学院",
     "山东农业大学",
     "莱阳农学院",
     "潍坊医学院",
     "滨州医学院",
     "山东中医药大学",
     "济宁医学院",
     "山东师范大学",
     "曲阜师范大学",
     "聊城大学",
     "德州学院",
     "滨州学院",
     "鲁东大学",
     "泰山学院",
     "菏泽学院",
     "河南大学",
     "河南师范大学",
     "武汉大学",
     "武汉工程大学",
     "武汉科技学院",
     "武汉工业学院",
     "湖北工业大学",
     "华中农业大学",
     "湖北中医学院",
     "华中师范大学",
     "湖北大学",
     "湖北师范学院",
     "黄冈师范学院",
     "湖北民族学院",
     "襄樊学院",
     "湖南大学",
     "中山大学",
     "暨南大学",
     "汕头大学",
     "华南理工大学",
     "华南农业大学",
     "广东海洋大学",
     "广州中医药大学",
     "广东药学院",
     "华南师范大学",
     "深圳大学",
     "广东商学院",
     "广州大学",
     "广东警官学院",
     "五邑大学",
     "广东金融学院",
     "茂名学院",
     "东莞理工学院",
     "佛山科学技术学院",
     "广东外语外贸大学",
     "广东工业大学",
     "北京师范大学珠海分校",
     "电子科技大学中山学院",
     "广西大学",
     "广西工学院",
     "桂林工学院",
     "广西医科大学",
     "右江民族医学院",
     "广西中医学院",
     "桂林医学院",
     "广西师范大学",
     "广西师范学院",
     "河池学院",
     "西昌学院",
     "南通大学",
     "南方医科大学",
     "吉林医药学院",
     "天津职业大学",
     "牡丹江大学",
     "鸡西大学",
     "金陵科技学院",
     "镇江市高等专科学校",
     "南通职业大学",
     "徐州工程学院",
     "苏州职业大学",
     "沙洲职业工学院",
     "扬州市职业大学",
     "南京森林公安高等专科学校",
     "连云港师范高等专科学校",
     "泰州师范高等专科学校",
     "中州大学",
     "开封大学",
     "洛阳大学",
     "连云港职业技术学院",
     "南京工业职业技术学院",
     "徐州建筑职业技术学院",
     "泰州职业技术学院",
     "无锡职业技术学院",
     "南通纺织职业技术学院",
     "苏州工艺美术职业技术学院",
     "常州信息职业技术学院",
     "南通航运职业技术学院",
     "无锡商业职业技术学院",
     "南京交通职业技术学院",
     "淮安信息职业技术学院",
     "江苏畜牧兽医职业技术学院",
     "常州纺织服装职业技术学院",
     "苏州农业职业技术学院",
     "苏州工业园区职业技术学院",
     "南京化工职业技术学院",
     "正德职业技术学院",
     "金肯职业技术学院",
     "紫琅职业技术学院",
     "九州职业技术学院",
     "硅湖职业技术学院",
     "江阴职业技术学院",
     "宿迁职业技术学院",
     "南京信息职业技术学院",
     "常州工程职业技术学院",
     "常州轻工职业技术学院",
     "常州机电职业技术学院",
     "徐州工业职业技术学院",
     "江苏食品职业技术学院",
     "江苏农林职业技术学院",
     "江苏信息职业技术学院",
     "江苏教育学院",
     "徐州教育学院",
     "上海工商学院",
     "复旦大学上海视觉艺术学院",
     "上海师范大学天华学院",
     "西北工业大学明德学院",
     "北京化工大学北方学院",
     "温州大学城市学院",
     "北京科技大学天津学院",
     "南京工业大学浦江学院",
     "南京师范大学中北学院",
     "南京医科大学康达学院",
     "南京中医药大学翰林学院",
     "南京信息工程大学滨江学院",
     "苏州大学文正学院",
     "苏州大学应用技术学院",
     "苏州科技学院天平学院",
     "江苏大学京江学院",
     "扬州大学广陵学院",
     "徐州师范大学科文学院",
     "南京邮电大学通达学院",
     "南京财经大学红山学院",
     "江苏科技大学南徐学院",
     "江苏工业学院怀德学院",
     "南通大学杏林学院",
     "南京审计学院金审学院",
     "国防大学",
     "国防科学技术大学",
    ].each do |name|
      pp name
      University.create! name: name
    end
  end



  desc 'hot major'
  task hot_major: :environment do


    hot_majors =
        [
         "主持与播音",
         "书法学",
         "交互媒体设计",
         "交通安全与智能控制",
         "交通工程",
         "交通运输",
         "产品质量工程",
         "产品造型设计",
         "人力资源管理",
         "人文教育",
         "人物形象设计",
         "人类学",
         "仿真工程",
         "仿真科学与技术",
         "休闲体育",
         "休闲服务与管理",
         "会展艺术与技术",
         "会计",
         "会计与审计",
         "会计与统计核算",
         "传媒策划与管理",
         "传播学",
         "体育产业管理",
         "体育保健",
         "体育教育",
         "体育经济",
         "体育装备工程",
         "作战信息管理",
         "作物生产技术",
         "保险实务",
         "信息与计算科学",
         "信息传播与策划",
         "信息安全",
         "信息工程",
         "信息科学技术",
         "信息网络安全监察",
         "信息资源管理",
         "信用管理",
         "儿童康复",
         "光伏发电技术及应用",
         "光伏材料加工与应用技术",
         "光信息科学与技术",
         "光电信息工程",
         "光电子技术",
         "光电子技术科学",
         "公共事务管理",
         "公共关系学",
         "公共管理",
         "公路监理",
         "公路运输与管理",
         "兽医",
         "再生资源科学与技术",
         "军事外交",
         "农学",
         "农艺教育",
         "冶金工程",
         "冶金技术",
         "出版与发行",
         "出版与电脑编辑技术",
         "出版信息管理",
         "分子科学与工程",
         "刑事技术",
         "制冷与冷藏技术",
         "制冷与空调技术",
         "制药工程",
         "制造自动化与测控技术",
         "动画",
         "劳动与社会保障",
         "劳动关系",
         "勘查技术与工程",
         "包装工程",
         "包装技术与设计",
         "化学工程与工艺",
         "化学生物学",
         "化工与制药",
         "化工装备技术",
         "化工设备维修技术",
         "博物馆学",
         "卫生信息管理",
         "卫生检验",
         "印刷图文信息处理",
         "历史学",
         "哲学",
         "哲学类",
         "商务策划管理",
         "商务管理",
         "商务经纪与代理",
         "商务英语",
         "商品花卉",
         "商检技术",
         "园林",
         "园艺",
         "园艺技术",
         "国土资源管理",
         "国民经济管理",
         "国防工程与防护",
         "国际关系与安全",
         "国际商务",
         "国际政治",
         "国际文化贸易",
         "国际经济与贸易",
         "国际航运业务管理",
         "国际航运保险与公估",
         "国际金融",
         "图形图像制作",
         "图文信息技术",
         "土地资源管理",
         "土建类",
         "土木工程",
         "土木工程检测技术",
         "地下工程与隧道工程技术",
         "地下水科学与工程",
         "地图学与地理信息系统",
         "地球信息科学与技术",
         "地球化学",
         "地球物理勘查技术",
         "地球物理学",
         "地理信息系统",
         "地理信息系统与地图制图技术",
         "地理科学",
         "地籍测绘与土地管理信息技术",
         "地质学",
         "地质工程",
         "城市交通运输",
         "城市园林",
         "城市地下空间工程",
         "城市检测与工程技术",
         "城市水净化技术",
         "城市燃气工程技术",
         "城市管理",
         "城市规划",
         "城市轨道交通工程技术",
         "城市轨道交通控制",
         "城市轨道交通运营管理",
         "城镇规划",
         "基础医学",
         "基础医学基地班",
         "复合材料与工程",
         "复合材料加工与应用技术",
         "外交学",
         "多媒体设计与制作",
         "大气探测技术",
         "大气科学",
         "大气科学类",
         "天文学",
         "媒体创意",
         "学前教育",
         "安全工程",
         "安全防范技术",
         "审计实务",
         "室内装饰设计",
         "室内设计技术",
         "家具设计与制造",
         "家用纺织品设计",
         "导游",
         "导演",
         "导航工程",
         "小学教育",
         "展示设计",
         "岩土工程技术",
         "嵌入式技术与应用",
         "嵌入式系统工程",
         "工业分析与检验",
         "工业工程",
         "工业环保与安全技术",
         "工业设计",
         "工商企业管理",
         "工商管理",
         "工商行政管理",
         "工程力学",
         "工程地质勘查",
         "工程机械",
         "工程测量与监理",
         "工程测量技术",
         "工程物理",
         "工程监理",
         "工程管理",
         "工程造价",
         "工艺美术品设计与制作",
         "市场开发与营销",
         "市场营销",
         "市政工程技术",
         "广告与会展",
         "广告学",
         "广告设计与制作",
         "广播电视技术",
         "建筑学",
         "建筑工程技术",
         "建筑工程管理",
         "建筑电气工程技术",
         "建筑经济管理",
         "建筑钢结构工程技术",
         "影视多媒体技术",
         "影视艺术技术",
         "影视表演",
         "微生物技术及应用",
         "微电子学",
         "微电子技术",
         "心理咨询",
         "心理学",
         "思想政治教育",
         "总图设计与工业运输",
         "戏剧影视文学",
         "房地产经营与估价",
         "房地产经营管理",
         "投资与理财",
         "投资学",
         "护理",
         "护理学",
         "护理学类",
         "报关与国际货运",
         "指挥自动化工程",
         "探测制导与控制技术",
         "探测工程",
         "摄影",
         "摄影摄像技术",
         "摄影测量与遥感技术",
         "播音与主持艺术",
         "政治学",
         "政治学与行政学",
         "救助与打捞工程",
         "教育学",
         "教育技术学",
         "数字出版",
         "数字印刷技术",
         "数字媒体艺术",
         "数学与应用数学",
         "数控技术",
         "数控设备应用与维护",
         "文化产业管理",
         "文化市场经营与管理",
         "文物鉴定与修复",
         "文秘",
         "文秘教育",
         "新能源发电技术",
         "新能源应用技术",
         "新闻与传播",
         "新闻传播学类",
         "新闻学",
         "新闻采编与制作",
         "旅游工艺品设计与制作",
         "旅游管理",
         "旅游英语",
         "旅行社经营管理",
         "无损检测技术",
         "无机非金属材料工程",
         "无线电技术",
         "景区开发与管理",
         "景观学",
         "景观建筑设计",
         "景观设计",
         "智能科学与技术",
         "有机化工生产技术",
         "服装制版与工艺",
         "服装工艺技术",
         "服装营销与管理",
         "服装表演",
         "服装设计",
         "木材科学与工程",
         "机械制造与自动化",
         "机械工程及自动化",
         "机械电子工程",
         "机械类",
         "机械设计与制造",
         "机械设计制造及其自动化",
         "机电一体化技术",
         "机电设备维修与管理",
         "机电设备运行与维护",
         "材料化学",
         "材料工程技术",
         "材料成型与控制技术",
         "材料成型及控制工程",
         "材料物理",
         "材料科学与工程",
         "材料科学类",
         "档案学",
         "检测技术及应用",
         "森林工程",
         "植物保护",
         "植物科学与技术",
         "楼宇智能化工程技术",
         "模具设计与制造",
         "民航商务",
         "民航特种车辆维修",
         "民航运输",
         "汉语言文学",
         "汽车制造与装配技术",
         "汽车定损与评估",
         "汽车技术服务与营销",
         "汽车改装技术",
         "汽车整形技术",
         "汽车服务工程",
         "汽车检测与维修技术",
         "汽车电子技术",
         "汽车维修工程教育",
         "汽车运用与维修",
         "汽车运用技术",
         "治安管理",
         "法医学",
         "法学",
         "法学类",
         "法律事务",
         "法律文秘",
         "测控技术与仪器",
         "测绘与地理信息技术",
         "测绘与地质工程技术",
         "测绘工程",
         "测量工程",
         "海事管理",
         "海洋技术",
         "海洋生物资源与环境",
         "海洋科学",
         "海洋管理",
         "海洋经济学",
         "海洋药学",
         "消防工程",
         "消防工程技术",
         "涉外事务管理",
         "涉外旅游",
         "液压与气动技术",
         "港口业务管理",
         "港口工程技术",
         "港口电气技术",
         "游戏设计与制作",
         "游戏软件",
         "热能与动力工程",
         "热能动力设备与应用",
         "烹饪工艺与营养",
         "照明艺术",
         "版面编辑与校对",
         "物理学",
         "特殊教育",
         "特种动物养殖",
         "特许经营管理",
         "环境与安全类",
         "环境工程",
         "环境监测与评价",
         "环境科学",
         "环境科学与工程",
         "环境科学类",
         "环境艺术设计",
         "环境资源与发展经济学",
         "现代教育技术",
         "现代纺织技术",
         "珠宝首饰工艺及鉴定",
         "理论与应用力学",
         "生产过程自动化技术",
         "生化制药技术",
         "生态学",
         "生物信息学",
         "生物制药技术",
         "生物功能材料",
         "生物化工工艺",
         "生物医学工程",
         "生物实验技术",
         "生物工程",
         "生物科学类",
         "电子产品质量检测",
         "电子信息工程技术",
         "电子信息技术及仪器",
         "电子信息科学类",
         "电子商务",
         "电子工程",
         "电子科学与技术",
         "电子组装技术与设备",
         "电子设备与运行管理",
         "电机与电器",
         "电机电器智能化",
         "电梯工程技术",
         "电气信息工程",
         "电气信息类",
         "电气工程与智能控制",
         "电气工程与自动化",
         "电脑艺术设计",
         "电视制片管理",
         "电视节目制作",
         "眼视光学",
         "眼视光技术",
         "眼镜设计",
         "知识产权",
         "石油化工生产技术",
         "石油工程",
         "石油工程技术",
         "社会体育",
         "社会学",
         "社会工作",
         "社会救助",
         "社区康复",
         "社区管理与服务",
         "科学教育",
         "移动通信技术",
         "稀土工程",
         "税务",
         "空中乘务",
         "管理工程",
         "管理科学",
         "管理科学与工程类",
         "粉体材料科学与工程",
         "粮食工程",
         "精密机械技术",
         "精神医学",
         "精细化学品生产技术",
         "系统工程",
         "纺织工程",
         "经济信息管理",
         "经济学",
         "经济学基地班",
         "经济管理",
         "绘画",
         "给水排水工程",
         "统计学",
         "统计实务",
         "综合文科教育",
         "综合理科教育",
         "编导",
         "编辑出版学",
         "网络安全与执法",
         "网络工程",
         "网络数字媒体",
         "网络系统管理",
         "网络经济学",
         "美术学",
         "翻译",
         "能源与环境系统工程",
         "能源动力类",
         "能源动力系统及自动化",
         "能源工程及自动化",
         "自动化",
         "自动化生产设备应用",
         "舞蹈编导",
         "舞蹈表演",
         "航天运输与控制",
         "航海技术",
         "航空服务",
         "航空电子设备维修",
         "航空航天工程",
         "航运管理",
         "舰船与海洋工程",
         "舰船动力工程",
         "船机制造与维修",
         "船舶与海洋工程",
         "船舶工程技术",
         "船舶检验",
         "船舶电气工程技术",
         "艺术教育",
         "艺术设计",
         "英语",
         "草业科学",
         "药剂设备制造与维护",
         "药品经营与管理",
         "药品质量检测技术",
         "药物分析技术",
         "药物制剂",
         "药物制剂技术",
         "营养与食品卫生",
         "营养学",
         "营销与策划",
         "行政管理",
         "表演",
         "表演艺术",
         "装备经济管理",
         "装潢艺术设计",
         "装潢设计与工艺教育",
         "装饰艺术设计",
         "视觉传达艺术设计",
         "计算机信息管理",
         "计算机应用技术",
         "计算机教育",
         "计算机科学与技术",
         "计算机网络技术",
         "计算机软件",
         "计算机通信",
         "计算机音乐制作",
         "设施农业科学与工程",
         "证券与期货",
         "证券投资与管理",
         "财务会计教育",
         "财务信息管理",
         "财务管理",
         "财政",
         "质量与可靠性工程",
         "贸易经济",
         "资产评估",
         "资产评估与管理",
         "资源勘查工程",
         "资源环境与城市管理",
         "资源环境科学",
         "车辆工程",
         "轮机工程",
         "软件工程",
         "软件技术",
         "轻化工程",
         "辐射防护与环境工程",
         "过程装备与控制工程",
         "运动人体科学",
         "运动康复与健康",
         "通信工程",
         "通信工程设计与施工",
         "通信技术",
         "都市园艺",
         "酒店管理",
         "采矿工程",
         "采购管理",
         "金属材料与热处理技术",
         "金属材料工程",
         "金融与证券",
         "金融保险",
         "金融学",
         "金融工程",
         "金融管理与实务",
         "针织品工艺与贸易",
         "针织技术与针织服装",
         "钢结构建造技术",
         "钻井技术",
         "钻探技术",
         "铁道工程技术",
         "集成电路设计与集成系统",
         "集装箱运输管理",
         "音乐学",
         "音乐教育",
         "音乐表演",
         "音像技术",
         "项目管理",
         "预防医学",
         "风景园林",
         "风能与动力工程",
         "风能与动力技术",
         "飞机制造技术",
         "飞行技术",
         "食品加工技术",
         "食品质量与安全",
         "食品质量与安全监管",
         "餐饮管理与服务",
         "高分子材料与工程",
        ].uniq.sort.each do |name|
          pp name
          Major.create! name: name
        end
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
