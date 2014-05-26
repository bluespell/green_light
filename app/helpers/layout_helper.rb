module LayoutHelper

  # Adds a inset shadow effect in the given view
  # if and only if there isn't one already set
  def inset_shadow(view)
    inset_shadow_tag = 666

    if !view.viewWithTag inset_shadow_tag
      inset_shadow = YIInnerShadowView.alloc.initWithFrame view.bounds
      inset_shadow.setShadowRadius 1.5
      inset_shadow.setShadowMask YIInnerShadowMaskTop
      inset_shadow.layer.setCornerRadius 5
      inset_shadow.layer.setMasksToBounds true
      inset_shadow.tag = inset_shadow_tag

      view.addSubview inset_shadow
    end
  end
end