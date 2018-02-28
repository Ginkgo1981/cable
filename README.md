bundle exec puma -e production

redis-cli -h loop

zcount crawler:link_queue -inf +inf


bundle exec rake channel:enqueue_channels > /mnt/logs/enqueue_channels.log 2>&1
bundle exec rake channel:enqueue_links > /mnt/logs/enqueue_links.log 2>&1
bundle exec rake channel:fetch_and_enqueue_company_job_json > /mnt/logs/fetch_and_enqueue_company_job_json.log 2>&1


bundle exec rake channel:index_to_elasticsearch > /mnt/logs/index_to_elasticsearch.log 2>&1



redis-cli KEYS crawler* | xargs redis-cli DEL


User.all.map{|u| [u.id, u.nickname, u.miniapp_openid]}


user = User.find_by miniapp_openid: "oPMr70AgRUYghDVmLjma09r_6ZRw"
user.delete

user = User.find_by miniapp_openid: "oPMr70L0uE_Uco7CxflksMl9Atw8"

    # 
    curl -F media=@qrcode-baicao-group.png "https://api.weixin.qq.com/cgi-bin/media/upload?access_token=7_nMuM95h6h_qU0hlBIoPQcpWCVGJs0Q8X4Yf44N3n1ZSCOTRDCgvu3dhjwWpT_Y4laJxYtI6nZc6EMTaWmOx1L9tO_1VeNzfie7SwXTV6lWxPpKvrdKEsHCLgzxhRnJ2_YecokwQEtH3owvxXKZHhABATIQ&type=image"


staff = User.find_by union_id: "oX-css7dRwNFTHWrTCVTj1d0agFk"


bundle exec sidekiq -C config/sidekiq.yml



watch -n 1 'netstat -na | grep 3000'

sudo  tcpdump -i lo 'port 3000'


TalkTopic.create! talk_date: '2018-03-05', content: h[:content], chinese: h[:note], audio_url: "http://audios.gaokao2017.cn/talk-2018-03-05.mp3"





