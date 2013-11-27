twitter-search-xenode
=====================

**Twitter Search Xenode** leverages the Twitter RubyGem, uses a pre-defined search keyword and returns a pre-defined number of tweets that contain the the search keyword as well as meeting the "result type" criteria. It passes the search results as hash to the children Xenodes. 

###Config file options:###
* loop_delay: defines number of seconds the Xenode waits before running the Xenode process. Expects a float. 
* enabled: determines if the Xenode process is allowed to run. Expects true/false. 
* debug: enables extra debug messages in the log file.  Expects true/false.
* consumer_key: specifies your Twitter consumer key. Expects a string.
* consumer_secret: specifies your Twitter consumer secret code. Expects a string.
* search_string: defines the keyword used for the Twitter Search. Expects a string.
* search_options: specifies the Twitter Search option. Expects a string. For all supported search options, refer to: http://rdoc.info/gems/twitter/Twitter/API/Search

###Example Configuration File:###
* enabled: true
* loop_delay: 60
* debug: false
* consumer_key: abcdefghijklmnopqrstuvwxyz
* consumer_secret: abcdefghijklmnopqrstuvwxyz
* search_string: xenograte
* search_options: 
    - count: 10
    - result_type: recent

###Example Input:###
* The Twitter Search Xenode does not expect nor handle any input.  

###Example Output:###
* msg.data: [{:From_User=>"VancePan", :Tweet_Content=>"RT @Nodally: How \"micronized\" are the apps running on Xenograte? Here's a 6-line micro-app written in #Ruby that does magic: http://t.co/32…"}]
