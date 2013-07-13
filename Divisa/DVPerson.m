//
//  DVPerson.m
//  Divisa
//
//  Created by Scott Andrus on 6/8/13.
//  Copyright (c) 2013 Tapatory, LLC. All rights reserved.
//

#import "DVPerson.h"
#import "AFNetworking/AFImageRequestOperation.h"

@implementation DVPerson

+ (DVPerson *)personWithName:(NSString *)name andPhoto:(UIImage *)photo
{
    return [[DVPerson alloc] initWithName:name
                                 andPhoto:photo];
}

+ (DVPerson *)personWithName:(NSString *)name andPhotoUrl:(NSString *)photoUrl
{
    return [[DVPerson alloc] initWithName:name andPhotoUrl:photoUrl];
}

- (id)initWithName:(NSString *)name andPhoto:(UIImage *)photo
{
    self = [super init];
    if (self) {
        _name = name;
        _photo = photo;
    }
    return self;
}

- (id)initWithName:(NSString *)name andPhotoUrl:(NSString *)photoUrl
{
    self = [super init];
    if (self) {
        _name = name;
        _photoUrl = photoUrl;
    }
    return self;
}

@end
