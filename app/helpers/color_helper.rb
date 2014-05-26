module ColorHelper
  def failed_colors
    { :light => "F5D9C9".to_color, :medium => "F2F2E9".to_color, :strong => "AF3A00".to_color }
  end

  def pending_colors
    { :light => "DCEFF9".to_color, :medium => "F2F2E9".to_color, :strong => "A2BCCD".to_color }
  end

  def passed_colors
    { :light => "E6F5C8".to_color, :medium => "F2F2E9".to_color, :strong => "8EB43F".to_color }
  end
end