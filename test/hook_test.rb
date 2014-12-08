require 'test_helper'
require 'json'


class HookTest < ActiveSupport::TestCase

  test 'Hook#parse_hook_url' do
    parsed = LodgeWebhook::Hook::parse_hook_url("http://localhost:3000/foobar/hoge")
    assert_equal parsed[:host], 'http://localhost:3000'
    assert_equal parsed[:path], '/foobar/hoge'
  end

  test 'Hook#send does not set when hook_url is nil' do
    sender = mock()
    sender.expects(:send).never
    hook = LodgeWebhook::Hook.new(nil, sender)
    hook.send({})
  end

  test 'Hook#send' do
    article = JSON.generate({:p1 => 'p1', :p2 => 'p2'})
    sender = mock()
    sender.expects(:send)
    .with('http://localhost:80', '/foo/bar', article)
    .once

    hook = LodgeWebhook::Hook.new('http://localhost/foo/bar', sender)
    hook.send(article)
  end

end
