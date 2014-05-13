class ProjectCellBuilder
  include TimeHelper

  attr_accessor :cell

  def initialize(opts={})
    @project          = opts.fetch :project
    @reuse_identifier = opts.fetch :reuse_identifier, "project_cell"
  end

  def build_cell
    @cell = MCSwipeTableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier: @reuseIdentifier)

    @cell.textLabel.text = @project.name
    @cell.detailTextLabel.text = detail_text

    @cell.firstTrigger = 0.25
    @cell.secondTrigger = 0.6

    configure_cell_colors

    swipe_add_favorite
    swipe_remove_favorite

    @cell
  end

  private

  def detail_text
    return 'Building...' unless @project.last_build

    "Last build: #{time_ago_in_words(@project.last_build)}"
  end

  def configure_cell_colors
    view = UIView.alloc.init
    view.setBackgroundColor("F2F2E9".to_color)
    @cell.selectedBackgroundView = view
    @cell.setBackgroundColor(@project.status_color[:foreground])
  end

  def swipe_add_favorite
    swipe_configure("8DB53E".to_color, MCSwipeTableViewCellState1)
  end

  def swipe_remove_favorite
    swipe_configure("B13200".to_color, MCSwipeTableViewCellState2)
  end

  def swipe_configure(color, state)
    @cell.setSwipeGestureWithView(
      favorite_icon,
      color: color,
      mode: MCSwipeTableViewCellModeSwitch,
      state: state,
      completionBlock: -> (cell, state, mode) {
        @project.favorite = (state == MCSwipeTableViewCellState1)
        @project.save
        # TODO: update badge number in FavoriteController
      }
    )
  end

  def favorite_icon
    image_view = UIImageView.alloc.initWithImage(UIImage.imageNamed('star-40'))
    image_view.contentMode = UIViewContentModeCenter
  end
end