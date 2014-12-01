require 'lodge_webhook/version'
require 'lodge_webhook/railtie'
require 'lodge_webhook/hook'
require 'lodge_webhook/sender'

module LodgeWebhook

  def self.logger
    @logger ||= Rails.logger
  end

  def self.configration
    @configure ||= {}
  end

  def self.config
    yield(configration)
  end

  def self.hook(article)
    hook_url = configration[:webhook_url]
    Hook.new(hook_url, Sender.new).send(article)
    logger.info "hook sent to #{hook_url}"
  end

end
