module ColorHelper
  def passed_colors
    { :light => "E6F5C8".to_color, :medium => "F2F2E9".to_color, :strong => "8EB43F".to_color }
  end

  def pending_colors
    { :light => "DCEFF9".to_color, :medium => "F2F2E9".to_color, :strong => "A2BCCD".to_color }
  end

  def stopped_colors
    stopped_failed_colors
  end

  def failed_colors
    stopped_failed_colors
  end

  def self.refresh_control_color
    #UIColor.colorWithRed(222/255, green:223/255, blue:205/255, alpha:0.5) #DEDFCD
    UIColor.colorWithRed(74/255, green:74/255, blue:74/255, alpha:0.5) #4A4A4A
  end

  private

  # Stopped and Failed are both same 'redish' colors
  def stopped_failed_colors
    { :light => "F5D9C9".to_color, :medium => "F2F2E9".to_color, :strong => "AF3A00".to_color }
  end
end