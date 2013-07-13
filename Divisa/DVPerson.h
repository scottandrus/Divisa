//
//  DVPerson.h
//  Divisa
//
//  Created by Scott Andrus on 6/8/13.
//  Copyright (c) 2013 Tapatory, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVPerson : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *photo;
@property (nonatomic, strong) NSString *photoUrl;
@property (nonatomic, strong) NSArray *tasks;

+ (DVPerson *)personWithName:(NSString *)name andPhoto:(UIImage *)photo;
+ (DVPerson *)personWithName:(NSString *)name andPhotoUrl:(NSString *)photoUrl;

- (id)initWithName:(NSString *)name andPhoto:(UIImage *)photo;
- (id)initWithName:(NSString *)name andPhotoUrl:(NSString *)photoUrl;

@end
