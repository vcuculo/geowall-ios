//
//  InsertViewController.m
//  Geowall
//
//  Created by Vittorio Cuculo on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InsertViewController.h"

@interface InsertViewController ()

@end

@implementation InsertViewController

@synthesize imagePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPosx:(int) mPosX andPosy:(int) mPosY
{    
    self = [super init];
    if (self) {
        posx = mPosX;
        posy = mPosY;   
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"ravenna.png"]];
    
    UIBarButtonItem *doneButton = [[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonSystemItemDone target:self action:@selector(send:)] autorelease];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    [textView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [textView.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [textView.layer setBorderWidth: 1.0];
    [textView.layer setCornerRadius:8.0f];
    [textView.layer setMasksToBounds:YES];
    
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

- (void)send:(id) sender {  
    
    UIImage *image = [uploadedImage image];
    NSString *image64 = nil;
    
    if (image != nil){
        NSData *flatImage = UIImageJPEGRepresentation(image, 0.1f);
        image64 = [flatImage base64EncodedString];
    }
    
    Message* mess = [[Message alloc] initWithText:textView.text image:image64 video:nil];
    [CommunicationController insertMessage:mess atPosX:posx andPosY:posy];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)uploadImage:(id)sender
{
    [self presentModalViewController:imagePicker animated:YES];
}

- (void) imagePickerController: (UIImagePickerController*) picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];

    [uploadedImage setImage:image];
    
    [imagePicker dismissModalViewControllerAnimated:YES];
}

@end
