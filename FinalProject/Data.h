//
//  Data.h
//  JoellyounRajendramA1
//
//  Created by xcode on 2015-04-08.
//  Copyright (c) 2015 CBG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject
{
        NSString *image;
        NSString *imageName;
        NSString *comment;
        NSString *likes;
        NSString *uId;
}
@property (nonatomic, retain)NSString *image;
@property (nonatomic, strong)NSString *imageName;
@property (nonatomic, strong)NSString *comment;
@property (nonatomic, strong)NSString *likes;
@property (nonatomic, strong)NSString *uId;
-(id)initWithData:(NSString *) img theImgName:(NSString *)imgN theComment:(NSString *)c theLikes:(NSString *)l theUserId:(NSString *)uId;
@end
