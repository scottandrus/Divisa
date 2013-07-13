//
//  DVResponsibility.m
//  Divisa
//
//  Created by Scott Andrus on 6/8/13.
//  Copyright (c) 2013 Tapatory, LLC. All rights reserved.
//

#import "DVResponsibility.h"
#import "DVTask.h"

@implementation DVResponsibility

+ (DVResponsibility *)responsibilityWithName:(NSString *)name tasks:(NSMutableArray *)tasks andPeople:(NSMutableArray *)people
{
    return [[DVResponsibility alloc] initWithName:name tasks:tasks andPeople:people];
}

- (id)initWithName:(NSString *)name tasks:(NSMutableArray *)tasks andPeople:(NSMutableArray *)people
{
    self = [super init];
    if (self) {
        _tasks = tasks;
        _assignedPeople = people;
        _responsibilityName = name;
    }
    return self;
}

- (void)addPersonToResponsibility:(DVPerson *)person
{
    [self.assignedPeople addObject:person];
    for (DVTask *task in person.tasks) {
        [self.tasksToPeople setObject:person forKey:task.taskName];
    }
}

@end
