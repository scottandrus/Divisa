//
//  DVResponsibility.h
//  Divisa
//
//  Created by Scott Andrus on 6/8/13.
//  Copyright (c) 2013 Tapatory, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVPerson.h"

@interface DVResponsibility : NSObject

@property (nonatomic, strong) NSString *responsibilityName;
@property (nonatomic, strong) NSMutableArray *assignedPeople;
@property (nonatomic, strong) NSMutableArray *tasks;
@property (nonatomic, strong) NSMutableDictionary *tasksToPeople;

+ (DVResponsibility *)responsibilityWithName:(NSString *)name tasks:(NSMutableArray *)tasks andPeople:(NSMutableArray *)people;

- (id)initWithName:(NSString *)name tasks:(NSMutableArray *)tasks andPeople:(NSMutableArray *)people;
- (void)addPersonToResponsibility:(DVPerson *)person;

@end
