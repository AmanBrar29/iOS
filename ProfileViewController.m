//
//  ProfileViewController.m
//  FinalProject
//
//  Created by xcode on 2015-04-22.
//  Copyright (c) 2015 CBG. All rights reserved.
//

#import "ProfileViewController.h"
#import "SiteCell.h"
#import "Data.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController
#pragma mark Table Methods
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
//Animations for when the table cell view is appearing
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}



#pragma  mark View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //getting permission to access the app delegate
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //reading from the database based on my user id
    [mainDelegate readDataFromDatabase:mainDelegate.userId];

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
