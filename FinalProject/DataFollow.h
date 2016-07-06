//
//  Data.h
//  FinalProject
//
//  Created by xcode on 2015-04-23.
//  Copyright (c) 2015 xcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataFollow : NSObject
{
    NSString *name;
}

@property (nonatomic, strong) NSString *name;
-(id)initWithData:(NSString *)n;

@end
