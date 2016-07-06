//
//  AppDelegate.m
//  FinalProject
//
//  Created by xcode on 2015-04-22.
//  Copyright (c) 2015 CBG. All rights reserved.
//

#import "AppDelegate.h"
#import "DataFollow.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize databaseName, databasePath, people, Amandata, userId, arrayImageNames, followerId, followerIdArray, people2, inType;

#pragma mark Database Methods

-(void)insertIntoFollower:(NSString *)uId theFollower:(NSString *)follow
{
    // Setup the database object
    sqlite3 *database;
    
    
    // Open the database from the users filessytem
    if(sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK)
    {
        const char *sqlStatement = "insert into followers values(NULL, ?, ?)";
        sqlite3_stmt *compiledStatement;
        
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            sqlite3_bind_text(compiledStatement, 1, [uId UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(compiledStatement, 2, [follow UTF8String], -1, SQLITE_TRANSIENT);
            
        }
        if(sqlite3_step(compiledStatement) != SQLITE_DONE)
        {
            NSLog(@"Error: %s", sqlite3_errmsg(database));
        }
        else
        {
            NSLog(@"Insert into row id = %lld", sqlite3_last_insert_rowid(database));
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}
// Victor
-(void) readDataFromDatabaseWorldPage {
    
    NSLog(@"This is a test");
    // clear array
    [self.arrayImageNames removeAllObjects];
    NSLog(@"This is a test2");
    //[self.arrayImageUsernames removeAllObjects];
    
    // Setup the database object
    sqlite3 *database;
    NSLog(@"This is a test3");
    self.followerIdArray = [[NSMutableArray alloc] init];
    // Open the database from the users filessytem
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        // Setup the SQL Statement and compile it for faster access
        NSString *sqlStatement1 = [NSString stringWithFormat:@"select image, username, userid from users, posts where posts.userid=users.id AND posts.userid != \"@%\";", self.userId];
        const char *sqlStatement = [sqlStatement1 UTF8String];
        NSLog(@"This is a test4");
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            NSLog(@"This is a test5");
            // Loop through the results and add them to the feeds array.
            // sqlite3_step function executes the query
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                // Read the data from the result row
                
                // image name is fetched and saved here from database
                NSString *imageName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                 // username is fetched and saved here from database
                NSString *imageUsername = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                // userid is fetched and saved here from database
                [self.followerIdArray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)]];
                
                // set the data just retrieved to properties of the ImageData object instantiated below
                ImageData *imageData = [[ImageData alloc] initWithData:imageName theImageUsername:imageUsername];
                
                // store the object in the AppDelegate's array called arrayImageNames
                [self.arrayImageNames addObject:imageData];
                
                
            }
        }
        // Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
        
    }
    sqlite3_close(database);
    
    // NSLog(@"This is a test");
    
}


-(void)insertIntoDatabaseJoelly:(Data *)person
{
    // Setup the database object
    sqlite3 *database;
    
    
    // Open the database from the users filessytem
    if(sqlite3_open([self.databasePath UTF8String], &database) == SQLITE_OK)
    {
        //setting up the skeleton for the insert into statement
        const char *sqlStatement = "insert into posts values(NULL, ?, ?, ?, ?, ?)";
        sqlite3_stmt *compiledStatement;
        
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            //replacing the "?" placeholders in the query we had above with the proper values
            sqlite3_bind_text(compiledStatement, 1, [person.image UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(compiledStatement, 2, [person.imageName UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(compiledStatement, 3, [person.comment UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(compiledStatement, 4, [person.likes UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(compiledStatement, 5, [person.uId UTF8String], -1, SQLITE_TRANSIENT);

        }
        //Checking if there was an error when compiling the query if so log so lines
        if(sqlite3_step(compiledStatement) != SQLITE_DONE)
        {
            NSLog(@"Error: %s", sqlite3_errmsg(database));
        }
        else
        {
            NSLog(@"Insert into row id = %lld", sqlite3_last_insert_rowid(database));
        }
        //query ran and db closed
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}

-(void) checkAndCreateDatabase{
    // Check if the SQL database has already been saved to the users phone, if not then copy it over
    BOOL success;
    
    // Create a FileManager object, we will use this to check the status
    // of the database and to copy it over if required
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Check if the database has already been created in the users filesystem
    success = [fileManager fileExistsAtPath:databasePath];
    
    // If the database already exists then return without doing anything
    if(success) return;
    
    // If not then proceed to copy the database from the application to the users filesystem
    
    // Get the path to the database in the application package
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    
    // Copy the database from the package to the users filesystem
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    
    //[fileManager release];
}

-(void) readDataFromDatabase:(NSString *)id {
    
    // clear array
    [self.people2 removeAllObjects];
    // Setup the database object
    sqlite3 *database;
    
    // Open the database from the users filessytem
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        // Setup the SQL Statement and compile it for faster access
        NSString *sqlStatement1 = [NSString stringWithFormat:@"select * from posts where userId = \"%@\"", id];
        const char *sqlStatement = [sqlStatement1 UTF8String];
        //deals with the query etc
        sqlite3_stmt *compiledStatement;
        //prepare instatiates memory for the query
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                // Read the data from the result row
                NSString *image = [NSString stringWithUTF8String:(char *) sqlite3_column_text(compiledStatement, 1)];
                NSString *imageName = [NSString stringWithUTF8String:(char *) sqlite3_column_text(compiledStatement, 2)];
                NSString *comment = [NSString stringWithUTF8String:(char *) sqlite3_column_text(compiledStatement, 3)];
                NSString *likes = [NSString stringWithUTF8String:(char *) sqlite3_column_text(compiledStatement, 4)];
                NSString *uId = [NSString stringWithUTF8String:(char *) sqlite3_column_text(compiledStatement, 5)];
                                //This is us instatiating our DATA class with the overloaded constructor so we can populate the our vaiables in our DATA class
                Data *data = [[Data alloc] initWithData:image theImgName:imageName theComment:comment theLikes:likes theUserId:uId];
                [self.people2 addObject:data];
                
            }
        }
        // Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
        
    }
    sqlite3_close(database);
    
}

-(void) readDataFromDatabase_Aman:(NSString *)login {
     // clear array
    [self.Amandata removeAllObjects];
    //set the database object
    sqlite3 *database;
    //open the database from users filesystem
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        //Setup the SQL statement and complile it for faster access
        NSString *StrSqlStatement = [NSString stringWithFormat: @"select password from users  WHERE id = \"%@\"" , login];
        const char *sqlStatement  = [StrSqlStatement UTF8String];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            //loop through the results and add them to feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
               //read the data from the result row
                NSString *password = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
                //    ProjectData *userdata = [[ProjectData alloc] initWithPassword:password];
                //     [self.data addObject:userdata];
            }
        }
        // Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
        
    }
    sqlite3_close(database);
    
}


#pragma mark Application Methods
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.people2 = [[NSMutableArray alloc] init];
    self.people = [[NSMutableArray alloc] init];
    self.databaseName = @"ProjectDatabaseFinal.sql";
    self.Amandata = [[NSMutableArray alloc]init];
    
    //Victor
    self.arrayImageNames = [[NSMutableArray alloc] init];
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    self.databasePath = [documentsDir stringByAppendingPathComponent:self.databaseName];
    
    [self checkAndCreateDatabase];
    [self readDataFromDatabase:userId];
    // Victor
    [self readDataFromDatabaseWorldPage];
    
    [self readDataFromDatabase];
    
    return YES;
}


-(void)insertIntoDatabase:(NSString *)username thePassword:(NSString *)password theFirstname:(NSString *)firstname theLastname:(NSString *)lastname theEmail:(NSString *)email{
   //setup the database from filesystem 
    sqlite3 *database;
    
    // Open the database from the users filessytem
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        const char *sqlStatement = "insert into users values (NULL, ?, ?, ?, ?,?)";
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)    {
            sqlite3_bind_text( compiledStatement, 4, [username UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text( compiledStatement, 5, [password UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text( compiledStatement, 1, [firstname UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text( compiledStatement, 2, [lastname UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text( compiledStatement, 3, [email UTF8String], -1, SQLITE_TRANSIENT);
        }
        if(sqlite3_step(compiledStatement) != SQLITE_DONE ) {
            NSLog( @"Error: %s", sqlite3_errmsg(database) );
        } else {
            NSLog( @"Insert into row id = ");
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    
}

-(void)updateDatabaseAman:(NSString *)password theEmail:(NSString *)email{
    sqlite3 *database;
    
    // Open the database from the users filessytem
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        //  const char *sqlStatement = "insert into users values (NULL, ?, ?, ?, ?,?)";
        NSString *insertSQL = [NSString stringWithFormat:
                               @"UPDATE users SET password = \"%@\" WHERE email = \"%@\"" ,
                               password, email];
        const char *sqlStatement  = [insertSQL UTF8String];
        sqlite3_stmt *compiledStatement;
        sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL);
        if(sqlite3_step(compiledStatement) == SQLITE_DONE ) {
            NSLog( @"Row updated");
        } else {
            NSLog( @"Error: %s", sqlite3_errmsg(database) );
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    
}
-(void) readDataFromDatabase {
    
    [self.people removeAllObjects];
    sqlite3 *database;
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        NSString *sqlStatement1 = [NSString stringWithFormat:@"select Followername from followers where userId='\%@\'", self.userId];
        const char *sqlStatement = [sqlStatement1 UTF8String];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                NSString *name = [NSString stringWithUTF8String:(char *)
                                  sqlite3_column_text(compiledStatement, 0)];
                NSLog(@"Test for database %@",  name);
                DataFollow *data = [[DataFollow alloc] initWithData:name];
                [self.people addObject:data];
            }
        }
        
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}

//Database method containg a query to get the UserId using the UserName
//not commenting this code as i commented previouse sql methods.. this would just be repetative
-(void)getUserIdByName:(NSString *)name
{
    
    sqlite3 *database;
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        NSString *sqlStatement1 = [NSString stringWithFormat:@"select ID from users where username = \"%@\"", name];
        const char *sqlStatement = [sqlStatement1 UTF8String];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                NSString *id = [NSString stringWithUTF8String:(char *)
                                sqlite3_column_text(compiledStatement, 0)];
                NSLog(@"Test for database %@",  name);
                self.followerId = id;
                
            }
        }
        
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}
//Database method containg a query to get the UserId using the UserName
//not commenting this code as i commented previouse sql methods.. this would just be repetative
-(NSString *)getUserNameById:(NSString *)id
{
    NSString *name;
    sqlite3 *database;
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        NSString *sqlStatement1 = [NSString stringWithFormat:@"select username from users where id = \"%@\"", id];
        const char *sqlStatement = [sqlStatement1 UTF8String];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                name = [NSString stringWithUTF8String:(char *)
                                sqlite3_column_text(compiledStatement, 0)];
                NSLog(@"Test for database %@",  id);
                
                
            }
        }
        
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    return name;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
