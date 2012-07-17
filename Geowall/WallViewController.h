//
//  WallViewController.h
//  Geowall
//
//  Created by Vittorio Cuculo on 15/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Message.h"
#import "NSData+Base64.h"
#import "InsertViewController.h"

@interface WallViewController : UITableViewController{
    NSMutableArray* myMessages;
    BOOL editable;
    int wallPosx, wallPosy;
}
- (id)initWithEditable:(BOOL) isEditable andPosX:(int) posx andPosY:(int) posy;

@end
