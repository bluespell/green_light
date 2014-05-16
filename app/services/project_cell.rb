class ProjectCell < UITableViewCell

  attr_accessor :background_color, :paper_fold, :left_content, :favorite_icon, :center_content

  def configure(project)
    @background_color = UIView.alloc.init unless @backgroundColor
    @background_color.setBackgroundColor(project.status_color[:foreground])
    self.setSelectedBackgroundView(@background_color)

    @paper_fold = PaperFoldView.alloc.initWithFrame([[0, 0],[self.frame.size.width, self.frame.size.height]]) unless @paper_fold

    @left_content = UIView.alloc.initWithFrame([[0, 0],[60, self.frame.size.height]]) unless @left_content
    @left_content.setAutoresizingMask(UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth)
    @left_content.setBackgroundColor(project.status_color[:background])

    @favorite_icon = UIImageView.alloc.initWithImage(UIImage.imageNamed('star-40-green')) unless @favorite_icon
    @favorite_icon.setImage(UIImage.imageNamed('star-40-red')) if (project.favorite)
    @favorite_icon.center = @left_content.center

    @left_content.addSubview(favorite_icon)
    @paper_fold.setLeftFoldContentView(@left_content)

    @center_content = ProjectCellView.alloc.initWithFrame([[0, 0],[self.frame.size.width, self.frame.size.height]]) unless @center_content
    @center_content.configure(project)
    @paper_fold.setCenterContentView(@center_content)

    self.addSubview(@paper_fold)
  end
end