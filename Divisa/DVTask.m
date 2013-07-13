//
//  DVTask.m
//  Divisa
//
//  Created by Scott Andrus on 6/8/13.
//  Copyright (c) 2013 Tapatory, LLC. All rights reserved.
//

#import "DVTask.h"

@implementation DVTask

+ (DVTask *)taskWithName:(NSString *)taskName andValue:(float)value
{
    return [[DVTask alloc] initWithName:taskName andValue:value];
}

- (id)initWithName:(NSString *)taskName andValue:(float)value
{
    self = [super init];
    if (self) {
        _taskName = taskName;
        _value = value;
    }
    return self;
}

@end
