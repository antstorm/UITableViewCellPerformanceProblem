//
//  Row.h
//  UITableViewCellPerformanceProblem
//
//  Created by Anton Dmitriyev on 06.06.13.
//  Copyright (c) 2013 ANTStorm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Row : NSManagedObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSDate *createdAt;

@end
