//
//  ProjectData.m
//  iOS_project
//
//  Created by Amandeep Brar on 2015-04-18.
//  Copyright (c) 2015 Amandeep Brar. All rights reserved.
//

#import "ProjectData.h"

@implementation ProjectData
//sysnthesize varaibles from the project.h
-(id)initWithData:(NSString *) u theFirstname:(NSString *) f theLastname:(NSString *) l theEmail:(NSString *)e thePassword:(NSString *)p
{
    if(self = [self init])
    {
        [self setUsername:u];
        [self setFirstname:f];
        [self setLastname:l];
        [self setEmail:e];
        [self setPassword:p];
    }
    return self;
}
//set password seperate for validation at user login
-(id)initWithData:(NSString *) password
{
    if(self = [self init])
    {
        [self setPassword:password];
    }
    return self;
}


@end
