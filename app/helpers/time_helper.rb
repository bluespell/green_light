module TimeHelper
  def time_from_string(string)
    NSDate.dateWithNaturalLanguageString(string)
  end
end
