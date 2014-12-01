require 'uri'

module LodgeWebhook
  class Hook
    def self.parse_hook_url(hook_url)
      uri = URI.parse hook_url
      host = "#{uri.scheme}://#{uri.host}:#{uri.port}"
      {:host => host, :path => uri.path }
    end

    def initialize(url, sender)
      @hook_url = url
      @sender = sender
    end

    def send(article)
      if @hook_url
        url = Hook.parse_hook_url @hook_url
        @sender.send(url[:host], url[:path], article)
      end
    end
  end
end
