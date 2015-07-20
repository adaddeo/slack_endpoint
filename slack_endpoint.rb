# Sinatra
require 'sinatra'

# Hash fix
require 'active_support/core_ext/hash'

# Spree endpoint
require 'endpoint_base'

# Slack Notifier client
require 'slack-notifier'

# Slack endpoint helpers
require './lib/slack_helpers'
require './lib/slack_service'
require './lib/post_message'

class SlackEndpoint < EndpointBase::Sinatra::Base
  endpoint_key ENV["ENDPOINT_KEY"]
  helpers SlackHelpers
  set :logging, true

  post '/post_message' do
    process_request do
      post_message
      result 200, 'Successfully sent message sent to Slack'
    end
  end

  post '/ping' do
    result 200, "Hi! Time now is: #{Time.new}"
  end
end