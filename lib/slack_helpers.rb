module SlackHelpers
  def post_message
    message = PostMesage.new(@payload, @config)
    message.post!
  end

  def process_request
    begin
      yield
    end
  end
end