//
//  MapViewController.m
//  FinalProject
//
//  Created by xcode on 2015-04-23.
//  Copyright (c) 2015 xcode. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapView, lblLatitude, lblLongitude;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //to allow to show user location
    self.mapView.showsUserLocation = YES;
    
    self.locationController = [[CoreLocationController alloc] init];
    self.locationController.delegate = self;
    [self.locationController.locationManager startUpdatingLocation];
}

//methods to update the labels based on the location of the user
- (void)update:(CLLocation *)location {
    self.lblLatitude.text= [NSString stringWithFormat:@"Latitude: %f", [location coordinate].latitude];
    self.lblLongitude.text = [NSString stringWithFormat:@"Longitude: %f", [location coordinate].longitude];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    //We need to update location for iOS 8 but for iO7 it already gets the location updates
    
    if (status == kCLAuthorizationStatusAuthorizedAlways ||
        status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [manager startUpdatingLocation];
    }
}

/*
// iOS 8 - request location services via requestWhenInUseAuthorization.
if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
{
    [self.locationManager requestWhenInUseAuthorization];
}
*/
- (void)locationError:(NSError *)error {
    self.lblLatitude.text = [error description];
    self.lblLongitude.text = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
