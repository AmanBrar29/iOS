//
//  ViewController.h
//  iOS_project
//
//  Created by Amandeep Brar on 2015-04-18.
//  Copyright (c) 2015 Amandeep Brar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface LoginViewController : UIViewController
{
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    NSString *databaseName;
    NSString *databasePath;
    
}


@property(nonatomic, strong) IBOutlet UITextField *username;
@property(nonatomic, strong) IBOutlet UITextField *password;
@property(nonatomic, strong) NSString *databaseName;
@property(nonatomic, strong) NSString *databasePath;

-(IBAction)btnlogin:(id)sender;
@end

