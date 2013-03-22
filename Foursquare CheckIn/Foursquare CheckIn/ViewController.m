//
//  ViewController.m
//  Foursquare CheckIn
//
//  Created by Suniket Wagh on 3/20/13.
//  Copyright (c) 2013 Suniket Wagh. All rights reserved.
//

#import "ViewController.h"
#import "Foursquare2.h"
#import "FSVenue.h"
#import "SettingsViewController.h"
#import "FSConverter.h"
#import "MapViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [Foursquare2 searchVenuesNearByLatitude:@(18.9647)
								  longitude:@(72.8258)
								 accuracyLL:nil
								   altitude:nil
								accuracyAlt:nil
									  query:nil
									  limit:nil
									 intent:intentCheckin
                                     radius:@(2000)
								   callback:^(BOOL success, id result){
									   if (success) {
										   NSDictionary *dic = result;
										   NSArray* venues = [dic valueForKeyPath:@"response.venues"];
                                           FSConverter *converter = [[FSConverter alloc]init];
                                           self.nearbyVenues = [converter convertToObjects:venues];
                                           
                                           self.venue = [self.nearbyVenues objectAtIndex:13];
                                         
                                           NSLog(@"count = %d",[self.nearbyVenues count]);
                                           NSLog(@"id = %@",self.venue.venueId);
                                           NSLog(@"name = %@",self.venue.name);

                                           									   }
								   }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([Foursquare2 isAuthorized] == YES) {
        [self addRightButton];
        
    }else{
        self.navigationItem.rightBarButtonItem = nil;
    }
}

-(void)addRightButton{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(settings)];
}

-(void)userDidSelectVenue{
    if ([Foursquare2 isAuthorized]) {
        [self checkin];
	}else{
        [Foursquare2 authorizeWithCallback:^(BOOL success, id result) {
            if (success) {
				[Foursquare2  getDetailForUser:@"self"
									  callback:^(BOOL success, id result){
										  if (success) {
                                              [self addRightButton];
											  [self checkin];
										  }
									  }];
			}
        }];
    }
}


-(void)checkin
{

  
    [Foursquare2  createCheckinAtVenue:self.venue.venueId
                             venue:nil
                             shout:@"Testing"
                         broadcast:broadcastPublic
                          latitude:nil
                             longitude:nil
                        accuracyLL:nil
                          altitude:nil
                       accuracyAlt:nil
                          callback:^(BOOL success, id result){
                              if (success) {
                                  UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Checkin"
                                                                                 message:@"Success"
                                                                                delegate:self
                                                                       cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                                  [alert show];
                              }
                          }];

}

-(void)settings{
    SettingsViewController *settings = [[SettingsViewController alloc]init];
    [self.navigationController pushViewController:settings animated:YES];
}


- (IBAction)checkBtnAction:(id)sender {
    
    [self userDidSelectVenue];
}

- (IBAction)seeOnMap:(id)sender {
    
    MapViewController *mapViewController = [[MapViewController alloc]initWithMyArray:self.nearbyVenues];
    [self.navigationController pushViewController:mapViewController animated:YES];
}


@end
