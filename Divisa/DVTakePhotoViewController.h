//
//  DVTakePhotoViewController.h
//  Divisa
//
//  Created by Scott Andrus on 7/13/13.
//  Copyright (c) 2013 Tapatory, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DVPerson.h"
#import "DVPersonImageView.h"

@interface DVTakePhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) DVPerson *person;
@property (strong, nonatomic) DVPersonImageView *personImageView;

@property (weak, nonatomic) IBOutlet UILabel *takeAPhotoLabel;
@property (weak, nonatomic) IBOutlet UILabel *whatsYourNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *formAGroupButton;

@end
