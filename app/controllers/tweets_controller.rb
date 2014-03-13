class TweetsController < ApplicationController
  require 'tweetstream'
  respond_to :html, :json, :js
  def home
    TweetStream.configure do |config|
      config.consumer_key       = "hHISxEXBCSF4xyOJVEHFkQ"
      config.consumer_secret    = "jMTfdYRqrGPPefGvvrvLUGNSmRkm0POqSkRrf2HI"
      config.oauth_token        = "1371269942-4XCzwr8s7roCDtN0dIl9OsIzmz3N7jxYrebZBsy"
      config.oauth_token_secret = "b1HahVDCFgBjyDYKT34hfraxdZgv36EqBPkoqNwDoiz8U"
      config.auth_method        = :oauth
    end

    track
  end
  def track
    Thread.new do
      puts "in thread"
        file = File.read("public/data/data.json")
          p file
      TweetStream::Client.new.track('tweet', 'twitter') do |tweet|
        # puts "tracking"
        if tweet.geo

          # puts "geo tweet"
          geoTweet = {
            :tweets => [
              :text => tweet.text,
              :coordinates => tweet.geo.coordinates
            ]
          }
          puts "getting tweet"

          File.open("public/data/data.json","w") do |f|
            f.write(geoTweet.to_json)
          end
          puts "got tweet"
        end
      end
    end
  end
end

#   def track
#     @tweetObject = {:tweets => []}
#     Thread.new do
#       puts "in thread"
#         file = File.read("public/data/data.json")
#           p file
#       TweetStream::Client.new.track("lol",'bieber', "yolo", "swag") do |tweet|
#         # puts "tracking"
#         if tweet.geo

#           # puts "geo tweet"
#           geoTweet = {
#               :text => tweet.text,
#               :coordinates => tweet.geo.coordinates
#           }
#           puts "getting tweet"
#           @tweetObject[:tweets] << geoTweet
#           p @tweetObject
#           File.open("public/data/data.json","w") do |f|
#           # file = JSON.parse(file)
#           # file["tweets"] << geoTweet.to_json
#           f.write(@tweetObject.to_json)
#           end
#           puts "got tweet"
#         end
#       end
#     end
#   end
# end