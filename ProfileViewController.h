//
//  ProfileViewController.h
//  FinalProject
//
//  Created by xcode on 2015-04-22.
//  Copyright (c) 2015 CBG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface ProfileViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    AppDelegate *mainDelegate;
}
@property (nonatomic, strong)AppDelegate *mainDelegate;
@end
