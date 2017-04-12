Rails.application.routes.draw do

  get 'dsin/uptoken', to: 'dsins#get_upload_token'

  get 'dsin/:dsin', to: 'dsins#show'
  post 'dsin/:dsin', to: 'dsins#update'
  post 'dsin/:dsin/tag', to:'dsins#tag'
  get 'dsin/:dsin/tags', to: 'dsins#tags'

  post 'dsin/:dsin/save_photo', to: 'dsins#save_photo'
  get 'dsin/:dsin/photos', to: 'dsins#get_photos'

  get 'tags/tag_list'
  delete 'dsin/:dsin', to: 'dsins#delete'

  # post 'users/register', to: 'users#register'
  # post 'users/send_sms_auth_code', to: 'users#send_sms_auth_code'
  # post 'users/tag', to: 'users#tag'
  # get 'users/list/:identity_type', to: 'users#list'
  # get 'users/:user_id', to: 'users#user_detail'
  # get 'users/student_detail/:student_id', to: 'users#student_detail'

  post 'members/wechat_open_authorization',  to: 'members#wechat_open_authorization'
  post 'members/send_sms_code',  to: 'members#send_sms_code'
  # post 'members/login_with_wechat_code',  to: 'members#login_with_wechat_code'


  get 'messages/list/:type', to:'messages#list'
  get 'messages/show'
  get 'messages/load_options/', to:'messages#load_options'


  get 'stories/show'
  get 'stories/list'
  post 'stories/create_story',  to: 'stories#create_story'

  get 'admins/show'
  post 'messages/send_message', to: 'messages#send_message'


  get 'universities/list', to: 'universities#list'
  get 'universities/:dsin/major_list', to: 'universities#major_list'


  resources :users do
    collection do
      get :student_list
    end
  end


end
