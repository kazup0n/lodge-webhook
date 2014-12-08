require 'faraday'

module LodgeWebhook
  class Sender
    KEY_SECRET = 'X-HUBOT-LODGE-WEBHOOK-SECRET'

    def initialize(secret)
      @sercet = secret
    end

    def send(host, path, article)
      conn = connection(host, path)
      begin
        conn.post do |req|
          req.url path
          req.body = article
          req.headers[KEY_SECRET] = @secret
        end
      rescue => e
        LodgeWebhook::logger.error e
        # raise e
      end
    end

    def connection(host, path)
      conn = Faraday::Connection.new(:url => host) do |faraday|
        faraday.use Faraday::Adapter::EMHttp
      end
      conn
    end

  end
end
