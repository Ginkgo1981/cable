Rails.application.routes.draw do

  #dsin
  get 'dsin/:dsin', to: 'dsins#show'
  post 'dsin/:dsin', to: 'dsins#update'
  delete 'dsin/:dsin', to: 'dsins#delete'

  #dsin photo
  get 'dsin/uptoken', to: 'dsins#get_upload_token'
  get 'dsin/:dsin/photos', to: 'dsins#get_photos'
  post 'dsin/:dsin/save_photo', to: 'dsins#save_photo'


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
  get 'messages/message_list', to:'messages#list'
  get 'messages/show'
  get 'messages/load_options/', to:'messages#load_options'
  post 'messages/send_message', to: 'messages#send_message'

  # get 'messages/:dsin/received_messages', to: 'messages#received_messages'
  # get 'messages/:dsin/sended_messages', to: 'messages#sended_messages'

  #stories
  get 'stories/show'
  get 'stories/list'
  post 'stories/create_story',  to: 'stories#create_story'

  #universities
  get 'universities/list', to: 'universities#list'
  get 'universities/:dsin/major_list', to: 'universities#major_list'

  #users
  get 'users/student_list', to: 'users#student_list'

end
