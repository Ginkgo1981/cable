class Cambridge


  def initialize
    # @driver = Selenium::WebDriver.for :remote, desired_capabilities: :phantomjs
    @driver = nil
    @@machanize_agent = nil
  end


  def web_agent
    if @@machanize_agent.nil?
      @@machanize_agent = Mechanize.new
      @@machanize_agent.user_agent = "Windows Mozilla"
    end
    @@machanize_agent
  end

  def trans(article_url=nil)
    reg = /\s|\:|\,|\.|\"|\'|\?/
    article_url = 'https://www.freechildrenstories.com/guardians-of-lore'
    page = web_agent.get article_url
    doc = Nokogiri::HTML(page.body)
    terms = doc.css('#page').text.split(reg).select{|term| term.present?}.uniq
    # s = 'little'
    # terms = s.split(' ')
    puts "================== terms: #{terms.size} ========="
    terms.each do |item|
      item = item.strip.downcase.singularize
      if $redis.sismember 'terms', item
        puts '==== duplicate ======='
      else
        puts '==== new ======='
        $redis.sadd 'terms', item
        self.get_term("https://dictionary.cambridge.org/zhs/%E8%AF%8D%E5%85%B8/%E8%8B%B1%E8%AF%AD-%E6%B1%89%E8%AF%AD-%E7%AE%80%E4%BD%93/#{item}")
      end
    end
  end


  def get_term(url)

    begin
      page = web_agent.get url
      doc = Nokogiri::HTML(page.body)
      term = doc.css('.pos-header .headword .hw')[0].text
      puts "==== term: #{term}"
      ctype = doc.css('.posgram.ico-bg .pos')[0].text
      pronounce = doc.css('.pron-info .pron')[0].text
      audio_origin = doc.css('.pron-info .uk span')[1].attr('data-src-mp3')
      level = doc.css('.sense-body .def-block .def-info span')[0].text
      definition_en = doc.css('.sense-body .def-block .def')[0].text
      definition_cn = doc.css('.sense-body .def-block .trans')[0].text.strip
      term = Term.create! word: term,
                          ctype: ctype,
                          pronounce: pronounce,
                          audio_origin: audio_origin,
                          level: level,
                          definition_cn: definition_cn,
                          definition_en: definition_en
      egs = doc.css('.sense-body .examp.emphasized')
      egs.each_with_index do |eg, idx|
        en = eg.css('span')[0].text.strip
        cn = eg.css('span')[-1].text.strip
        puts "en: #{en} zh:#{cn}"
        term.sentances.create! en: en,
                               zh: cn,
                               ord: idx
      end
    rescue Exception => err
      puts err
    end
  end
end
