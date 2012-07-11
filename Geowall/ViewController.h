//
//  ViewController.h
//  Geowall
//
//  Created by Vittorio Cuculo on 07/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunicationController.h"
#import "SignupViewController.h"

@interface ViewController : UIViewController{
    IBOutlet UITextField *userText;
    IBOutlet UITextField *passwordText;
    IBOutlet UIButton *loginButton;
    IBOutlet UIButton *signupButton;
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString;
-(IBAction)loginButton:(id)sender;
-(IBAction)signupButton:(id)sender;
@end
