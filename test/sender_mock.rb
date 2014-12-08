require 'mocha/test_unit'


module SenderMock

  def self.config
    stubs = Faraday::Adapter::Test::Stubs.new

    conn = Faraday.new do |builder|
      builder.adapter :test, stubs
    end

    LodgeWebhook::Sender.any_instance.stubs(:connection).returns conn
    @@stubs = stubs
    yield stubs, conn if block_given?
  end

  def self.clear
    config()
  end

  def self.verify
    @@stubs.verify_stubbed_calls() if @@stubs
  end

end
