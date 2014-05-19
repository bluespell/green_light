class Time
  def time_ago_in_words
    NSDate.dateWithTimeIntervalSinceNow(self - Time.now).timeAgoSinceNow
  end
end
