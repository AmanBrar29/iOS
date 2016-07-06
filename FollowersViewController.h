//
//  FollowersViewController.h
//  FinalProject
//
//  Created by xcode on 2015-04-22.
//  Copyright (c) 2015 CBG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface FollowersViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    AppDelegate *mainDelegate;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UILabel *lblName;
    IBOutlet UIButton *btnFollow;

}
@property(nonatomic,strong)AppDelegate *mainDelegate;
@property(nonatomic,strong)IBOutlet UINavigationBar *navBar;
@property(nonatomic,strong)IBOutlet UILabel *lblName;
@property(nonatomic,strong)IBOutlet UIButton *btnFollow;
@end
