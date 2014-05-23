module TimeHelper

  def time_from_string(string)
    NSDate.dateWithNaturalLanguageString(string)
  end

  def building_date(branch)
    return 'Building...' unless branch.finished_at

    "Last build: #{branch.finished_at.time_ago_in_words}"
  end
end
