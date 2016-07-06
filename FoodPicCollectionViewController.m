//
//  FoodPicCollectionViewController.m
//  ProjectVictorPages
//
//  Created by xcode on 2015-04-18.
//  Copyright (c) 2015 Victor Cabrera. All rights reserved.
//

#import "FoodPicCollectionViewController.h"
#import "ImageData.h"
#import "FoodPicViewController.h"


@interface FoodPicCollectionViewController ()

@end

@implementation FoodPicCollectionViewController
@synthesize mainDelegate, foodPicsArray, selectedPhotoIndex, imageToSendName, imageToSend, indexPaths2, usernamesArray;




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Instantiate main delegate to be ablt to use method to read from database for the world page
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainDelegate readDataFromDatabaseWorldPage];
    //NSLog(@"Follower id on load: %@", [mainDelegate.followerIdArray objectAtIndex:0]);
    
    // Must set the collection view delegate and data source to the current viewController
    // that way you can use the collectionView's methods
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    
    // Intantiate the array that will hold image names like "burger.jpg""
    foodPicsArray = [[NSMutableArray alloc] init];
    // Instantiate the array that will hold the usernames
    usernamesArray = [[NSMutableArray alloc] init];
    
    // Keep a counter variable to only show the first 10 images
       NSInteger j = mainDelegate.arrayImageNames.count - 1;
    
    // Iterate through mainDelegate arrayImageNames which contains the ImageData objects which
    // which contains the database data that was obtained at launch
    for (int i = 0; i < 12; i++)
    {
        // Instantiate  an ImageData and set it whichever object is at the current index of the mainDelegate arrayImageNames
        ImageData *imageData = (ImageData *)[mainDelegate.arrayImageNames objectAtIndex:j];
        
        // Retrieve the imageName saved in the imageData object and set to a local variable
        NSString *stringImageName = imageData.imageName;
        // Retrieve the imageUsername saved in the imageData object and set to a local variable
        NSString *stringImageUser = imageData.imageUsername;
      //  NSLog(@"First image is: %@", stringImageName);
        
        // Store the image names in the foodPicsArray
        [foodPicsArray addObject:stringImageName];
        // Store the usernames of those images in the userNamesArray
        [usernamesArray addObject:stringImageUser];
        j--;
        
    }
    
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

#pragma mark collection view methods

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{
    // number of items in the collection view would be the size of the foodPicsArray
    return [foodPicsArray count];
}


-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // specificy the collection view cell name you are referencing
    static NSString *indentifier = @"Cell";
    
    // Instantiate a cell object which would be the cell identified as "Cell" which was set in storyboard
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
   
    // Set the this viewController's foodImageView to the cell containing tag 100
    UIImageView *foodImageView = (UIImageView *)[cell viewWithTag:100];
    
    // Some additional cell formatting
    [cell.layer setBorderWidth:2.0f];
    [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *workSpacePath=[documentsDirectory stringByAppendingPathComponent:[foodPicsArray objectAtIndex:indexPath.row]];
    
    // Now set the foodImageView's actual image with image located at so and so directory...
    foodImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
    /*foodImageView.image = [UIImage imageNamed:[foodPicsArray objectAtIndex:indexPath.row]];*/
        
    //[cell.layer setCornerRadius:50.0f];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    selectedPhotoIndex = indexPath.row;
    
}

// method to perform some actions before switching pages.  This is where value are passed to the next page.
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // perform the following if the segue being used is called "showFoodPicUser"
    if ([segue.identifier isEqualToString:@"showFoodPicUser"])
    {
    
        NSArray *indexPaths = [self.myCollectionView indexPathsForSelectedItems];
        
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
    
        // Set the the destination's viewContollers foodImageProperty
        [segue.destinationViewController setFoodImageName:[foodPicsArray objectAtIndex:indexPath.row]];
        
        // Set the the destination's viewContollers receivedUserName property
        [segue.destinationViewController setReceivedUsername:[usernamesArray objectAtIndex:indexPath.row]];
        
        // Set the the destination's viewContollers setFollowId3 property
        [segue.destinationViewController setFollowId3:[mainDelegate.followerIdArray objectAtIndex:indexPath.row]];
        
         NSLog(@"Followwer id is: %@", [mainDelegate.followerIdArray objectAtIndex:indexPath.row]);
        [self.myCollectionView deselectItemAtIndexPath:indexPath animated:NO];
        
           
    }
    
}






@end
