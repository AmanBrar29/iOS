//
//  RegisterViewController.h
//  iOS_project
//
//  Created by Amandeep Brar on 2015-04-18.
//  Copyright (c) 2015 Amandeep Brar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
{
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UITextField *firstName;
    IBOutlet UITextField *lastname;
    IBOutlet UITextField *email;
    IBOutlet UITextField *confirmEmail;
    //int varaible to define the direction and number of shakes for UITextfield animation
    int direction;
    int shakes;
}

@property(nonatomic,strong) IBOutlet UITextField *username;
@property(nonatomic,strong) IBOutlet UITextField *password;
@property(nonatomic,strong) IBOutlet UITextField *firstName;
@property(nonatomic,strong) IBOutlet UITextField *lastname;
@property(nonatomic,strong) IBOutlet UITextField *email;
@property(nonatomic, strong)  IBOutlet UITextField *confirmEmail;

-(IBAction)PasswordInfo:(id)sender;
-(IBAction)cancel:(id)sender;
@end
