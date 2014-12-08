require 'rails'

module LodgeWebhook
  class Railtie < Rails::Railtie

    config.lodge_webhook = ActiveSupport::OrderedOptions.new

    # Hook aftersave of model Article
    config.after_initialize do
      Article.set_callback :save, :after, :prepend => false do
        LodgeWebhook.hook(self.to_json)
      end
    end

    # load config
    initializer "lodge_webhook" do |app|
      LodgeWebhook.config do |config|
        config[:webhook_url] = app.config.lodge_webhook[:webhook_url]
        config[:webhook_secret] = app.config.lodge_webhook[:webhook_secret]
      end
    end

  end
end
