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

@interface SignupViewController : UIViewController
{
    IBOutlet UITextField *userText;
    IBOutlet UITextField *emailText;
    IBOutlet UITextField *passwordText;
    
    IBOutlet UITextField *birthdayText;
    IBOutlet UITextField *countryText;
    IBOutlet UITextField *cityText;
    IBOutlet UIButton *avatarImage;
    
    UIImagePickerController *imagePicker;
}

@property (nonatomic, retain) UIImagePickerController *imagePicker;

-(IBAction)changeAvatar:(id)sender;

@end
