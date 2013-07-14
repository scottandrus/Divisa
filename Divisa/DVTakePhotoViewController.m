//
//  DVTakePhotoViewController.m
//  Divisa
//
//  Created by Scott Andrus on 7/13/13.
//  Copyright (c) 2013 Tapatory, LLC. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>

#import "DVTakePhotoViewController.h"
#import "UIView+Frame.h"
#import "SAViewManipulator.h"
#import "UIImageView+Filters.h"

@interface DVTakePhotoViewController ()

@end

@implementation DVTakePhotoViewController

#pragma mark - View Controller Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lazy Instantiation

- (DVPerson *)person
{
    if (!_person) {
        _person = [[DVPerson alloc] initWithName:nil andPhoto:nil];
    }
    return _person;
}

#pragma mark - Actions

- (IBAction)didTapCameraButton:(id)sender
{
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

- (IBAction)nameFieldDidEnd:(id)sender
{
    UITextField *textField = sender;
    [textField resignFirstResponder];
    if (textField.text) {
        [self showNextButton];
    }
}

#pragma mark - Animations

- (void)dropImageAndShowTextField
{
    [self fadeOutView:self.cameraButton overDuration:0.25];
    [self fadeOutView:self.takeAPhotoLabel overDuration:0.25];
    
    self.personImageView = [[DVPersonImageView alloc] initWithPerson:self.person];
    self.personImageView.layer.cornerRadius = 75;
    self.personImageView.layer.masksToBounds = YES;
    self.personImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.personImageView.layer.borderWidth = 3;
    
    [SAViewManipulator addShadowToView:self.personImageView
                           withOpacity:1
                                radius:3
                             andOffset:CGSizeMake(1, 1)];
    self.personImageView.layer.shouldRasterize = YES;
    self.personImageView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    self.personImageView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.personImageView applyGaussianBlur];
    
    CGRect frame = self.personImageView.frame;
    frame.size = CGSizeMake(150, 150);
    frame.origin = CGPointMake(self.view.frame.size.width / 2.0 - frame.size.width / 2.0,
                               -1 * frame.size.height);
    self.personImageView.frame = frame;
    [self.view addSubview:self.personImageView];
    frame.origin.y = 2.0 * self.view.frame.size.height / 3.0 - frame.size.height / 2.0;
    [UIView animateWithDuration:.5 animations:^{
        self.personImageView.frame = frame;
    } completion:^(BOOL finished) {
        [self fadeInView:self.nameTextField overDuration:0.25];
        [self fadeInView:self.whatsYourNameLabel overDuration:0.25];
    }];
}

- (void)showNextButton
{
    CGRect frame = self.personImageView.frame;
    frame.origin.y = 1.7 * self.view.frame.size.height / 3.0 - frame.size.height / 2.0;
    [UIView animateWithDuration:.5 animations:^{
        self.personImageView.frame = frame;
    } completion:^(BOOL finished) {
        [self fadeInView:self.formAGroupButton overDuration:0.25];
    }];
}

- (void)fadeOutView:(UIView *)view overDuration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration
                     animations:^{
                         view.layer.opacity = 0.0;
                     } completion:^(BOOL finished) {
                         if (finished) {
                             view.hidden = YES;
                             view.layer.opacity = 1.0;
                         }
                     }];
}

- (void)fadeInView:(UIView *)view overDuration:(NSTimeInterval)duration
{
    view.layer.opacity = 0.0;
    view.hidden = NO;
    [UIView animateWithDuration:duration
                     animations:^{
                         view.layer.opacity = 1.0;
                     } completion:nil];
}

#pragma mark - UIImagePickerController

- (BOOL)startCameraControllerFromViewController:(UIViewController*)controller
                                  usingDelegate:(id<UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>)delegate
{
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = delegate;
    
    [controller presentViewController:cameraUI animated:YES completion:nil];
    return YES;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
    
    // Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
        originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToSave = editedImage;
        } else {
            imageToSave = originalImage;
        }
        
        [self.person setPhoto:imageToSave];
        
    } else {
        // Not the correct type of input, so handle it!
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self dropImageAndShowTextField];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
