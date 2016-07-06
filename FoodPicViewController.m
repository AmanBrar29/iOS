//
//  FoodPicViewController.m
//  ProjectVictorPages
//
//  Created by xcode on 2015-04-18.
//  Copyright (c) 2015 Victor Cabrera. All rights reserved.
//

#import "FoodPicViewController.h"
#import "AppDelegate.h"
@interface FoodPicViewController ()

@end

@implementation FoodPicViewController
@synthesize foodImageName, foodImageView, testString, receivedImage, usernameDisplay, receivedUsername, followId3;

// event for the button that closes the current view
-(IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
// event for the button that takes you to the page of the user's image that you are viewing
-(IBAction)toFollow:(id)sender
{
    
    [self performSegueWithIdentifier:@"FoodPicToFollower" sender:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.foodImageView.image = [UIImage imageNamed:self.foodImageName];
    
    AppDelegate *mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    mainDelegate.inType = @"world";
    //this bit of code is used to get the path of the image that is stored in the Documents directory then add that image to the imageView based on the path returned.
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *workSpacePath=[documentsDirectory stringByAppendingPathComponent:self.foodImageName];
    foodImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
    
    // these are set from the previous page view controller FoodPicCollectionViewController's in the prepareForSegue method
    self.usernameDisplay.text = self.foodImageName;
    self.lblUserName.text = self.receivedUsername;
    [mainDelegate getUserIdByName:self.receivedUsername];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
