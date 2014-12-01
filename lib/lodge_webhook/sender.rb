require 'faraday'

module LodgeWebhook
  class Sender
    def send(host, path, article)
      conn = connection(host, path)
      begin
        conn.post path, article
      rescue => e
        LodgeWebhook::logger.error e
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
