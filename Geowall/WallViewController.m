//
//  WallViewController.m
//  Geowall
//
//  Created by Vittorio Cuculo on 15/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WallViewController.h"

@interface WallViewController ()

@end

@implementation WallViewController


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";

    if (myMessages.count == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.detailTextLabel.text = @"Questa bacheca è vuota, inserisci il primo messaggio!";
        cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.textAlignment = UITextAlignmentCenter;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSUInteger count = [myMessages count];
    Message *mess = [myMessages objectAtIndex:(count-[indexPath row]-1)];
    
    if (mess.image != nil){
        
        NSData *base64Image = [NSData dataFromBase64String:mess.image];
        UIImage *image = [[UIImage alloc] initWithData:base64Image];

        cell.imageView.image = image;
    }
    
    cell.textLabel.text = mess.testo;
    cell.detailTextLabel.text = [[mess.nick stringByAppendingString:@" - "] stringByAppendingString: mess.data];
    cell.userInteractionEnabled = NO;
    [cell.layer setCornerRadius:7.0f];
    [cell.layer setBorderWidth:1.0f];
    [cell.layer setMasksToBounds:YES];

    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size: 15.0];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.textLabel.backgroundColor = [UIColor whiteColor];
    cell.detailTextLabel.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ([myMessages count] == 0) ? 1 : [myMessages count];
}

- (id)initWithEditable:(BOOL) isEditable andPosX:(int)posx andPosY:(int)posy
{
    self = [super init];
    if (self) {
        editable = isEditable;
        wallPosx = posx;
        wallPosy = posy;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updateMessages{
    myMessages = [CommunicationController getNoticeboardWithPosX:wallPosx andPosY:wallPosy since:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateMessages];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"ravenna.png"]];
    if (editable) {
        UIBarButtonItem *insertButton = [[[UIBarButtonItem alloc] initWithTitle:@"Insert" style:UIBarButtonSystemItemCompose target:self action:@selector(insertMessage:)] autorelease];
        self.navigationItem.rightBarButtonItem = insertButton;
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)insertMessage:(id) sender{
    InsertViewController *insertView = [[InsertViewController alloc] initWithPosx:wallPosx andPosy:wallPosy];
    [[super navigationController] pushViewController:insertView animated:YES];
    [insertView release];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([myMessages count] > 0) {
        
        Message *mess = [myMessages objectAtIndex:[indexPath row]] ;
        NSString *text = mess.testo;
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        CGFloat height = MAX(size.height, 44.0f);
        
        return height + (CELL_CONTENT_MARGIN * 2);
    }
    
    return 44.0f;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
