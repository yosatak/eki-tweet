# coding: utf-8
require 'base64'
require 'bundler'
Bundler.require

data = []
File.open("../data/station-coord"){|f|
  data = f.readlines
}

answer = data[rand(data.count - 1)].chomp.split(' ')


session = Selenium::WebDriver.for(:remote,
                                 :url => "http://localhost:4444/")
session.manage.timeouts.implicit_wait = 20

session.navigate.to("https://maps.gsi.go.jp/#15/#{answer[2]}/#{answer[1]}/&ls=experimental_rdcl%7Cexperimental_railcl%7Cexperimental_rvrcl&disp=111")

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['TWITTER_CONSUMER_TOKEN']
  config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
  config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
end

p "https://maps.gsi.go.jp/#15/#{answer[2]}/#{answer[1]}/&ls=experimental_rdcl%7Cexperimental_railcl%7Cexperimental_rvrcl&disp=111"
sleep 10
session.save_screenshot('./result.png')
client.update_with_media("どこだどこだ", open('./result.png'))
