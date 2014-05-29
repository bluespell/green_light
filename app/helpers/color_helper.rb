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

  private

  # Stopped and Failed are both same 'redish' colors
  def stopped_failed_colors
    { :light => "F5D9C9".to_color, :medium => "F2F2E9".to_color, :strong => "AF3A00".to_color }
  end
end