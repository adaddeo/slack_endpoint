# Sinatra
require 'sinatra'

# Hash fix
require 'active_support/core_ext/hash'

# Spree endpoint
require 'endpoint_base'

# Slack Notifier client
require 'slack-notifier'


class SlackEndpoint < EndpointBase::Sinatra::Base
  endpoint_key ENV["ENDPOINT_KEY"]
  set :logging, true

  post '/post_message' do
    result 500, 'Missing Webhook URL' unless @config['webhook_url'].present?
    message = @payload[:message]

    notifier = Slack::Notifier.new @config['webhook_url']
    notifier.channel = value_for(:channel, 'hub')
    notifier.username = value_for(:username, 'Slack EP')

    args = {
        icon_emoji: value_for(:icon_emoji),
        attachments: [value_for(:attachments)]
    }

    notifier.ping message[:body], args
    result 200, 'Message sent to slack'
  end

  post '/ping' do
    result 200, "Hi! Time now is: #{Time.new}"
  end
end