Rails.application.routes.draw do

  post 'users/register', to: 'users#register'
  post 'users/send_sms_auth_code', to: 'users#send_sms_auth_code'
  get 'users/list/:identity_type', to: 'users#list'
  get 'users/:user_id', to: 'users#user_detail'


  get 'messages/list/:type', to:'messages#list'
  get 'messages/show'
  get 'messages/load_options/', to:'messages#load_options'


  get 'stories/show'
  get 'stories/list'
  post 'stories/create_story',  to: 'stories#create_story'

  get 'admins/show'
  post 'messages/send_message', to: 'messages#send_message'
  get 'universities/list', to: 'universities#list'
  get 'universities/:id', to: 'universities#show'

end
