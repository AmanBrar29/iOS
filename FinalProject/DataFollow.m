//
//  Data.m
//  FinalProject
//
//  Created by xcode on 2015-04-23.
//  Copyright (c) 2015 xcode. All rights reserved.
//

#import "DataFollow.h"

@implementation DataFollow
@synthesize name;

//setting the name of the followers in the label of tableviewcell
-(id)initWithData:(NSString *)n
{
    if(self = [super init])
    {
        [self setName:n];
    }
    return self;
        
}

@end
