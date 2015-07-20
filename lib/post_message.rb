class PostMessage < SlackService
  def post!
    result 500, 'Missing Webhook URL' unless webhook_url.present?

    notifier = Slack::Notifier.new webhook_url

    notifier.channel = value_for(:channel, 'hub')
    notifier.username = value_for(:username, 'Slack EP')

    args = {
        icon_emoji: value_for(:icon_emoji),
        attachments: [value_for(:attachments)]
    }

    notifier.ping message[:body], args
  end

  private

  def value_for(param, default = nil)
    @payload[:message][param.to_sym] || @config[param.to_s] || default
  end

  def message
    @payload[:message]
  end
end