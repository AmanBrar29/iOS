//
//  FollowersViewController.m
//  FinalProject
//
//  Created by xcode on 2015-04-22.
//  Copyright (c) 2015 CBG. All rights reserved.
//

#import "FollowersViewController.h"
#import "SiteCell.h"
#import "Data.h"
@interface FollowersViewController ()

@end

@implementation FollowersViewController
@synthesize mainDelegate, navBar, lblName, btnFollow;
//method to follow a user
-(IBAction)btnFollow:(id)sender
{   //using app delegate method to get user name
    [mainDelegate insertIntoFollower:mainDelegate.userId theFollower:[mainDelegate getUserNameById:mainDelegate.followerId]];
    //alertView to confirm user has been followed
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"The user has been followed :) !" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    //disabling the follow button so that users cannot keep following
    btnFollow.enabled = NO;
    [btnFollow setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
}
//tabel method to set amount of rows for the table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //getting the size of our array of data from the app delegate
    return [mainDelegate.people2 count];
}
//table method to set the height of the table cell
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
//table method to create and style the cells
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    //dequeing a cell if its going to be re styled
    SiteCell *cell = (SiteCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        //if cell has never been created then insantiate and initalize cell
        cell = [[SiteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSInteger row = [indexPath row];
    // setting a Data object from a Data object from our app delegate data array
    Data *data = [mainDelegate.people2 objectAtIndex:row];
    //pulling the data out of the Data object and putting it into strings we can use
    NSString *image = [data image];
    NSString *imageName = [data imageName];
    NSString *comment = [data comment];
    NSString *likes = [data likes];
    //setting the cells primary label to be the imageName
    cell.primaryLabel.text = imageName;
    //setting the a label with the user name that will be displayed on top of the nav bar.
    lblName.text = [mainDelegate getUserNameById:[data uId]];
    NSLog(@"******* %@",[mainDelegate getUserNameById:[data uId]]);
    //cell.secondaryLabel.text = comment;
    //a few methods below that get the directory our apps document directory then append the image name to use it to find images we stored in it, then set them to the given imageview.
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *workSpacePath=[documentsDirectory stringByAppendingPathComponent:image];
    cell.myImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
    //setting the cell acessory
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}
//table method for specifying what will happen if a cell is selected
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //this gets which cell "row" is being selected
    NSInteger row = [indexPath row];
    // setting a Data object from a Data object from our app delegate data array
    Data *person = [mainDelegate.people2 objectAtIndex:row];
    //grabbing and displaying the comment in an alertview when the cell is selected
    NSString *comment = [person comment];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:comment delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    alert.tag = 1;
    [alert show];
    
}


#pragma  mark View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //getting permission to access the app delegate
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //reading from the database based on follower id
    [mainDelegate readDataFromDatabase:mainDelegate.followerId];
    //checking if the user entered this page through the world page or through the followers page
    if([mainDelegate.inType  isEqual: @"world"])
    {
        //if through the world page don't do anything
    }else
    {
        //if through the followers list page then disable the follow button because these users are technically already followed
        btnFollow.enabled = NO;
        [btnFollow setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    //set the variable to keep track of where the user went back to null so they can't go to pages the shouldn't after leaving this page
    mainDelegate.inType=@"";

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
