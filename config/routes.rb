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
  post 'members/send_sms_code',  to: 'members#send_sms_code'
  post 'members/bind_cell', to: 'members#bind_cell'
  post 'members/bind_sat', to: 'members#bind_sat'

  #messages
  post 'messages/list', to:'messages#message_list'
  post 'messages/batch_send_messages', to: 'messages#batch_send_messages'
  post 'messages/ask_message', to: 'messages#ask_message'
  get 'messages/show'
  get 'messages/load_options/', to:'messages#load_options'

  #stories
  get 'stories/show'
  get 'stories/list/:dsin',  to: 'stories#list'
  post 'stories/create_story',  to: 'stories#create_story'

  #universities
  get 'universities/list', to: 'universities#university_list'
  get 'universities/:dsin/major_list', to: 'universities#major_list'

  #新建专业
  post 'universities/create_major', to: 'universities#create_major'

  #users
  get 'users/student_list', to: 'users#student_list'

end
