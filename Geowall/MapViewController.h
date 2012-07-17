//
//  MapViewController.h
//  Geowall
//
//  Created by Vittorio Cuculo on 13/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapGestureRecognizer.h"
#import "WallViewController.h"
#import "CommunicationController.h"

@interface MapViewController : UIViewController <MKMapViewDelegate> {
    MKMapView *myMap;
    NSArray* views;
    NSMutableArray *areas;
}
- (void) openNoticeboard:(NSInteger) index;
- (NSMutableArray*) areas;
@end
