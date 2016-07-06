//
//  MapViewController.h
//  FinalProject
//
//  Created by xcode on 2015-04-23.
//  Copyright (c) 2015 xcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CoreLocationController.h"

@interface MapViewController : UIViewController<CoreLocationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblLongitude;
@property (weak, nonatomic) IBOutlet UILabel *lblLatitude;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, retain) CoreLocationController *locationController;


@end
