//
//  SettingsViewController.m
//  Foursquare CheckIn
//
//  Created by Suniket Wagh on 3/20/13.
//  Copyright (c) 2013 Suniket Wagh. All rights reserved.
//

#import "SettingsViewController.h"
#import "Foursquare2.h"


@interface SettingsViewController ()

@end

@implementation SettingsViewController

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

    [self prepareViewForUser];
    self.title = @"Settings";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutAction:(id)sender {
    
    [Foursquare2 removeAccessToken];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareViewForUser{
    [Foursquare2  getDetailForUser:@"self"
                          callback:^(BOOL success, id result){
                              if (success) {
                                  nameLbl.text =
                                  [NSString stringWithFormat:@"%@ %@",
                                   [result valueForKeyPath:@"response.user.firstName"],
                                   [result valueForKeyPath:@"response.user.lastName"]];
                              }
                          }];
}


@end
