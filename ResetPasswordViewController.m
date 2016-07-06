//
//  ResetPasswordViewController.m
//  iOS_project
//
//  Created by Amandeep Brar on 2015-04-18.
//  Copyright (c) 2015 Amandeep Brar. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "BackgroundLayer.h"
#import "AppDelegate.h"
@implementation ResetPasswordViewController
@synthesize password, confirmPassword, email;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//implement CA background layer
-(void)viewWillAppear:(BOOL)animated
{
    CAGradientLayer *bgLayer = [BackgroundLayer greyGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
}

//button action to display password requirements
-(IBAction)PasswordInfo:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Password Requirements"
                          message:@"Your password should be 6 to 10character long. It requires to have at least 1 alphanumeric (letter/number) character and 1 non-alphanumeric character."
                          delegate:self
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil];
    
    alert.tag = 1;
    [alert show];
}

//methods to implement shake in UITextfields
-(void)shake:(UIView *)theOneYouWannaShake
{
    [UIView animateWithDuration:0.5 animations:^
     {
         theOneYouWannaShake.transform = CGAffineTransformMakeTranslation(5*direction, 0);
     }
                     completion:^(BOOL finished)
     {
         if(shakes >= 10)
         {
             theOneYouWannaShake.transform = CGAffineTransformIdentity;
             return;
         }
         shakes++;
         direction = direction * -1;
         [self shake:theOneYouWannaShake];
     }];
}

-(IBAction)resetPassword:(id)sender
{
    NSString *passwordString = password.text;
    //call password check method
    BOOL pwdCheck =[self isPasswordValid:passwordString];
    //validates password
    if (pwdCheck == NO){
        //implements shake
        direction = 2;
        shakes = 10;
        [self shake:password];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Invalid Password !!"
                              message:@"Password requirements are not met."
                              delegate:self
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil];
        
        alert.tag = 1;
     //   [alert show];
    }
    
    //check if password feilds are not left empty
    else if(password.text.length == 0 || confirmPassword.text.length ==0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"*****"
                              message:@"Password feilds cann't be empty"
                              delegate:self
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil];
        
        alert.tag = 1;
        [alert show];
    }
    //valiadtes if password matches with confirm password entered
    else if(![password.text isEqualToString:confirmPassword.text]){
        direction = 2;
        shakes = 10;
        [self shake:password];  [self shake:confirmPassword];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"*****"
                              message:@"Passwords don't match"
                              delegate:self
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil];
        
        alert.tag = 1;
        [alert show];
    }
    else
    { //add user to database if all valiadtes are passed
        AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        //use insert method declared in AppDelegates file
        [mainDelegate updateDatabaseAman:password.text theEmail:email.text];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Password Update"
                              message:@"Password reset successful !"
                              delegate:self
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil];
        
        alert.tag = 1;
        [alert show];
        
    }
    
    
    
}
//method to check password min. requiremeents
-(BOOL) isPasswordValid:(NSString *)pwd {
    if ( [password.text length]<6 || [pwd length]>10 ) return NO;  // too long or too short
    NSRange rang;
    rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
    if ( !rang.length ) return NO;  // no letter
    rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
    if ( !rang.length )  return NO;  // no number;
    return YES;
}


@end
