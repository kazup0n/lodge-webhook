require 'test_helper'

class LodgeWebhookTest < ActiveSupport::TestCase

  HEADER = {'X-HUBOT-LODGE-WEBHOOK-SECRET' => 'fd93e783e4e1cac28c749fb247c12e40'}

  def setup
    SenderMock.clear()
  end

  def teardown
    SenderMock.verify()
  end

  test "truth" do
    assert_kind_of Module, LodgeWebhook
  end

  test "Arcticle#save intercepted" do
    SenderMock.config do |stub|
      stub.post('/') { [200, {}, ''] }
    end
    Article.new.save
  end

  test "server not respond when requesting on hook" do
    SenderMock.config do |stub|
      stub.post('/') {raise RuntimeError.new}
    end
    Article.new.save
  end

  test "server respond 404" do
    SenderMock.config do |stub|
      stub.post('/') { [404, {}, ''] }
    end
    Article.new.save
  end

end
