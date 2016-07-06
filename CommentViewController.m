//
//  CommentViewController.m
//  FinalProject
//
//  Created by xcode on 2015-04-23.
//  Copyright (c) 2015 CBG. All rights reserved.
//

#import "CommentViewController.h"
#import "ProfileViewController.h"
#import "Data.h"
@interface CommentViewController ()

@end

@implementation CommentViewController
@synthesize imageView, imageName, takePhotoButton, selectPhotoButton,submitPhotoNameButton,submitPostButton,mainDelegate,txtPhotoName,comment,preImageName;
//method to return keyboard when return clicked.
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
//method to se the photo name
-(IBAction)setPhotoName:(id)sender
{
    //setting the images name by  appending the .png to the input from the textfield
     preImageName = txtPhotoName.text;
    imageName = [preImageName stringByAppendingString:@".png"];
    
    //enabling all the the buttons that were set to disabled in the view did load
    [takePhotoButton setEnabled:YES];
    [takePhotoButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [selectPhotoButton setEnabled:YES];
    [selectPhotoButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [submitPostButton setEnabled:YES];
    [submitPostButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [comment setEditable:YES];
    [comment setBackgroundColor:[UIColor whiteColor]];
    
    //If statement to check if there is a camera on the device or not... if not then diplay a alert letting the user know and disable the takePhotoButton
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //making the alert view
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error: No camera available on the device!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        //setting take photo button to disabled because there is no camera.
        [takePhotoButton setEnabled:NO];
        [takePhotoButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
    }
    
    //setting the txtPhotoToNulll after gettin the name we needed
    [txtPhotoName setEnabled:NO];
    [txtPhotoName setBackgroundColor:[UIColor grayColor]];
}
//method for alertview that will preform a segue to the Profile page if the alert with tag == 1 has its cancle button clicked.
-(void)alertView:(UIAlertView *) alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alert.tag == 1)
    {
        if(buttonIndex == 0)
        {
            [self performSegueWithIdentifier:@"CommentToProfile" sender:self];
        }
        
    }
}
//the method that submits the post and saves it to the database
-(IBAction)submitPost:(id)sender
{
    //first check to see that the imageView or the imageName textfields are not null
    if(imageView.image != nil && ![imageName  isEqual: @""])
    {
        //instantiate a Data object store the new values and then use it to insert the new values into the data
    Data *data = [[Data alloc]initWithData:imageName theImgName:preImageName theComment:comment.text theLikes:@"0" theUserId:mainDelegate.userId];
    [mainDelegate insertIntoDatabaseJoelly:data];
    //AlertView that pops up to let the user know that the recored has added
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Posted :) !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alertView.tag = 1;
    [alertView show];
    }else
    {
            //AlertView letting the user know that they need to fill out all the required fields, because there is a field missing (imageName or imageView.image)
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Submit Filed! Make sure all fields with a * beside them are filled out, and that you have uploaded a picture!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alertView.tag = 2;
    }
    
    
    
}
//method to add to take a photo using the camera
-(IBAction)takePhoto:(id)sender
{
    //instantiating the image picker
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    //telling the image picker to which menu to open; camera or photo gallery.
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //this opens up the new view that comes up with the camera and all
    [self presentViewController:picker animated:YES completion:nil];
}
//method to add to select a photo from the gallary
-(IBAction)selectPhoto:(id)sender
{
    //instantiating the image picker
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    //telling the image picker to which menu to open; camera or photo gallery.
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //this opens up the new view that comes up with the gallary and all
    [self presentViewController:picker animated:YES completion:nil];
}
//method that tells what to do after the photo has been selected or taken
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //getting the image that was chosen from the UIImagePickerControllerEditedImage
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];//the [UIImage..] is like the index for the info dictionary
    //setting the chosen image into the imageView
    imageView.image = chosenImage;
    //gets rid of the view that was brough up for the camera/gallery
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //getting saving path for using the document directory to store the images in
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *imagePath = [documentDirectory stringByAppendingPathComponent:imageName];
    
    //taking image from picker then saving it to the app
    NSString *media = [info objectForKey:UIImagePickerControllerMediaType];
    if([media isEqualToString:@"public.image"])
    {
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData *webData = UIImagePNGRepresentation(editedImage);
        [webData writeToFile:imagePath atomically:YES];
    }
    
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //closing the image picker
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Disabling all the buttons and fields until the image name is submitted
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [takePhotoButton setEnabled:NO];
    [takePhotoButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [selectPhotoButton setEnabled:NO];
    [selectPhotoButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [submitPostButton setEnabled:NO];
    [submitPostButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [comment setEditable:NO];
    [comment setBackgroundColor:[UIColor grayColor]];
    //pop up that informs the user that they need to submit the name before they get the other fields enabled.
    UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"Fill and submit image name before you proceed furthur!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView2 show];
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
