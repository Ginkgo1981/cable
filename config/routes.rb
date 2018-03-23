Rails.application.routes.draw do

  get 'exams/group_statistics', to: 'exams#group_statistics'
  get 'exams/score_result_statistics', to: 'exams#score_result_statistics'
  get 'exams/get_rand_exam', to: 'exams#get_rand_exam'
  get 'exams/get_user_exam/:user_exam_id', to: 'exams#get_user_exam'
  get 'exams/get_user_exams', to: 'exams#get_user_exams'
  post 'exams/review', to: 'exams#review'
  post 'exams/save_exam_answers', to: 'exams#save_exam_answers'

  get 'books/get_lesson_terms/:date', to: 'books#get_lesson_terms'
  get 'books/get_mine_talk_topic', to: 'books#get_mine_talk_topic'
  get 'books/lessons_group_statistics', to: 'books#lessons_group_statistics'
  get 'books/get_talk_topic', to: 'books#get_talk_topic'
  get 'books/get_talk_thread/:thread_id', to: 'books#get_talk_thread'

  #books
  get 'books/get_translation/:word', to: 'books#get_translation'
  post 'books/buy_production/:production_id', to: 'books#buy_production'
  get 'books/get_production/:production_id', to: 'books#get_production'
  get 'books/get_lesson/:date', to: 'books#get_lesson'
  get 'books/get_books', to: 'books#get_books'
  get 'books/get_book_productions', to: 'books#get_book_productions'
  get 'books/get_schedules', to: 'books#get_schedules'
  get 'books/get_questions/:user_lesson_id', to: 'books#get_questions'
  post 'books/save_answers/:user_lesson_id', to: 'books#save_answers'

  get 'members/get_reading_stats', to: 'members#get_reading_stats'
  get 'members/get_web_share_info/:user_id', to: 'members#get_web_share_info'

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


  get 'tags/tag_list'
  #members
  post 'members/upload_form_id', to: 'members#upload_form_id'

  post 'members/daily_checkin', to: 'members#daily_checkin'
  post 'members/reward_share_wechat_moment', to: 'members#reward_share_wechat_moment'
  get 'members/points_activities', to: 'members#points_activities'
  post 'members/recognize', to: 'members#recognize'
  post 'members/bind_hr_info', to: 'members#bind_hr_info'
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

  #campaigns
  get 'campaigns/my_campaigns', to: 'campaigns#my_campaigns'
  get 'campaigns/list', to: 'campaigns#list'
  get 'campaigns/share_settings', to: 'campaigns#share_settings'
  get 'campaigns/get_bucket_item/:id', to: 'campaigns#get_bucket_item'
  get 'campaigns/get_lesson/:lesson_id', to: 'campaigns#get_lesson'
  get 'campaigns/get_lesson_terms/:lesson_id', to: 'campaigns#get_lesson_terms'


  get 'campaigns/get_questions/:lesson_id', to: 'campaigns#get_questions'
  get 'campaigns/get_schedules/:campaign_id', to: 'campaigns#get_schedules'
  post 'campaigns/finish_lesson', to: 'campaigns#finish_lesson'
  get 'campaigns/get_lesson_by_date/:date', to: 'campaigns#get_lesson_by_date'

  get 'campaigns/get_campaign_index/:id', to: 'campaigns#get_campaign_index'
  get 'campaigns/get_campaign_members/:id', to: 'campaigns#get_campaign_members'
  get 'campaigns/get_campaign_activities/:id', to: 'campaigns#get_campaign_activities'



  get 'campaigns/get_promotion_campaign/:id', to: 'campaigns#get_promotion_campaign'
  post 'campaigns/buy_campaign/:id', to: 'campaigns#buy_campaign'


  #students
  # get 'students/followed_by_students/:dsin', to: 'students#followed_by_students'

  #campaigns / skycodes
  # get 'campaigns/campaign_list/:dsin', to: 'campaigns#campaign_list'
  # post 'comment_wishcard/:id', to: 'members#comment_wishcard'
  get 'wishcards/:group_id', to: 'cards#wishcards'

end
