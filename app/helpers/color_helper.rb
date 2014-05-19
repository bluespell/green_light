module ColorHelper
  def failed_colors
    { :light => "F3E2D8".to_color, :strong => "FF0000".to_color }
  end

  def pending_colors
    { :light => "EAF3F7".to_color, :strong => "DDEFF8".to_color }
  end

  def passed_colors
    { :light => "EAF3D8".to_color, :strong => "59AF00".to_color }
  end
end
