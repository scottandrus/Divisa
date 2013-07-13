//
//  DVPersonImageView.m
//  Divisa
//
//  Created by Scott Andrus on 6/8/13.
//  Copyright (c) 2013 Tapatory, LLC. All rights reserved.
//

#import "DVPersonImageView.h"
#import "UIImageView+AFNetworking.h"

@implementation DVPersonImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithPerson:(DVPerson *)person
{
    if (person.photo) {
        self = [super initWithImage:person.photo];
    } else {
        self = [super init];
        if (self) {
            [self setImageWithURL:[NSURL URLWithString:person.photoUrl]];
        }
    }

    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
