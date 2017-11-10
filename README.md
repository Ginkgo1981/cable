

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

    # curl -F media=@098.jpg "https://api.weixin.qq.com/cgi-bin/media/upload?access_token=uPo6SZniYyUJ2cq-RZqkzMqiHL982fQtwoZsgDWBeEZa9L784VR6zr_L20GZeNexPMUg6rh-vHFjRRi9JfrvlP-SpjpP28QiQ6p3TIEMs7gQKFcAHAJDY&type=image"


staff = User.find_by union_id: "oX-css7dRwNFTHWrTCVTj1d0agFk"