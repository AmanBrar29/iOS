//
//  FoodPicCollectionViewController.h
//  ProjectVictorPages
//
//  Created by xcode on 2015-04-18.
//  Copyright (c) 2015 Victor Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"



@interface FoodPicCollectionViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

{
    AppDelegate *mainDelegate;
    NSMutableArray *foodPicsArray;
    NSInteger selectedPhotoIndex;
    UIImage *imageToSend;
    NSString *imageToSendName;
    NSArray *indexPaths2;
    NSMutableArray *usernamesArray;

}

@property(nonatomic, retain)IBOutlet UICollectionView *myCollectionView;

@property(nonatomic, strong) AppDelegate *mainDelegate;

@property(nonatomic, strong)NSMutableArray *foodPicsArray;
@property(nonatomic, strong)NSMutableArray *usernamesArray;
@property(nonatomic, assign)NSInteger selectedPhotoIndex;
@property(nonatomic, strong)UIImage *imageToSend;
@property(nonatomic, strong)NSString *imageToSendName;
@property(nonatomic, strong)NSArray *indexPaths2;



@end
