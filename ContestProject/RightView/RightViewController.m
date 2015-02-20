//
//  RightViewController.m
//  Contest Application
//
//  Created by Nikhil Acharya on 2/24/12.
//  Copyright (c) 2015 Prazas, Inc., The. All rights reserved.

#import "RightViewController.h"
#import "MapViewController.h"
#import "SWRevealViewController.h"

@interface RightViewController ()
- (IBAction)replaceMe:(id)sender;
- (IBAction)replaceMeCustom:(id)sender;
- (IBAction)toggleFront:(id)sender;
@end

@implementation RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set a random -not too dark- background color.
    CGFloat r = 0.001f*(250+arc4random_uniform(750));
    CGFloat g = 0.001f*(250+arc4random_uniform(750));
    CGFloat b = 0.001f*(250+arc4random_uniform(750));
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
    self.view.backgroundColor = color;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#define TestStatusBarStyle 0   // <-- set this to 1 to test status bar style
#if TestStatusBarStyle
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#endif

#define TestStatusBarHidden 0  // <-- set this to 1 to test status bar hidden
#if TestStatusBarHidden
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
#endif

/* Replace Me */
- (IBAction)replaceMe:(id)sender
{
    RightViewController *replacement = [[RightViewController alloc] init];
    [self.revealViewController setRightViewController:replacement animated:YES];
}

/* Replace Me */
- (IBAction)replaceMeCustom:(id)sender
{
    RightViewController *replacement = [[RightViewController alloc] init];
    replacement.wantsCustomAnimation = YES;
    [self.revealViewController setRightViewController:replacement animated:YES];
}

/* Toggle Front */
- (IBAction)toggleFront:(id)sender
{
    MapViewController *mapViewController = [[MapViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mapViewController];
    
    [self.revealViewController pushFrontViewController:navigationController animated:YES];
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
