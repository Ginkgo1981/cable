Rails.application.routes.draw do

  get 'messages/list'

  get 'messages/show'

  get 'stories/show'

  get 'stories/list'
  post 'stories/create_story',  to: 'stories#create_story'

  get 'admins/show'
  post 'users/register', to: 'users#register'
  post 'users/send_sms_auth_code', to: 'users#send_sms_auth_code'
  get 'users/user_list', to: 'users#user_list'
  get 'users/:user_id', to: 'users#user_detail'
  post 'messages/send_point_message', to: 'messages#send_point_message'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
