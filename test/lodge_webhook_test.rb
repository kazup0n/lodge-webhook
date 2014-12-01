require 'test_helper'

class LodgeWebhookTest < ActiveSupport::TestCase

  def setup
    SenderMock.clear
  end

  test "truth" do
    assert_kind_of Module, LodgeWebhook
  end

  test "Arcticle#save intercepted" do
    SenderMock.config do |stub|
      stub.post('http://localhost:3000/') { [200, {}, ''] }
    end
    Article.new.save
  end

  test "server not respond when requesting on hook" do
    Article.new.save
  end

  test "server respond 404" do
    SenderMock.config do |stub|
      stub.post('http://localhost:3000/') { [404, {}, ''] }
    end
    Article.new.save
  end

end
