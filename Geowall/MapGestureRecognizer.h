//
//  MapGestureRecognizer.h
//  Geowall
//
//  Created by Vittorio Cuculo on 15/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@interface MapGestureRecognizer : UIGestureRecognizer
{
    BOOL dragging;
    UIViewController *mController;
}

- (MapGestureRecognizer*) initWithController:(UIViewController*) controller;

@end
