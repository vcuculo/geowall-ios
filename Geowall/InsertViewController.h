//
//  InsertViewController.h
//  Geowall
//
//  Created by Vittorio Cuculo on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Message.h"
#import "NSData+Base64.h"
#import "CommunicationController.h"

@interface InsertViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    IBOutlet UITextView *textView;
    IBOutlet UIButton *uploadImage;
    IBOutlet UIImageView *uploadedImage;
    UIImagePickerController *imagePicker;
    int posx, posy;
}

@property (nonatomic, retain) UIImagePickerController *imagePicker;

- (id)initWithPosx:(int) mPosX andPosy:(int) mPosY;
-(IBAction)uploadImage:(id)sender;

@end
