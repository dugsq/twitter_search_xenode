# Copyright Nodally Technologies Inc. 2013
# Licensed under the Open Software License version 3.0
# http://opensource.org/licenses/OSL-3.0

# 
# @version 0.1.0
#
# Twitter Search Xenode leverages the Twitter Ruby Gem, uses a pre-defined keyword and returns a pre-defined number 
# of tweets that contain the the search keyword as well as meeting the result type. It passes the search results as 
# hash to the children Xenodes. 
#
# Config file options:
#   loop_delay:         Expected value: a float. Defines number of seconds the Xenode waits before running process(). 
#   enabled:            Expected value: true/false. Determines if the xenode process is allowed to run.
#   debug:              Expected value: true/false. Enables extra logging messages in the log file.
#   consumer_key:       Expected value: a string. This is your Twitter consumer key
#   consumer_secret:    Expected value: a string. This is your Twitter consumer secret code
#   search_string:      Expected value: a string. The keyword used for the Twitter Search.
#   search_options:     For all supported search options, refer: http://rdoc.info/gems/twitter/Twitter/API/Search
#
# Example Configuration File:
#   enabled: true
#   loop_delay: 60
#   debug: true
#   consumer_key: abcdefghijklmnopqrstuvwxyz
#   consumer_secret: abcdefghijklmnopqrstuvwxyz
#   search_string: xenograte
#   search_options: 
#     count: 10
#     result_type: recent
#
# Example Input:    The Twitter Search Xenode does not expect nor handle any input.  
#
# Example Output:
# msg.data: [{:From_User=>"VancePan", :Tweet_Content=>"RT @Nodally: How \"micronized\" are the apps running on Xenograte? Here's a 6-line micro-app written in #Ruby that does magic: http://t.co/32…"}]
#

require 'twitter'

class TwitterSearchXenode
  include XenoCore::NodeBase
  
  def startup
    mctx = "#{self.class}.#{__method__} - [#{@xenode_id}]"
    
#    Twitter.configure do |config|
#      config.consumer_key = @config[:consumer_key] #YOUR_CONSUMER_KEY
#      config.consumer_secret = @config[:consumer_secret] #YOUR_CONSUMER_SECRET
#    end
    
    @twitter = Twitter::Client.new(consumer_key: @config[:consumer_key], consumer_secret: @config[:consumer_secret])
    
    @search_str = @config[:search_string]
    @search_opts = @config[:search_options]
  end
  
  def process()
    mctx = "#{self.class}.#{__method__} - [#{@xenode_id}]"

    result = search_twitter()
    msg_out = XenoCore::Message.new()   
    msg_out.data = result
    write_to_children(msg_out)
    do_debug("#{mctx} - Message Data Sent: #{msg_out.data.inspect}")
    msg_out = nil
  end
  
  def search_twitter
    mctx = "#{self.class}.#{__method__} - [#{@xenode_id}]"
    
    ret_val = []
    do_debug("#{mctx} - Twitter Search Begins...")
    if @search_str && !@search_str.empty? && @search_opts && !@search_opts.empty?
      @twitter.search(@search_str, @search_opts).results.map do |status|
        ret_val << {:From_User=>status.from_user,:Tweet_Content=>status.text}
      end
    else
      do_debug("#{mctx} - ERROR: search string and options must not be empty.")
    end
    ret_val
  end
  
end

