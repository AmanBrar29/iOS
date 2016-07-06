//
//  Data.m
//  JoellyounRajendramA1
//
//  Created by xcode on 2015-04-08.
//  Copyright (c) 2015 CBG. All rights reserved.
//

#import "Data.h"

@implementation Data
@synthesize image,imageName,comment,likes;
-(id)initWithData:(NSString *) img theImgName:(NSString *)imgN theComment:(NSString *)c theLikes:(NSString *)l theUserId:(NSString *)uId{
    if(self = [super init])
    {
        [self setImage:img];
        [self setImageName:imgN];
        [self setComment:c];
        [self setLikes:l];
        [self setUId:uId];
    }
    
    return self;
}

@end
