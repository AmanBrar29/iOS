//
//  ProjectData.h
//  iOS_project
//
//  Created by Amandeep Brar on 2015-04-18.
//  Copyright (c) 2015 Amandeep Brar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectData : NSObject
{
    //NSString variables to store information while user register and later required for login 
    NSString *username;
    NSString * password;
    NSString * firstname;
    NSString * lastname;
    NSString *email;
}

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString * password;
@property (nonatomic, strong) NSString * firstname;
@property (nonatomic, strong) NSString * lastname;
@property (nonatomic, strong) NSString *email;

-(id)initWithData:(NSString *) u theFirstname:(NSString *) f theLastname:(NSString *) l theEmail:(NSString *)e thePassword:(NSString *)p;
-(id)initWithPassword:(NSString *) password;

@end
