//
//  MapViewController.m
//  Foursquare CheckIn
//
//  Created by Suniket Wagh on 3/20/13.
//  Copyright (c) 2013 Suniket Wagh. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "FSVenue.h"
#import "MyAnnotation.h"


@interface MapViewController ()

@end

@implementation MapViewController

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

    
    [self.myMapView setDelegate:self];
	[self.myMapView setMapType:MKMapTypeStandard];
	[self.myMapView setZoomEnabled:YES];
	[self.myMapView setScrollEnabled:YES];
    self.myMapView.showsUserLocation = YES;
    
    NSMutableArray *annotnArray;
    MyAnnotation* myAnnotation1=[[MyAnnotation alloc] init];
    
    CLLocationCoordinate2D location = [[[self.myMapView userLocation] location] coordinate];
    NSLog(@"Location found from Map: %f %f",location.latitude,location.longitude);
    
//    for (int i=0; i<[self.locatioArray count]; i++) {
//        FSVenue *venue = [self.locatioArray objectAtIndex:i];
//        CLLocationCoordinate2D coordinate = venue.location.coordinate;
//        
//        
//        myAnnotation1.coordinate=coordinate;
//        myAnnotation1.title= venue.name;
//        myAnnotation1.subtitle= venue.venueId;
//        NSLog(@"venue.name = %@",venue.name);
//
//        // Its Taking last value.
//        
//        [self.annotnArray addObject:myAnnotation1];
//        NSLog(@"self.annotnArray = %d",[self.annotnArray count]);
//
//        [self.myMapView addAnnotation:myAnnotation1];
//
//    }

    [self proccessAnnotations];
}

-(void)removeAllAnnotationExceptOfCurrentUser
{
    NSMutableArray *annForRemove = [[NSMutableArray alloc] initWithArray:self.myMapView.annotations];
    if ([self.myMapView.annotations.lastObject isKindOfClass:[MKUserLocation class]]) {
        [annForRemove removeObject:self.myMapView.annotations.lastObject];
    }else{
        for (id <MKAnnotation> annot_ in self.myMapView.annotations)
        {
            if ([annot_ isKindOfClass:[MKUserLocation class]] ) {
                [annForRemove removeObject:annot_];
                break;
            }
        }
    }
    
    
    [self.myMapView removeAnnotations:annForRemove];
}

-(void)proccessAnnotations{
    [self removeAllAnnotationExceptOfCurrentUser];
    [self.myMapView addAnnotations:self.locatioArray];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	NSLog(@"welcome into the map view annotation");
	
	// if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
	// try to dequeue an existing pin view first
	static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
	MKPinAnnotationView* pinView = [[MKPinAnnotationView alloc]
                                    initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
	pinView.animatesDrop=YES;
	pinView.canShowCallout=YES;
	pinView.pinColor=MKPinAnnotationColorPurple;
	
	
	UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[rightButton setTitle:annotation.title forState:UIControlStateNormal];
	[rightButton addTarget:self
					action:@selector(showDetails:)
		  forControlEvents:UIControlEventTouchUpInside];
	pinView.rightCalloutAccessoryView = rightButton;
	
    return pinView;
    //	UIImageView *profileIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile.png"]];
    //	pinView.leftCalloutAccessoryView = profileIconView;
	
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control
{
    
    NSString* title = view.annotation.title;
    
    
    NSLog(@"title::%@",title);
    
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    // Annotation is your custom class that holds information about the annotation
    if ([view.annotation isKindOfClass:[MyAnnotation class]]) {
        MyAnnotation *annot = view.annotation;
        NSInteger index = [self.annotnArray indexOfObject:annot];
        NSLog(@"index::%d",index);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithMyArray:(NSArray *)_locationArray
{
    if (self) {
        self.locatioArray = _locationArray;
        NSLog(@"self.locatioArray: %d",[self.locatioArray count]);
    }
    
    return self;
}

-(IBAction)showDetails:(id)sender{
    
	NSLog(@"Annotation Click");
    
}


@end
