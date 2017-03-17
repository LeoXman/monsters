OmniAuth.config.logger = Rails.logger

SERVICES = YAML.load(File.open("#{::Rails.root}/config/oauth.yml").read)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  provider :github, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :github, SERVICES['github']['key'], SERVICES['github']['secret']
  provider :twitter, SERVICES['twitter']['key'], SERVICES['twitter']['secret']
end
