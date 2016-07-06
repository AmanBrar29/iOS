//
//  ViewController.h
//  FinalProject
//
//  Created by xcode on 2015-04-23.
//  Copyright (c) 2015 xcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DataFollow.h"

@interface ViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate>
{
    AppDelegate *mainDelegate;
}

@property(nonatomic, strong) AppDelegate *mainDelegate;


@end

