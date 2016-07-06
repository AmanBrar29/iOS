//
//  FoodPicViewController.h
//  ProjectVictorPages
//
//  Created by xcode on 2015-04-18.
//  Copyright (c) 2015 Victor Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodPicViewController : UIViewController

{
    IBOutlet UIImageView *foodImageView;
    NSString *foodImageName;
    IBOutlet UILabel *usernameDisplay;
    IBOutlet UIImage *receivedImage;
    NSString *receivedUsername;
    NSString *followId3;
    IBOutlet UILabel *lblUserName;
}

@property (strong, nonatomic) IBOutlet UIImageView *foodImageView;
@property (strong, nonatomic) NSString *foodImageName;
@property (strong, nonatomic) NSString *testString;
@property (strong, nonatomic) IBOutlet UILabel *usernameDisplay;
@property (strong, nonatomic) IBOutlet UIImage *receivedImage;
@property (strong, nonatomic) NSString *receivedUsername;
@property (strong, nonatomic) NSString *followId3;
@property (strong, nonatomic) IBOutlet UILabel *lblUserName;
-(IBAction)close:(id)sender ;

@end
