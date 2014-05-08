module TimeHelper
  SEMAPHORE_TIME_FORMAT="yyyy-MM-dd'T'HH:mm:ssz"

  def time_from_string(string)
    date_formatter = NSDateFormatter.alloc.init
    date_formatter.dateFormat = SEMAPHORE_TIME_FORMAT
    date_formatter.dateFromString string
  end
end
