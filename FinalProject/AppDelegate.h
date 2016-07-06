//
//  AppDelegate.h
//  FinalProject
//
//  Created by xcode on 2015-04-22.
//  Copyright (c) 2015 CBG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "Data.h"
#import "ImageData.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString *databaseName;
    NSString *databasePath;
    NSMutableArray *people;
    NSMutableArray *people2;
    NSString *Image2;
    NSString *userId;
    
    //aman
    NSMutableArray *Amandata;
    
    //Victor
    NSMutableArray *arrayImageNames;
    NSMutableArray *followerIdArray;
    NSString *followerId;
    NSString *inType;
    
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *databaseName;
@property (strong, nonatomic) NSString *databasePath;
@property (strong, nonatomic) NSMutableArray *people;
@property (strong, nonatomic) NSMutableArray *people2;
@property (strong, nonatomic) NSString *Image2;

@property (strong, nonatomic) NSMutableArray *Amandata;
@property (strong, nonatomic)  NSString *userId;
//Victor
@property (strong, nonatomic)NSMutableArray *arrayImageNames;
@property (strong, nonatomic)NSMutableArray *followerIdArray;
@property (strong, nonatomic)NSString *followerId;
@property (strong, nonatomic)NSString *inType;
-(void)insertIntoFollower:(NSString *)uId theFollower:(NSString *)follow;
-(void)insertIntoDatabaseJoelly:(Data *)person;
-(void) readDataFromDatabase:(NSString *)id;
-(void)checkAndCreateDatabase;
-(void) readDataFromDatabaseWorldPage;

//aman
-(void)readDataFromDatabase_Aman:(NSString *)login;

-(void)insertIntoDatabase:(NSString *)username thePassword:(NSString *)password theFirstname:(NSString *)firstname theLastname:(NSString *)lastname theEmail:(NSString *)email;

-(void)updateDatabaseAman:(NSString *)password theEmail:(NSString *)email;
-(void)getUserIdByName:(NSString *)name;
//kulpreet
-(void) readDataFromDatabase;
-(NSString *)getUserNameById:(NSString *)id;
@end




