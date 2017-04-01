Rails.application.routes.draw do

  get 'dsin/:dsin', to: 'units#dsin'

  post 'tags/tag'
  get 'tags/tags'
  get 'tags/tag_list'

  # post 'users/register', to: 'users#register'
  # post 'users/send_sms_auth_code', to: 'users#send_sms_auth_code'
  # post 'users/tag', to: 'users#tag'
  # get 'users/list/:identity_type', to: 'users#list'
  # get 'users/:user_id', to: 'users#user_detail'
  # get 'users/student_detail/:student_id', to: 'users#student_detail'



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


  resources :users do

    # member do
    #   get 'student_detail'
    # end

    collection do
      get :student_list
      # get 'student_detail/:dsin', to: 'users#student_detail'
    end


  end


end
