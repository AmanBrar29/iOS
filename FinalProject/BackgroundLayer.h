//
//  BackgroundLayer.h
//  iOS_project
//
//  Created by Amandeep Brar on 2015-04-18.
//  Copyright (c) 2015 Amandeep Brar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface BackgroundLayer : NSObject
//CA Gradient layer : grey to set background at register and reset password page
+(CAGradientLayer*) greyGradient;
//CA Gradient layer : blue to set background at login page
+(CAGradientLayer*) blueGradient;

@end
