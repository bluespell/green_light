# Controllers that use NSFetchedResults should include this module to avoid duplication
# Any method can be overwritten if needed, although it's important to mantain the
# same behaviour, since it could get unexpected results
module NsFetchedResultsHelper

  # This method should be called inside the `viewDidLoad` in order to do the
  # initial setup on the fetch_controller
  #
  # Example:
  #   def viewDidLoad
  #     super
  #     setupNSFetchedResultsController
  #   end
  def setupNSFetchedResultsController
    error_ptr = Pointer.new(:object)
    fetch_controller.delegate = self

    raise "Error performing fetch: #{error_ptr[2].description}" unless fetch_controller.performFetch(error_ptr)
  end

  # Like `setupNSFetchedResultsController`, this method should be called inside
  # `viewDidUnload` in order to clear the controller variable
  #
  # Example:
  #   def viewDidUnload
  #     super
  #     clearNSFetchedResultsController
  #   end
  def clearNSFetchedResultsController
    @fetch_controller = nil
  end

  # This needs to be implemented on the class that includes this helper. It should
  # return the CoreData collection object. It'll be used for the `fetch_controller`
  # method
  #
  # Example:
  #   class FooBarController < UITableViewController
  #     include NsFetchedResultsHelper
  #
  #     def collection
  #       @foobars ||= Foobar.all
  #     end
  #   end
  #
  def collection
    raise 'Implement here the collection data for the tableview'
  end

  # NSFetchedResultsController delegate methods

  def controllerWillChangeContent(controller)
    view.beginUpdates
  end

  def controller(controller, didChangeObject: project, atIndexPath: index_path, forChangeType: change_type, newIndexPath: new_index_path)
    case change_type
      when NSFetchedResultsChangeInsert
        view.insertRowsAtIndexPaths([new_index_path], withRowAnimation: UITableViewRowAnimationNone)
      when NSFetchedResultsChangeDelete
        view.deleteRowsAtIndexPaths([index_path], withRowAnimation: UITableViewRowAnimationNone)
      when NSFetchedResultsChangeUpdate
        view.reloadRowsAtIndexPaths([index_path], withRowAnimation: UITableViewRowAnimationNone)
    end
  end

  def controllerDidChangeContent(controller)
    view.endUpdates
  end

  private

  def fetch_controller
    @fetch_controller ||= NSFetchedResultsController.alloc.initWithFetchRequest(
      collection.fetch_request,
      managedObjectContext: collection.context,
      sectionNameKeyPath: nil,
      cacheName: nil
    )
  end
end
