//
//  SignupViewController.m
//  Geowall
//
//  Created by Vittorio Cuculo on 09/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

@synthesize imagePicker;

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"ravenna.png"]];
    
    UIDatePicker *datePicker = [[[UIDatePicker alloc] init] autorelease];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    birthdayText.inputView = datePicker;
    
    UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(signup:)] autorelease];
    self.navigationItem.rightBarButtonItem = doneButton;
   
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = true;
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
}
    
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) imagePickerController: (UIImagePickerController*) picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
    [avatarImage setBackgroundImage:image forState:UIControlStateNormal];
    [imagePicker dismissModalViewControllerAnimated:YES];
}

- (void)changeDate:(UIDatePicker *)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    NSDateFormatter *MySQLdateFormatter = [[NSDateFormatter alloc] init];
    [MySQLdateFormatter setDateFormat:@"yyyy-MM-dd"];

    birthdayText.text = [dateFormatter stringFromDate: sender.date];
    mySQLBirthday.text = [MySQLdateFormatter stringFromDate: sender.date];
}

- (void)hidePicker:(UIDatePicker *)sender {
    NSLog(@"doubleclick");
    sender.hidden = YES;
}

- (IBAction)changeAvatar:(id)sender
{
    [self presentModalViewController:imagePicker animated:YES];
}

- (void)signup:(id) sender {  
    NSString *result;

    if (userText.text.length == 0 || emailText.text.length == 0 || passwordText.text.length == 0)
    {
        UIAlertView *empty = [[[UIAlertView alloc] initWithTitle: @"Login error" message: @"Please fill required fields." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil] autorelease];
        [empty show];
    }
    else {
        
        UIImage *avatar = [avatarImage backgroundImageForState:UIControlStateNormal];
        NSData *flatImage = UIImageJPEGRepresentation(avatar, 0.1f);
        NSString *image64 = [flatImage base64EncodedString];
        
        User *u = [[User alloc] initWithUsername:userText.text email:emailText.text password: [passwordText.text MD5] avatar:image64 city:cityText.text country:countryText.text birthday:mySQLBirthday.text];
        
        result = [CommunicationController registerWithUser:u];
        
        if ([result hasPrefix:@"error:"]) {
            UIAlertView *error = [[[UIAlertView alloc] initWithTitle: @"Sign up error" message: result delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil] autorelease];
            [error show];
        } else {
             MapViewController *mapView = [[MapViewController alloc] init];
            [[self navigationController] pushViewController:mapView animated:YES];
        }
    }
    return;
}

@end
