class TweetProcessor
  attr_accessor :raw_text, :result

  def initialize
    self.raw_text = ""
    self.result = TweetProcessorResult.new
  end
  
  # Gather URLs
  def gather_urls
    result.urls ||= []
    raw_text.gsub!(/(?i)\b((?:https?:\/\/|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?«»“”‘’]))/) do |match|
      result.urls << match
      " "
    end
    result.urls.uniq!
    result
  end
  
  # Gather Tweeple
  def gather_tweeple    
    result.tweeple ||= []
    raw_text.gsub!(/@[a-zA-Z~_\-]+/) do |match|
      result.tweeple << match
      " "
    end
    result.tweeple.uniq!
    result
  end
  
  # Gather Hash tags
  def gather_hash_tags
    result.hashtags ||= []
    raw_text.gsub!(/#[a-zA-Z_\-]+/) do |match|
      result.hashtags << match
      " "
    end
    result.hashtags.uniq!
    result
  end
  
  def gather_result
    
    gather_urls

    gather_tweeple

    gather_hash_tags

    # Sanitize raw_text
    raw_text.gsub!(/\[|\]|\(|\)|:/, " ")
    raw_text.gsub!(/[ ]+/, " ")
    raw_text.strip!

    # Get list of words
    words = []
    raw_text.downcase!
    raw_text.gsub!(/[a-zA-Z0-9&']{3,}/i) do |match|
      words << match
      " "
    end

    # Remove all number only words
    words = words.delete_if do |w|
      ret = false
      if w.match(/[0-9]+/).to_s == w
        ret = true
      end
      ret
    end

    unique_words =  words.uniq
    result.words = {}
    unique_words.each do |word|
      count = 0
      words = words.delete_if do |w|
        ret = false
        if w == word
          count = count + 1
          ret = true
        end
        ret
      end
      result.words[word] = count
    end
    
    result
  end
end