//
//  MapViewController.m
//  Geowall
//
//  Created by Vittorio Cuculo on 13/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

double LON_FACTOR = 0.01;
double LAT_FACTOR = 0.005;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    myMap = [[MKMapView alloc] init];
    myMap.showsUserLocation = YES;
    myMap.delegate = self;
    
    areas = [[NSMutableArray alloc] init];
    MapGestureRecognizer *gestureRecognizer = [[MapGestureRecognizer alloc] initWithController: self];
    [myMap addGestureRecognizer:gestureRecognizer];
    
    self.view = myMap;
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

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id )overlay{
    if([overlay isKindOfClass:[MKPolygon class]]){
        MKPolygonView *view = [[[MKPolygonView alloc] initWithOverlay:overlay] autorelease];
        view.lineWidth=0.5;
        view.strokeColor=[UIColor blackColor];
        view.fillColor=[[UIColor whiteColor] colorWithAlphaComponent:0.4];
        [areas addObject:view];
        return view;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.02;
    span.longitudeDelta = 0.02;
    CLLocationCoordinate2D location;
    location.latitude = userLocation.coordinate.latitude;
    location.longitude = userLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [mapView setRegion:region animated:YES];
    
    for (int i = 0 ; i < 9 ; i++){
        double latfact = -(i / 3) + 1;
        double lonfact = (i % 3) - 1;
        
        double lat = (ceil(location.latitude*100)/100) + (latfact * LAT_FACTOR);
        double lon = (floor(location.longitude*100)/100) + (lonfact * LON_FACTOR);
        
        CLLocationCoordinate2D roundedLocation = CLLocationCoordinate2DMake(lat,lon);
        
        CLLocationCoordinate2D area[5];
        area[0] = roundedLocation;
        area[1] = CLLocationCoordinate2DMake(roundedLocation.latitude, roundedLocation.longitude + LON_FACTOR);
        area[2] = CLLocationCoordinate2DMake(roundedLocation.latitude - LAT_FACTOR , roundedLocation.longitude + LON_FACTOR);
        area[3] = CLLocationCoordinate2DMake(roundedLocation.latitude - LAT_FACTOR, roundedLocation.longitude);
        area[4] = roundedLocation;

        MKPolygon *rect = [MKPolygon polygonWithCoordinates:area count:5];
        [mapView addOverlay:rect];
        [rect release];
    }
}

-(NSMutableArray*) areas{
    return areas;
}

-(void) openNoticeboard:(NSInteger) index{
    MKPolygonView* view = [areas objectAtIndex:index];
    
    MKPolygon* noticeboard = [view polygon];

    CLLocationCoordinate2D noticeboardPosition[1];
    [noticeboard getCoordinates:noticeboardPosition range:NSMakeRange(0, 1)];
    int posx = round(noticeboardPosition[0].latitude * 1E6);
    int posy = round(noticeboardPosition[0].longitude * 1E6);
    
    [CommunicationController getNoticeboardWithPosx:posx andPosY:posy since:nil];
    WallViewController *wallView = [[WallViewController alloc] init];
    [[super navigationController] pushViewController:wallView animated:YES];
}


@end
