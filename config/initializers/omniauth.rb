Rails.application.config.middleware.use OmniAuth::Builder do
require 'openid/store/filesystem'

  provider :github, 'CLIENT ID', 'SECRET', {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
  provider :openid, :store => OpenID::Store::Filesystem.new('./tmp'), :name => 'openid'
  provider :openid, :store => OpenID::Store::Filesystem.new('./tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :openid, :store => OpenID::Store::Filesystem.new('./tmp'), :name => 'yahoo', :identifier => 'yahoo.com'

  if Rails.env.production?
     provider :twitter, 'M3IMKhfAI2AdHx8ZQ5GXw', 'eWEAdm1uBneZgr4zHGCm04ywgzqMVTonkySZU1JiDLI'
     provider :facebook, '303767306344343', '11193324352b3c009165ca20030e3ae2', :scope => 'offline_access,publish_stream,manage_pages,user_about_me,friends_about_me,user_activities,friends_activities,user_birthday,friends_birthday,user_checkins,friends_checkins,user_education_history,friends_education_history,user_events,friends_events,user_groups,friends_groups,user_hometown,friends_hometown,user_interests,friends_interests,user_likes,friends_likes,user_location,friends_location,user_notes,friends_notes,user_online_presence,friends_online_presence,user_photo_video_tags,friends_photo_video_tags,user_photos,friends_photos,user_questions,friends_questions,user_relationships,friends_relationships,user_relationship_details,friends_relationship_details,user_religion_politics,friends_religion_politics,user_status,friends_status,user_videos,friends_videos,user_website,friends_website,user_work_history,friends_work_history,email,read_friendlists,read_insights,read_mailbox,read_requests,read_stream,xmpp_login,ads_management,create_event,manage_friendlists,manage_notifications,publish_checkins,rsvp_event,publish_actions,user_subscriptions', :client_options => {:ssl => {:ca_file => "/etc/ssl/certs"}}

  elsif Rails.env.development?
     provider :twitter, 'HWeGxTH2ysMmPnQUhbsQg', 'ud2YQ1u9PByzQsfGE2OF2khrC3vR4RIw6Oxpju5b948'
     provider :facebook, '241098305977064', '3da066f5216ff5833ee821d9c8764fb8', :scope => 'offline_access,publish_stream,manage_pages,user_about_me,friends_about_me,user_activities,friends_activities,user_birthday,friends_birthday,user_checkins,friends_checkins,user_education_history,friends_education_history,user_events,friends_events,user_groups,friends_groups,user_hometown,friends_hometown,user_interests,friends_interests,user_likes,friends_likes,user_location,friends_location,user_notes,friends_notes,user_online_presence,friends_online_presence,user_photo_video_tags,friends_photo_video_tags,user_photos,friends_photos,user_questions,friends_questions,user_relationships,friends_relationships,user_relationship_details,friends_relationship_details,user_religion_politics,friends_religion_politics,user_status,friends_status,user_videos,friends_videos,user_website,friends_website,user_work_history,friends_work_history,email,read_friendlists,read_insights,read_mailbox,read_requests,read_stream,xmpp_login,ads_management,create_event,manage_friendlists,manage_notifications,publish_checkins,rsvp_event,publish_actions,user_subscriptions', :client_options => {:ssl => {:ca_file => "/etc/ssl/certs"}}
   #        {:scope => 'PERMISSION_1, PERMISSION_2, PERMISSION_3...', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}}
  end
end