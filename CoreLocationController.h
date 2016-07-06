//
//  CoreLocationController.h
//  FinalProject
//
//  Created by xcode on 2015-04-23.
//  Copyright (c) 2015 xcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol CoreLocationControllerDelegate

@required
- (void)update:(CLLocation *)location;
- (void)locationError:(NSError *)error;
@end

@interface CoreLocationController : NSObject<CLLocationManagerDelegate>
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) id delegate;

@end
