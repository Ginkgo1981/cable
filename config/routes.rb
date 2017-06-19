Rails.application.routes.draw do

  #dsin photo
  get 'dsin/uptoken', to: 'dsins#get_upload_token'
  get 'dsin/:dsin/photos', to: 'dsins#get_photos'
  post 'dsin/:dsin/save_photo', to: 'dsins#save_photo'

  #dsin
  get 'dsin/:dsin', to: 'dsins#show'
  get 'format_show/:dsin', to: 'dsins#format_show'
  post 'dsin/:dsin', to: 'dsins#update'
  delete 'dsin/:dsin', to: 'dsins#delete'


  #dsin tags
  get 'dsin/:dsin/tags', to: 'dsins#tags'
  post 'dsin/:dsin/tag', to:'dsins#tag'
  get 'tags/tag_list'

  #members
  post 'members/wechat_open_authorization',  to: 'members#wechat_open_authorization'
  post 'members/mini_app_authorization',  to: 'members#mini_app_authorization'
  post 'members/mini_app_authorization_teacher',  to: 'members#mini_app_authorization_teacher'

  post 'members/wechat_group', to: 'members#wechat_group'


  post 'members/update_teacher',  to: 'members#update_teacher'


  post 'members/send_sms_code',  to: 'members#send_sms_code'
  post 'members/bind_cell', to: 'members#bind_cell'
  post 'members/bind_sat', to: 'members#bind_sat'

  post 'members/create_wishcard', to: 'members#create_wishcard'
  post 'members/forward_wishcard/:dsin', to: 'members#forward_wishcard'

  ##follow
  post 'members/follow/:dsin', to: 'members#follow'

  # 我在追 followings
  get  'following_teachers',  to: 'members#following_teachers'
  get  'following_universities',  to: 'members#following_universities'
  get  'following_students',  to: 'members#following_students'
  get  'following_skycodes',  to: 'members#following_skycodes'



  # 追我的 followed_bys
  get  'followed_by_students/:dsin',  to: 'dsins#followed_by_students'
  get  'followed_by_teachers/:dsin',  to: 'dsins#followed_by_teachers'
  get  'followed_by_universities/:dsin',  to: 'dsins#followed_by_universities'



  #likings

  get 'likings/:dsin', to: 'dsins#likings'
  post 'like_comment/:dsin', to: 'members#like_comment'



  #messages
  post 'messages/list', to:'messages#message_list'
  post 'messages/batch_send_messages', to: 'messages#batch_send_messages'
  post 'messages/send_point_message', to: 'messages#send_point_message'
  post 'messages/send_notification_message', to: 'messages#send_notification_message'
  post 'messages/send_subscription_message', to: 'messages#send_subscription_message'
  get 'messages/show'

  #stories
  get 'stories/show'
  get 'stories/list/:dsin',  to: 'stories#list'
  post 'stories/create_story',  to: 'stories#create_story'

  #universities
  get 'universities/list', to: 'universities#university_list'
  get 'universities/:dsin/major_list', to: 'universities#major_list'
  get 'universities/:dsin', to: 'universities#show'

  #新建专业
  post 'universities/create_major', to: 'universities#create_major'

  #students
  get 'students/followed_by_students/:dsin', to: 'students#followed_by_students'


  #campaigns / skycodes
  get  'campaigns/campaign_list/:dsin', to: 'campaigns#campaign_list'
  get  'campaigns/skycode_list/:dsin', to:  'campaigns#skycode_list'



  #scan
  post 'campaigns/scan_skycode/:dsin', to:  'campaigns#scan_skycode'

  #change skycode, set naem
  post 'update_skycode/:dsin', to:  'campaigns#update_skycode'

  # #scan skycodes
  # post 'campaigns/student_scan_skycode', to: 'campaigns#student_scan_skycode'
  # post 'campaigns/teacher_scan_skycode', to: 'campaigns#teacher_scan_skycode'



  # post 'comment_wishcard/:id', to: 'members#comment_wishcard'
  get 'wishcards/:group_id', to: 'cards#wishcards'



  #资源库
  get 'university_dsin_list', to: 'universities#university_dsin_list'
  get 'city_dsin_list', to: 'universities#city_dsin_list'
  get 'major_dsin_list', to: 'universities#major_dsin_list'


end
