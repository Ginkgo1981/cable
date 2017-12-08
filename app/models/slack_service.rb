class SlackService
  def self.alert(text, channel = nil)
    # url = ''
    # if channel.nil?
    #   url = 'https://hooks.slack.com/services/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'
    # end

    #大四小冰
    # https://hooks.slack.com/services/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

    #小冰招聘
    # https://hooks.slack.com/services/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
    # payload = {
    #     text: "#{Time.now.to_s} - #{text}"
    # }
    # res = Faraday.post url, JSON.generate(payload)
    # puts "[SlackService] alert res: #{res.body}"
    puts "[SlackService] alert res: #{Time.now.to_s} - #{text}"
  end
end