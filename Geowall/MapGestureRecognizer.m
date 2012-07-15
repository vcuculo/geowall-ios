//
//  MapGestureRecognizer.m
//  Geowall
//
//  Created by Vittorio Cuculo on 15/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapGestureRecognizer.h"

@implementation MapGestureRecognizer

- (MapGestureRecognizer*)initWithController:(MapViewController*) controller {
    self = [super init];
    mController = controller;
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
    dragging = NO;
    if ([touches count] == 1) { // touched with 1 finger
        
        UITouch *touch = [touches anyObject];
        
        if ([touch tapCount] == 1){ // single-tap
            MKPolygonView* touchedOverlay = [self getOverlayFromTouch:touch];
            
            if (touchedOverlay != nil)
                [self overlayTouched:touchedOverlay];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    dragging = YES;
    
    UITouch *touch = [touches anyObject];
    
    MKPolygonView* touchedOverlay = [self getOverlayFromTouch:touch];
    
    if (touchedOverlay != nil)
        [self overlayReleased:touchedOverlay];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!dragging) {
        UITouch *touch = [touches anyObject];            
        MKPolygonView* touchedOverlay = [self getOverlayFromTouch:touch];
        
        if (touchedOverlay != nil){
            [self overlayReleased:touchedOverlay];
            [mController openNoticeboard:[[mController areas] indexOfObject:touchedOverlay]];
        }
    }
}

- (void) overlayTouched:(MKPolygonView*) overlay{
    overlay.fillColor=[[UIColor redColor] colorWithAlphaComponent:0.4];
    [overlay setNeedsDisplay];
}

- (void) overlayReleased:(MKPolygonView*) overlay{
    overlay.fillColor=[[UIColor whiteColor] colorWithAlphaComponent:0.4];
    [overlay setNeedsDisplay];
}

- (MKPolygonView*) getOverlayFromTouch:(UITouch*) touch {
    for (MKPolygonView *overlayView in [mController areas]) { 
        CGSize overlayViewSize = overlayView.frame.size;
        
        CGPoint touchPoint = [touch locationInView:overlayView];
        
        if (touchPoint.x > 0 && touchPoint.x < overlayViewSize.width && touchPoint.y > 0 && touchPoint.y < overlayViewSize.height) {
            return overlayView;
        }
    }
    return nil;
}

@end
