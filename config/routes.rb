Rails.application.routes.draw do

  #dsin photo
  get 'dsin/uptoken', to: 'dsins#get_upload_token'
  get 'dsin/:dsin/photos', to: 'dsins#get_photos'
  post 'dsin/:dsin/save_photo', to: 'dsins#save_photo'

  #dsin
  get 'dsin/:dsin', to: 'dsins#show'
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
  post 'members/update_teacher',  to: 'members#update_teacher'


  post 'members/send_sms_code',  to: 'members#send_sms_code'
  post 'members/bind_cell', to: 'members#bind_cell'
  post 'members/bind_sat', to: 'members#bind_sat'

  ##follow
  post 'members/follow/:dsin', to: 'members#follow'
  get  'members/followings',  to: 'members#followings'

  #messages
  post 'messages/list', to:'messages#message_list'
  post 'messages/batch_send_messages', to: 'messages#batch_send_messages'
  post 'messages/send_message', to: 'messages#send_message'
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
  get 'students/student_list/:dsin', to: 'students#student_list'


  #campaigns / skycodes
  get  'campaigns/campaign_list/:dsin', to: 'campaigns#campaign_list'
  get  'campaigns/skycode_list/:dsin', to:  'campaigns#skycode_list'
  post 'campaigns/binding_skycode/:dsin', to:  'campaigns#binding_skycode'


  #scan skycodes
  post 'campaigns/student_scan_skycode', to: 'campaigns#student_scan_skycode'
  post 'campaigns/teacher_scan_skycode', to: 'campaigns#teacher_scan_skycode'


end
