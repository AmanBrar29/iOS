//
//  BackgroundLayer.m
//  iOS_project
//
//  Created by Amandeep Brar on 2015-04-18.
//  Copyright (c) 2015 Amandeep Brar. All rights reserved.
//

#import "BackgroundLayer.h"

@implementation BackgroundLayer

//Metallic grey gradient background
+ (CAGradientLayer*) greyGradient {
    //Set up four colors to mix up to create a gradient bacground
    UIColor *colorOne = [UIColor colorWithWhite:0.9 alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.85 alpha:1.0];
    UIColor *colorThree     = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.7 alpha:1.0];
    UIColor *colorFour = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.4 alpha:1.0];
    
    //put all the color variables in array
    NSArray *colors =  [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, colorThree.CGColor, colorFour.CGColor, nil];
    
    //set up stop point to define area fro specific color
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:0.02];
    NSNumber *stopThree     = [NSNumber numberWithFloat:0.99];
    NSNumber *stopFour = [NSNumber numberWithFloat:1.0];
    
    //put all the stop points in array
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, stopThree, stopFour, nil];
    //define A CA gradient layer to customize the background
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    //put the color in gradeint attribute
    headerLayer.colors = colors;
    //put the location(stop point of color) in gradient layer attribute
    headerLayer.locations = locations;
    
    return headerLayer;
    
}

//Blue gradient background
+ (CAGradientLayer*) blueGradient {
     //Set up four colors to mix up to create a gradient bacground
    UIColor *colorOne = [UIColor colorWithRed:(120/255.0) green:(135/255.0) blue:(150/255.0) alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:(57/255.0)  green:(79/255.0)  blue:(96/255.0)  alpha:1.0];
    
    //put all the color variables in array
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    //set up stop point to define area fro specific color

    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    //put all the stop points in array
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
     //define A CA gradient layer to customize the background
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
     //put the color in gradeint attribute
    headerLayer.colors = colors;
    //put the location(stop point of color) in gradient layer attribute
    headerLayer.locations = locations;
    
    return headerLayer;
    
}

@end
