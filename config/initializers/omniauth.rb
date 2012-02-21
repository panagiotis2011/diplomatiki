Rails.application.config.middleware.use OmniAuth::Builder do
  require 'openid/store/filesystem'

  provider :twitter, 'HWeGxTH2ysMmPnQUhbsQg', 'ud2YQ1u9PByzQsfGE2OF2khrC3vR4RIw6Oxpju5b948'
  provider :facebook, '241098305977064', '3da066f5216ff5833ee821d9c8764fb8'
  provider :github, 'CLIENT ID', 'SECRET'
  provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
end
