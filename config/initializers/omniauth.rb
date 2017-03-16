OmniAuth.config.logger = Rails.logger

SERVICES = YAML.load(File.open("#{::Rails.root}/config/oauth.yml").read)

Rails.application.config.middleware.use OmniAuth::Builder do
  require 'openid/store/filesystem'
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  provider :openid, store: OpenID::Store::Filesystem.new('/tmp')

  provider :developer unless Rails.env.production?
  provider :github, SERVICES['github']['key'], SERVICES['github']['secret'] # if SERVICES['github']
  provider :twitter, SERVICES['twitter']['key'], SERVICES['twitter']['secret'] # if SERVICES['twitter']
end
