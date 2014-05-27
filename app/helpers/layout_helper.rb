module LayoutHelper
  include Constants

  # Adds a inset shadow effect in the given view
  #  - if and only if there isn't one already set
  #  - if and only if the device is not an iPhone 4 (laggy)
  def inset_shadow(view)
    @view = view

    if inset?
      inset_shadow = YIInnerShadowView.alloc.initWithFrame @view.bounds
      inset_shadow.setShadowRadius 1.5
      inset_shadow.setShadowMask YIInnerShadowMaskTop
      inset_shadow.layer.setCornerRadius 5
      inset_shadow.layer.setMasksToBounds true
      inset_shadow.tag = INSET_SHADOW_TAG

      @view.addSubview inset_shadow
    end
  end

  private

  attr_accessor :view

  def inset?
    !has_inset? && !iphone_4?
  end

  def has_inset?
    @view.viewWithTag INSET_SHADOW_TAG
  end

  # iOS 7 compatible devices:
  #  - iPhone 5S
  #  - iPhone 5C
  #  - iPhone 5
  #
  #  - iPhone 4S, but does not support:
  #   - Filters in Camera app
  #   - AirDrop
  #
  # - iPhone 4, but does not support:
  #  - All items from iPhone 4S, plus
  #   - Panoramic photos
  #   - Siri
  def iphone_4?
    GBDeviceInfo.deviceDetails.model == GBDeviceModeliPhone4
  end
end