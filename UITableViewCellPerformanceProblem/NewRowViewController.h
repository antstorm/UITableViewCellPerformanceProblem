//
//  NewRowViewController.h
//  UITableViewCellPerformanceProblem
//
//  Created by Anton Dmitriyev on 06.06.13.
//  Copyright (c) 2013 ANTStorm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewRowViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *rowTitle;

- (IBAction)createRow:(id)sender;

@end
