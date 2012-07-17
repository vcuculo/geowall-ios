//
//  ViewController.m
//  Geowall
//
//  Created by Vittorio Cuculo on 07/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)loginButton:(id)sender
{
    NSString *usermail = userText.text;
    NSString *pass = passwordText.text;
    NSString *result;
    
    if ([usermail length] == 0 || [pass length] == 0)
    {
        UIAlertView *empty = [[[UIAlertView alloc] initWithTitle: @"Login error" message: @"Username or password empty." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil] autorelease];
        [empty show];
        return;
    }
    
    if ([self NSStringIsValidEmail:usermail])
        result = [CommunicationController loginWithEmail:usermail andPassword:[pass MD5]];
    else 
        result = [CommunicationController loginWithUsername:usermail andPassword:[pass MD5]];
    
    if ([result hasPrefix:@"error:"]) {
        UIAlertView *error = [[[UIAlertView alloc] initWithTitle: @"Login error" message: result delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil] autorelease];
        [error show];
    } else {
        MapViewController *mapView = [[[MapViewController alloc] init] autorelease];
        [[self navigationController] pushViewController:mapView animated:YES];
    }
}

- (IBAction)signupButton:(id)sender
{
    SignupViewController *signupView = [[[SignupViewController alloc] init] autorelease];
    [[self navigationController] pushViewController:signupView animated:YES];
}

- (BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; 
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"ravenna.png"]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

@end
