Rails.application.routes.draw do

  #books
  post 'books/buy_production/:production_id', to: 'books#buy_production'
  get 'books/get_production/:production_id', to: 'books#get_production'
  get 'books/get_lesson/:date', to: 'books#get_lesson'
  get 'books/get_books', to: 'books#get_books'
  get 'books/get_book_productions', to: 'books#get_book_productions'
  get 'books/get_schedules', to: 'books#get_schedules'
  get 'books/get_questions/:user_lesson_id', to: 'books#get_questions'
  post 'books/save_answers/:user_lesson_id', to: 'books#save_answers'


  get 'books/get_user_lesson', to: 'books#get_user_lesson'
  get 'books/get_word_list', to: 'books#get_word_list'

  get 'hr/resumes', to: 'hr#resumes'
  post 'hr/receive_resume', to: 'hr#receive_resume'

  get 'wechats/echo', to: 'wechats#echo'
  post 'wechats/echo', to: 'wechats#echo'
  post 'wechats/get_js_signature', to: 'wechats#get_js_signature'

  get 'wechats/mini_app_customer_service', to: 'wechats#mini_app_customer_service'
  post 'wechats/mini_app_customer_service', to: 'wechats#mini_app_customer_service'

  get 'wechats/mini_app_customer_service_zhaopin', to: 'wechats#mini_app_customer_service_zhaopin'
  post 'wechats/mini_app_customer_service_zhaopin', to: 'wechats#mini_app_customer_service_zhaopin'


  #messages
  post 'messages/create_point_message_send_to_all_online_users', to: 'messages#create_point_message_send_to_all_online_users'
  post 'messages/notification_message_list', to: 'messages#notification_message_list'
  post 'messages/save_then_redis_all', to: 'messages#save_then_redis_all'
  post 'messages/create_notification_message', to: 'messages#create_notification_message'
  delete 'messages/:id', to: 'messages#delete_message'

  #photos
  get '/photos/uptoken', to: 'photos#get_upload_token'
  get '/photos/get_photos', to: 'photos#get_photos'
  post 'photos/save_photo', to: 'photos#save_photo'
  post 'photos/save_photo_by_url', to: 'photos#save_photo_by_url'

  #users
  delete '/users/:id', to: 'users#delete_user'
  delete '/hrs/:id', to: 'users#delete_hr'
  get '/users/hrs/:page', to: 'users#get_hr_list'
  get '/users/hrs/:id', to: 'users#get_hr'
  get '/users/students/:page', to: 'users#get_student_list'
  get '/users/student/:id', to: 'users#get_student'

  post '/users/hrs/:id',to: 'users#update_hr'

  #stories
  get 'stories/get_story/:id', to: 'stories#get_story'
  get 'stories/list/', to: 'stories#list'
  post 'stories/update_story/:id', to: 'stories#update_story'
  post 'stories/create_story', to: 'stories#create_story'
  post 'stories/delete_story/:id', to: 'stories#delete_story'

  #resources

  get 'list_1', to: 'resources#list_1'
  get 'list_2', to: 'resources#list_2'


  get 'tags_list', to: 'resources#tags_list'
  get 'filtered_university_list', to: 'resources#filtered_university_list'
  get 'university_list', to: 'resources#university_list'
  get 'city_list', to: 'resources#city_list'
  get 'major_list', to: 'resources#major_list'
  get 'job_list', to: 'resources#job_list'
  get 'industry_list', to: 'resources#industry_list'
  get 'honor_list', to: 'resources#honor_list'
  get 'skill_list', to: 'resources#skill_list'
  get 'experience_title_list', to: 'resources#experience_title_list'

  #jobs

  get 'jobs/redis/:key', to: 'jobs#get_by_redis_key'
  get 'jobs/distributions', to: 'jobs#distributions'
  get 'jobs/list/:site/:page', to: 'jobs#list'
  post 'jobs/update/:id', to: 'jobs#update_job'
  get 'jobs/:id', to: 'jobs#get_job'
  get 'companies/:id', to: 'jobs#get_company'

  #resume
  get 'resumes/:resume_id/show_intention', to: 'resumes#show_intention'
  post 'resumes/:resume_id/save_intention', to: 'resumes#save_intention'

  # post 'resumes/create_resume', to: 'resumes#create_resume'
  get 'resumes/my_resumes', to: 'resumes#my_resumes'
  get 'resumes/show_component/:type/:id', to: 'resumes#show_component'
  post 'resumes/delete_component/:type/:id', to: 'resumes#delete_component'
  post 'resumes/:resume_id/save_component/:type', to: 'resumes#save_component'
  get 'resumes/:resume_id', to: 'resumes#get_resume'


  #dsin photo
  #dsin
  # get 'dsin/:dsin', to: 'dsins#show'
  # get 'format_show/:dsin', to: 'dsins#format_show'
  # get 'get_resume_by_dsin/:dsin', to: 'dsins#get_resume_by_dsin'
  # post 'dsin/:dsin', to: 'dsins#update'
  # delete 'dsin/:dsin', to: 'dsins#delete'
  #dsin tags
  # get 'dsin/:dsin/tags', to: 'dsins#tags'
  # post 'dsin/:dsin/tag', to: 'dsins#tag'
  get 'tags/tag_list'
  #members
  post 'members/bind_hr_info', to: 'members#bind_hr_info'
  post 'members/read_business_card', to: 'members#read_business_card'
  post 'members/wechat_open_authorization', to: 'members#wechat_open_authorization'
  post 'members/mini_app_authorization', to: 'members#mini_app_authorization'
  post 'members/mini_app_authorization_teacher', to: 'members#mini_app_authorization_teacher'
  post 'members/wechat_group', to: 'members#wechat_group'
  post 'members/wechat_phone', to: 'members#wechat_phone'
  post 'members/update_profile', to: 'members#update_profile'

  get 'members/invitees', to: 'members#invitees'
  post 'members/deliver_resume_to_email', to: 'members#deliver_resume_to_email'
  post 'members/applying_job', to: 'members#applying_job'
  get 'members/applied_jobs', to: 'members#applied_jobs'
  get 'members/:job_id/is_applied', to: 'members#is_applied'


  post 'members/send_sms_code', to: 'members#send_sms_code'
  post 'members/bind_cell', to: 'members#bind_cell'
  post 'members/bind_sat', to: 'members#bind_sat'


  #bookmark
  post 'members/:job_id/bookmarking_job', to: 'members#bookmarking_job'
  get 'members/:job_id/is_bookmarked', to: 'members#is_bookmarked'
  get  'members/bookmarked_jobs', to: 'members#bookmarked_jobs'



  ##follow
  post 'members/follow/:dsin', to: 'members#follow'

  # 我在追 followings
  get 'following_teachers', to: 'members#following_teachers'
  get 'following_universities', to: 'members#following_universities'
  get 'following_students', to: 'members#following_students'
  get 'following_skycodes', to: 'members#following_skycodes'


  # 追我的 followed_bys
  get 'followed_by_students/:dsin', to: 'dsins#followed_by_students'
  get 'followed_by_teachers/:dsin', to: 'dsins#followed_by_teachers'
  get 'followed_by_universities/:dsin', to: 'dsins#followed_by_universities'


  #likings

  get 'likings/:dsin', to: 'dsins#likings'
  post 'like_comment/:dsin', to: 'members#like_comment'



  post 'messages/batch_send_messages', to: 'messages#batch_send_messages'
  post 'messages/send_point_message', to: 'messages#send_point_message'
  # post 'messages/send_notification_message', to: 'messages#send_notification_message'
  post 'messages/send_subscription_message', to: 'messages#send_subscription_message'
  get 'messages/show'

  #stories
  get 'stories/show'
  get 'stories/list/', to: 'stories#list'
  post 'stories/create_story', to: 'stories#create_story'

  #universities
  # get 'universities/list', to: 'universities#university_list'
  # get 'universities/:dsin/major_list', to: 'universities#major_list'
  # get 'universities/:dsin', to: 'universities#show'

  #新建专业
  # post 'universities/create_major', to: 'universities#create_major'

  #students
  # get 'students/followed_by_students/:dsin', to: 'students#followed_by_students'


  #campaigns / skycodes
  # get 'campaigns/campaign_list/:dsin', to: 'campaigns#campaign_list'
  # get 'campaigns/skycode_list/:dsin', to: 'campaigns#skycode_list'


  #scan
  # post 'campaigns/scan_skycode/:dsin', to: 'campaigns#scan_skycode'

  #change skycode, set naem
  # post 'update_skycode/:dsin', to: 'campaigns#update_skycode'

  # #scan skycodes
  # post 'campaigns/student_scan_skycode', to: 'campaigns#student_scan_skycode'
  # post 'campaigns/teacher_scan_skycode', to: 'campaigns#teacher_scan_skycode'

  # post 'comment_wishcard/:id', to: 'members#comment_wishcard'
  get 'wishcards/:group_id', to: 'cards#wishcards'

end
