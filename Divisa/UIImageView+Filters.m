//
//  UIImageView+Filters.m
//  Divisa
//
//  Created by Scott Andrus on 7/13/13.
//  Copyright (c) 2013 Tapatory, LLC. All rights reserved.
//

#import <CoreImage/CoreImage.h>

#import "UIImageView+Filters.h"

@implementation UIImageView (Filters)

- (void)applyGaussianBlur
{
    CIImage *image = self.image.CIImage;
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setDefaults];
    [filter setValue:image forKey:@"inputImage"];
//    [filter setValue:[NSNumber numberWithFloat:1.0f] forKey:@"inputIntensity"];
    CIImage *outputImage = [filter valueForKey:@"outputImage"];
    
    //set the UIImage object to the UIImageView
    self.image = [UIImage imageWithCIImage:outputImage];
}

@end
