//
//  ImageData.h
//  ProjectVictorPages
//
//  Created by xcode on 2015-04-22.
//  Copyright (c) 2015 Victor Cabrera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageData : NSObject
{
    NSString *imageName;
    NSString *imageUsername;
}
@property(strong, nonatomic)NSString *imageName;
@property(strong, nonatomic)NSString *imageUsername;

-(id)initWithData:(NSString *)name theImageUsername:(NSString *)username;

@end
