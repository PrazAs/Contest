//
//  FrontViewController.m
//  Contest Application
//
//  Created by Nikhil Acharya on 2/24/12.
//  Copyright (c) 2015 Prazas, Inc., The. All rights reserved.

#import "FrontViewController.h"
#import "SWRevealViewController.h"

/* Front View Controller */
@interface FrontViewController()
    - (IBAction)pushExample:(id)sender;
@end

/* Front View Controller */
@implementation FrontViewController

#pragma mark - View lifecycle

/* View Load Completed */
- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.title = NSLocalizedString(@"Tabtor", nil);
    SWRevealViewController *revealController = [self revealViewController];

    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
        style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    UIBarButtonItem *rightRevealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
        style:UIBarButtonItemStyleBordered target:revealController action:@selector(rightRevealToggle:)];
    self.navigationItem.rightBarButtonItem = rightRevealButtonItem;
    
    
    // Set Tabtor Keyboard
    TabtorKeyboard *customKeyboard = [[TabtorKeyboard alloc] init];
    [customKeyboard setTextView:self.answerInput];
}

#pragma mark - Example Code

/* Push View */
- (IBAction)pushExample:(id)sender
{
	UIViewController *stubController = [[UIViewController alloc] init];
	stubController.view.backgroundColor = [UIColor whiteColor];
	[self.navigationController pushViewController:stubController animated:YES];
}

/* View will Appear */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog( @"%@: FRONT", NSStringFromSelector(_cmd));
}

/* View will Disappear */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog( @"%@: FRONT", NSStringFromSelector(_cmd));
}

/* View did Appear */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog( @"%@: FRONT", NSStringFromSelector(_cmd));
}

/* View did Disappear */
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog( @"%@: FRONT", NSStringFromSelector(_cmd));
}

@end