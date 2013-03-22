//
//  ViewController.h
//  Foursquare CheckIn
//
//  Created by Suniket Wagh on 3/20/13.
//  Copyright (c) 2013 Suniket Wagh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSVenue.h"

@interface ViewController : UIViewController
{
    NSArray *nearbyVenues;
}
@property(strong,nonatomic)FSVenue* venue;
@property(strong,nonatomic)NSArray *nearbyVenues;
- (IBAction)checkBtnAction:(id)sender;
- (IBAction)seeOnMap:(id)sender;

@end
