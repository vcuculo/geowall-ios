//
//  SignupViewController.h
//  Geowall
//
//  Created by Vittorio Cuculo on 09/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "NSData+Base64.h"
#import "CommunicationController.h"
#import "MapViewController.h"
#import "NSString+MD5.h"

@interface SignupViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    IBOutlet UITextField *userText;
    IBOutlet UITextField *emailText;
    IBOutlet UITextField *passwordText;
    
    IBOutlet UITextField *birthdayText;
    IBOutlet UITextField *countryText;
    IBOutlet UITextField *cityText;
    IBOutlet UIButton *avatarImage;
    IBOutlet UILabel *mySQLBirthday;
    
    UIImagePickerController *imagePicker;
}

@property (nonatomic, retain) UIImagePickerController *imagePicker;

- (IBAction)changeAvatar:(id)sender;

@end
