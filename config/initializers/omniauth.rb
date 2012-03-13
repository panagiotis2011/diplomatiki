Rails.application.config.middleware.use OmniAuth::Builder do
require 'openid/store/filesystem'

  provider :twitter, 'HWeGxTH2ysMmPnQUhbsQg', 'ud2YQ1u9PByzQsfGE2OF2khrC3vR4RIw6Oxpju5b948', {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
  #provider :twitter, 'M3IMKhfAI2AdHx8ZQ5GXw', 'eWEAdm1uBneZgr4zHGCm04ywgzqMVTonkySZU1JiDLI', {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
  provider :facebook, '241098305977064', '3da066f5216ff5833ee821d9c8764fb8'
  #provider :facebook, '303767306344343', '11193324352b3c009165ca20030e3ae2',
  #        {:scope => 'PERMISSION_1, PERMISSION_2, PERMISSION_3...', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}}
  provider :github, 'CLIENT ID', 'SECRET', {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
  provider :openid, :store => OpenID::Store::Filesystem.new('./tmp'), :name => 'openid'
  provider :openid, :store => OpenID::Store::Filesystem.new('./tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :openid, :store => OpenID::Store::Filesystem.new('./tmp'), :name => 'yahoo', :identifier => 'yahoo.com'

end
