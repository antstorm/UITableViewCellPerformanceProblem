//
//  Row.m
//  UITableViewCellPerformanceProblem
//
//  Created by Anton Dmitriyev on 06.06.13.
//  Copyright (c) 2013 ANTStorm. All rights reserved.
//

#import "Row.h"


@implementation Row

@dynamic title, createdAt;

- (id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context {
    if (self = [super initWithEntity:entity insertIntoManagedObjectContext:context]) {
        if (!self.createdAt) self.createdAt = [NSDate date];
    }
    
    return self;
}

@end
