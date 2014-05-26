module TimeHelper

  def time_from_string(string)
    NSDate.dateWithNaturalLanguageString(string)
  end

  def building_date(branch)
    return 'Building...' unless branch.finished_at

    MHPrettyDate.prettyDateFromDate(branch.finished_at, withFormat: MHPrettyDateLongRelativeTime)
  end
end
