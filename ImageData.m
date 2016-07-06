//
//  ImageData.m
//  ProjectVictorPages
//
//  Created by xcode on 2015-04-22.
//  Copyright (c) 2015 Victor Cabrera. All rights reserved.
//

#import "ImageData.h"

@implementation ImageData
@synthesize imageName, imageUsername;

// this is the constructor that when instantiated, will hold the data from the database
-(id)initWithData:(NSString *)name theImageUsername:(NSString *)username
{
    if(self = [super init])
    {
        [self setImageName:name];
        [self setImageUsername:username];
    }
    
    return self;
}

@end
