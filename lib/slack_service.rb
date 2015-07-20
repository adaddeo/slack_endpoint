class SlackService
  def initialize(payload, config)
    @payload, @config = payload, config
  end

  private

  def webhook_url
    @config['webhook_url']
  end
end