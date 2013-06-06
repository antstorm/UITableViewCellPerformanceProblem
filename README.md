### Demo of a strange performance problem

[Link to the original post from StackOverflow](http://stackoverflow.com/questions/16949248/uitableviewcell-bad-performance-with-autolayout)

I'm somewhat stuck with this one… any help is very appreciated. I've already spent lots of time debugging this.

I've got `UITableView` with data source provided by `NSFetchedResultsController`. In a separate view controller I insert new records to the CoreData using `[NSEntityDescription insertNewObjectForEntityForName:inManagedObjectContext:]`, save the managed object context and dismiss that controller. Very standard stuff.

The changes in managed object context are then received by `NSFetchedResultsController`:

    - (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
            [self.tableView beginUpdates];
    }

    - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
            [self.tableView endUpdates];
    }

    - (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
        switch (type) {
            case NSFetchedResultsChangeInsert:
                [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationNone];

                break;

            case NSFetchedResultsChangeDelete:
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

                break;

            case NSFetchedResultsChangeUpdate:
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

                break;

            case NSFetchedResultsChangeMove:
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationNone];

                break;
        }
    }

And this is where the problem appears — it takes too long(about 3-4 seconds on an iPhone 4) to do that. And it seems like the time is spent calculating layout for the cells.

I've stripped everything from the cell(including custom subclass) and left it with just `UILabel`, but nothing changed. Then I've changed the style of the cell to Basic(or anything except Custom) and the problem disappeared — new cells are added instantaneously.

I've doubled checked and `NSFetchedResultsControllerDelegate` callbacks are called only once. If I ignore them and do `[UITableView reloadSections:withRowAnimation:]`, nothing changes — it is still very slow.

It seems to me like Auto Layout is disabled for the default cell styles, which makes them very fast. But if that is the case — why does everything loads quickly when I push the `UITableViewController`?

Here's the call trace for that problem:
![stack trace][1]


So the question is — what is going on here? Why are cells being rendered so slowly?


  [1]: http://i.stack.imgur.com/z2hCd.png