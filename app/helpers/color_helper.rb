module ColorHelper
  def failed_colors
    { :light => "F3E2D8".to_color, :medium => "F4D9CA".to_color, :strong => "FF0000".to_color }
  end

  def pending_colors
    { :light => "D2F0FD".to_color, :medium => "DDEFF8".to_color, :strong => "006699".to_color }
  end

  def passed_colors
    { :light => "EAF3D8".to_color, :medium => "E6F4CA".to_color, :strong => "59AF00".to_color }
  end
end