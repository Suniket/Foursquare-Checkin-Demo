//
//  MapViewController.h
//  Foursquare CheckIn
//
//  Created by Suniket Wagh on 3/20/13.
//  Copyright (c) 2013 Suniket Wagh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController  <MKMapViewDelegate>
{
    CLLocationManager *_locationManager;
    NSArray *locatioArray;
   IBOutlet MKMapView *myMapView;
    NSMutableArray *annotnArray;

}
@property (strong, nonatomic) IBOutlet MKMapView *myMapView;
- (id)initWithMyArray:(NSArray *)_locationArray;
@property (strong, nonatomic)NSArray *locatioArray;
@property (strong, nonatomic)    NSMutableArray *annotnArray;

@end
