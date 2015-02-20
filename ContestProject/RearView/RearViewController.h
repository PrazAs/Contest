//
//  RearViewController.h
//  Contest Application
//
//  Created by Nikhil Acharya on 2/24/12.
//  Copyright (c) 2015 Prazas, Inc., The. All rights reserved.


#import <UIKit/UIKit.h>

@interface RearViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UITableView *rearTableView;


@end