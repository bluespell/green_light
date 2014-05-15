class ProjectCell < UITableViewCell

  def configure(project)
    background_color = UIView.alloc.init
    background_color.setBackgroundColor(project.status_color[:foreground])
    self.setSelectedBackgroundView(background_color)

    paper_fold = PaperFoldView.alloc.initWithFrame([[0, 0],[self.frame.size.width, self.frame.size.height]])
    paper_fold.setEnableRightFoldDragging(false)

    left_content = UIView.alloc.initWithFrame([[0, 0],[60, self.frame.size.height]])
    left_content.setAutoresizingMask(UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth)
    left_content.setBackgroundColor(project.status_color[:background])

    if (project.favorite)
      favorite_icon = UIImageView.alloc.initWithImage(UIImage.imageNamed('star-40-red'))
    else
      favorite_icon = UIImageView.alloc.initWithImage(UIImage.imageNamed('star-40-green'))
    end
    favorite_icon.center = left_content.center

    left_content.addSubview(favorite_icon)
    paper_fold.setLeftFoldContentView(left_content)

    center_content = ProjectCellView.alloc.initWithFrame([[0, 0],[self.frame.size.width, self.frame.size.height]])
    center_content.configure(project)
    paper_fold.setCenterContentView(center_content)

    self.addSubview(paper_fold)
  end
end