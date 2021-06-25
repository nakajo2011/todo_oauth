# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# How to setup
You should set up google_oauth2 client_id and client_secret into credential file.

for example:

* run following command

`$ EDITOR=vim bin/rails credentials:edit -e development`

* write google_oauth2 info in credential

```yml
google:
  client_id: コピーしたクライアントID
  client_secret: コピーしたクライアントシークレット
```
