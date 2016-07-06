//
//  CommentViewController.h
//  FinalProject
//
//  Created by xcode on 2015-04-23.
//  Copyright (c) 2015 CBG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface CommentViewController : UIViewController<UIImagePickerControllerDelegate,
                                    UINavigationControllerDelegate,UITextFieldDelegate, UITextViewDelegate,UIAlertViewDelegate>
{
    IBOutlet UIImageView *imageView;
    NSString *imageName;
    IBOutlet UIButton *takePhotoButton;
    IBOutlet UIButton *selectPhotoButton;
    IBOutlet UIButton *submitPhotoNameButton;
    IBOutlet UIButton *submitPostButton;
    IBOutlet UITextField *txtPhotoName;
    IBOutlet UITextView *comment;
    AppDelegate *mainDelegate;
    NSString *preImageName;
    
}
@property(nonatomic, strong)IBOutlet UIImageView *imageView;
@property(nonatomic, strong)IBOutlet NSString *imageName;
@property(nonatomic, strong)IBOutlet UIButton *takePhotoButton;
@property(nonatomic, strong)IBOutlet UIButton *selectPhotoButton;
@property(nonatomic, strong)IBOutlet UIButton *submitPhotoNameButton;
@property(nonatomic, strong)IBOutlet UIButton *submitPostButton;
@property(nonatomic, strong)IBOutlet UITextField *txtPhotoName;
@property(nonatomic, strong)IBOutlet UITextView *comment;
@property(nonatomic, strong)AppDelegate *mainDelegate;
@property(nonatomic, strong)NSString *preImageName;
-(IBAction)takePhoto:(id)sender;
-(IBAction)selectPhoto:(id)sender;
-(IBAction)setPhotoName:(id)sender;
-(IBAction)submitPost:(id)sender;

@end
