//
//  ListPhotosVC.m
//  Peekme
//
//  Created by Juan on 27/02/14.
//  Copyright (c) 2014 JSoft. All rights reserved.
//

#import "ListPhotosVC.h"

@interface ListPhotosVC ()

@end

@implementation ListPhotosVC

@synthesize latitude;
@synthesize longitude;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // SystemStatusBar TintColor Fix
    [self setNeedsStatusBarAppearanceUpdate];
    
    NSLog(@"Latitude: %@", self.latitude);
    NSLog(@"Longitude: %@", self.longitude);
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    //self.navigationItem.hidesBackButton = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// SystemStatusBar TintColor Fix
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
