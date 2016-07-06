//
//  ViewController.m
//  iOS_project
//
//  Created by Amandeep Brar on 2015-04-18.
//  Copyright (c) 2015 Amandeep Brar. All rights reserved.
//

#import "LoginViewController.h"
#import "BackgroundLayer.h"
#import "AppDelegate.h"
#import <sqlite3.h>
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize username, password;
@synthesize databasePath,databaseName;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.databaseName = @"ProjectDatabaseFinal.sql";
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    self.databasePath = [documentsDir stringByAppendingPathComponent:self.databaseName];
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//use the CAgraident layer method for blue gradeint to customize the background
-(void)viewWillAppear:(BOOL)animated
{
    CAGradientLayer *bgLayer = [BackgroundLayer blueGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];

  
}
//method the unwind other view back to main page (login page) for bar button item click
-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)sender
{
    
}


-(IBAction)btnlogin:(id)sender
{
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //validates if fields are left empty and display result
    if(username.text.length == 0 || password.text.length == 0 ){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"*****"
                              message:@"Feilds cannot be empty"
                              delegate:self
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil];
        
        alert.tag = 1;
        [alert show];
    }
    //after validation check, use values stored in database for username and password to check if user has enter valid userid and password
    else
    {
        NSString *infoUserPassword ;
        sqlite3 *dbTest;
        if (sqlite3_open([databasePath UTF8String],  &dbTest) == SQLITE_OK)
        {
           /* NSString *querySQL1 = [NSString stringWithFormat:@"SELECT password FROM users Where username = \"%@\"",[username text]];*/
            NSString *querySQL1 = @"SELECT ID,password FROM users Where username='";
            NSString *querySQL2 = [querySQL1 stringByAppendingString: [username text]];
            NSString *querySQL = [querySQL2 stringByAppendingString:@"';"];
            
            NSLog(@"%@",querySQL);
            
            const char *sql = [querySQL UTF8String];
            sqlite3_stmt *searchStatement;
            if (sqlite3_prepare_v2(dbTest, sql, -1, &searchStatement, NULL) == SQLITE_OK)
            {  NSLog(@"inside sqlite prepare");
                while(sqlite3_step(searchStatement) == SQLITE_ROW)
                {
                   // NSString *infoUserName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(searchStatement, 1)];
                     mainDelegate.userId = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(searchStatement, 0)];
                    infoUserPassword = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(searchStatement, 1)];
                }
                
            }
            if(sqlite3_step(searchStatement) != SQLITE_DONE ) {
                NSLog( @"Error: %s", sqlite3_errmsg(dbTest) );
            }
            sqlite3_finalize(searchStatement);
        }
        sqlite3_close(dbTest); UIAlertView *alert;
        NSString*  passwordtext;
        passwordtext = password.text;
        //display approraite alert on valid or invalid login 
        if([passwordtext isEqualToString: infoUserPassword]){
            NSLog(@"passsowrd alert");
             alert= [[UIAlertView alloc]
                                  initWithTitle:@" :) "
                                  message:@"Login Successful"
                                  delegate:self
                                  cancelButtonTitle:@"Ok"
                                  otherButtonTitles:nil];
            
            alert.tag = 1;
          //  [alert show];
            [self performSegueWithIdentifier:@"LoginToProfile" sender:self];
        }
        else {

            alert= [[UIAlertView alloc]
                    initWithTitle:@" :) "
                    message:@"Invalid login"
                    delegate:self
                    cancelButtonTitle:@"Ok"
                    otherButtonTitles:nil];
            
            alert.tag = 1;
            [alert show];
            
        }
        
    }
}
@end
//animation done using below reference
/*
 * https://danielbeard.wordpress.com/2012/02/25/gradient-background-for-uiview-in-ios/
 */