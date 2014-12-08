require 'lodge_webhook/version'
require 'lodge_webhook/railtie'
require 'lodge_webhook/hook'
require 'lodge_webhook/sender'

module LodgeWebhook

  def self.logger
    @logger ||= Rails.logger
  end

  def self.configuration
    @configure ||= {}
  end

  def self.config
    yield(configuration)
  end

  def self.hook(article)
    hook_url = configuration[:webhook_url]
    secret = configuration[:webhook_secret]
    Hook.new(hook_url, Sender.new(secret)).send(article)
    logger.info "hook sent to #{hook_url}"
  end

end
