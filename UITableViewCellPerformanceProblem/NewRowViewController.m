//
//  NewRowViewController.m
//  UITableViewCellPerformanceProblem
//
//  Created by Anton Dmitriyev on 06.06.13.
//  Copyright (c) 2013 ANTStorm. All rights reserved.
//

#import "AppDelegate.h"

#import "NewRowViewController.h"

#import "Row.h"


@interface NewRowViewController ()

@end


@implementation NewRowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.rowTitle becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createRow:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    Row *newRow = [NSEntityDescription insertNewObjectForEntityForName:@"Row" inManagedObjectContext:appDelegate.managedObjectContext];
    
    newRow.title = self.rowTitle.text;
    
    [appDelegate.managedObjectContext save:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
