lodge-webhook
=============

[lodge](https://github.com/lodge/lodge) で記事の作成時にwebhookを送信するプラグインです.

インストール
------------

```
git clone https://github.com/kazup0n/lodge-webhook.git
```

lodgeの設定変更
---------------

### Gemfile

```ruby
# チェックアウトしたディレクトリを参照
gem 'lodge_webhook', path: '../lodge_webhook'
```

### config/application.rb

```ruby
# webhook endpoint
config.lodge_webhook.webhook_url = 'http://localhost:8080/hubot/notify/lodge'
# webhook secret
config.lodge_webhook.webhook_secret = 'fd93e783e4e1cac28c749fb247c12e40'
```

### 動作の詳細

`config.lodge_webhook.webhook_url`で設定したURLへ下記のJSONをポストします.

```json
{
  "id": 1,
  "title": "タイトル",
  "body": "本文",
  "user_id": 1,
  "created_at": "2014-12-01 10:00:00",
  "updated_at": "2013-12-01 10:10:00",
  "comments_count": 0,
  "lock_version": 0
}
```

リクエストヘッダー `X-HUBOT-LODGE-WEBHOOK-SECRET` に `config.lodge_webhook.webhook_secret`の値を設定します.
