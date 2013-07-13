//
//  DVTask.h
//  Divisa
//
//  Created by Scott Andrus on 6/8/13.
//  Copyright (c) 2013 Tapatory, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVTask : NSObject

@property (nonatomic, strong) NSString *taskName;
@property (nonatomic, assign) float value;

+ (DVTask *)taskWithName:(NSString *)taskName andValue:(float)value;

- (id)initWithName:(NSString *)taskName andValue:(float)value;

@end
