//
//  RegisterViewController.m
//  iOS_project
//
//  Created by Amandeep Brar on 2015-04-18.
//  Copyright (c) 2015 Amandeep Brar. All rights reserved.
//shake animation : http://stackoverflow.com/questions/10294451/animating-uitextfield-to-indicate-a-wrong-password
//

#import "RegisterViewController.h"
#import "BackgroundLayer.h"
#import "AppDelegate.h"

@implementation RegisterViewController
@synthesize username, password, firstName, lastname, email, confirmEmail;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    CAGradientLayer *bgLayer = [BackgroundLayer greyGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:bgLayer atIndex:0];
    
}
//button action to display the password requirements
-(IBAction)PasswordInfo:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Password Requirements"
                          message:@"Your password should be 4 to 8 character long. It requires to have at least 1 alphanumeric (letter/number) character and 1 non-alphanumeric character."
                          delegate:self
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil];
    
    alert.tag = 1;
    [alert show];
}
//button action to declare all textfield if user press cancel button
-(IBAction)cancel:(id)sender{
    
    username.text = @"";
    password.text = @"";
    firstName.text = @"";
    lastname.text = @"";
    email.text = @"";
    confirmEmail.text = @"";
    
}

//void method to implement shake
-(void)shake:(UIView *)theOneYouWannaShake
{
    //define animation duration
    [UIView animateWithDuration:0.5 animations:^
     {
         //define transform property to set up direction and number of shakes
         theOneYouWannaShake.transform = CGAffineTransformMakeTranslation(5*direction, 0);
     }
                     completion:^(BOOL finished)
     {
         //customize shake is user want to have more than 10 shakes
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
-(IBAction)addPerson:(id)sender
{
    
    
    NSString *emailString = email.text;
    NSString *confirmEmailString = confirmEmail.text;
    //validate email format
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    NSString *passwordString = password.text;
    //declare password requirement check method
    BOOL pwdCheck =[self isPasswordValid:passwordString];
    //validates if feilds are not empty
    if(username.text.length == 0 || password.text.length == 0 || firstName.text.length == 0 || lastname.text.length == 0 || email.text.length == 0 ||confirmEmail.text.length == 0 ){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"*****"
                              message:@"Feilds cannot be empty"
                              delegate:self
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil];
        
        alert.tag = 1;
        [alert show];
    }
    //validates if user enter valid emial in both feilds for email as well as confirm email
    else if (([emailTest evaluateWithObject:email.text] == NO) ||([emailTest evaluateWithObject:confirmEmail.text] == NO)){
        direction = 2;
        shakes = 10;
        [self shake:confirmEmail];
        [self shake:email];
        
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Test!" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
      //  [alert show];
        confirmEmail.text = @""; email.text = @"";
        return;
        
    }
    //valiadtes if user enter same email in both email feilds
    else if(![emailString isEqualToString:confirmEmailString]){
        direction = 2;
        shakes = 10;
        [self shake:confirmEmail];
        confirmEmail.text = @"";
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"*****"
                              message:@"Emails don't match"
                              delegate:self
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil];
        
        alert.tag = 1;
      //  [alert show];
    }
    
    //valiadtes if minimium password requirments are met
    else if (pwdCheck == NO){
        direction = 2;
        shakes = 10;
        [self shake:password];

        password.text = @"";
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Invalid Password !!"
                              message:@"Password requirements are not met."
                              delegate:self
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil];
        
        alert.tag = 1;
     //   [alert show];
        
        
    }
    else{
        //add user to database if all valid information is entered
        AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        //use insert method declared in App Delegates file
          [mainDelegate insertIntoDatabase: username.text thePassword:password.text theFirstname:firstName.text theLastname:lastname.text theEmail:email.text];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Successful registerations"
                              message:@"Your accoount is added, proceed after login !!"
                              delegate:self
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil];
        
        alert.tag = 1;
        [alert show];
        
    }


}

//method to check password requirements and return boolean values 
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
