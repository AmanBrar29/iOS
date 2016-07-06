//
//  ViewController.m
//  FinalProject
//
//  Created by xcode on 2015-04-23.
//  Copyright (c) 2015 xcode. All rights reserved.
//

#import "ViewController.h"
#import "DataFollow.h"
#import "Site.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize mainDelegate;

#pragma mark Table Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [mainDelegate.people count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    
    Site *cell = (Site *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[Site alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSInteger row = [indexPath row];
    DataFollow *data = [mainDelegate.people objectAtIndex:row];
    
    cell.primaryLabel.text = [data name];
    
  //  NSLog(@"Label working %@", [data name]);
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    
    DataFollow *person = [mainDelegate.people objectAtIndex:row];
    
    [mainDelegate getUserIdByName:[person name]];
    
    [self performSegueWithIdentifier:@"FollowerListToFollower" sender:self];
    
    
    
}


#pragma  mark View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [mainDelegate readDataFromDatabase];
    //mainDelegate.inType = @"followerlist";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
