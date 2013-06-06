//
//  TableViewController.m
//  UITableViewCellPerformanceProblem
//
//  Created by Anton Dmitriyev on 06.06.13.
//  Copyright (c) 2013 ANTStorm. All rights reserved.
//

#import "AppDelegate.h"

#import "TableViewController.h"

#import "Row.h"
#import "RowCell.h"


@interface TableViewController ()

@end


@implementation TableViewController

@synthesize fetchedResultsController = _fetchedResultsController, tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self.fetchedResultsController performFetch:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self fetchedResultsController] fetchedObjects] count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Row *row = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    RowCell *cell = [aTableView dequeueReusableCellWithIdentifier:@"SIMPLE_CELL" forIndexPath:indexPath];
    
    cell.rowTitle.text = row.title;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}




#pragma mark - NSFetchedResultsController delegate

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController) return _fetchedResultsController;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Row" inManagedObjectContext:appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];

    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sort, nil]];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                   managedObjectContext:appDelegate.managedObjectContext
                                                                     sectionNameKeyPath:nil
                                                                              cacheName:nil];
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            break;
    }
}


- (IBAction)insertNow:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    Row *newRow = [NSEntityDescription insertNewObjectForEntityForName:@"Row" inManagedObjectContext:appDelegate.managedObjectContext];
    
    newRow.title = [NSString stringWithFormat:@"%@", [NSDate date]];
    
    [appDelegate.managedObjectContext save:nil];
}

@end
