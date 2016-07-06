//
//  ResetPasswordViewController.h
//  iOS_project
//
//  Created by Amandeep Brar on 2015-04-18.
//  Copyright (c) 2015 Amandeep Brar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPasswordViewController : UIViewController
{
IBOutlet UITextField *password;
IBOutlet UITextField *confirmPassword;
IBOutlet UITextField * email;
    int direction;
    int shakes;
}
@property(strong, nonatomic) IBOutlet UITextField *password;
@property(strong, nonatomic) IBOutlet UITextField *confirmPassword;
@property(strong, nonatomic) IBOutlet UITextField *email;

-(IBAction)PasswordInfo:(id)sender;
-(IBAction)resetPassword:(id)sender;
@end
