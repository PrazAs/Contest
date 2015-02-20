//
//  RearViewController.m
//  Contest Application
//
//  Created by Nikhil Acharya on 2/24/12.
//  Copyright (c) 2015 Prazas, Inc., The. All rights reserved.


#import "RearViewController.h"

#import "SWRevealViewController.h"
#import "FrontViewController.h"
#import "MapViewController.h"

@interface RearViewController()
{
    NSInteger _presentedRow;
}

@end

@implementation RearViewController

@synthesize rearTableView = _rearTableView;


#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = NSLocalizedString(@"Rear View", nil);
}


#pragma marl - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;

    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
	
    NSString *text = nil;
    if (row == 0)
    {
        text = @"Front View Controller";
    }
    else if (row == 1)
    {
        text = @"Map View Controller";
    }
    else if (row == 2)
    {
        text = @"Enter Presentation Mode";
    }
    else if (row == 3)
    {
        text = @"Resign Presentation Mode";
    }

    cell.textLabel.text = NSLocalizedString( text,nil );
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    SWRevealViewController *revealController = self.revealViewController;
    
    // selecting row
    NSInteger row = indexPath.row;
    
    // if we are trying to push the same row or perform an operation that does not imply frontViewController replacement
    // we'll just set position and return
    
    if ( row == _presentedRow )
    {
        [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        return;
    }
    else if (row == 2)
    {
        [revealController setFrontViewPosition:FrontViewPositionRightMost animated:YES];
        return;
    }
    else if (row == 3)
    {
        [revealController setFrontViewPosition:FrontViewPositionRight animated:YES];
        return;
    }

    // otherwise we'll create a new frontViewController and push it with animation

    UIViewController *newFrontController = nil;

    if (row == 0)
    {
        newFrontController = [[FrontViewController alloc] init];
    }
    
    else if (row == 1)
    {
        newFrontController = [[MapViewController alloc] init];
    }

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
    [revealController pushFrontViewController:navigationController animated:YES];
    
    _presentedRow = row;  // <- store the presented row
}

@end