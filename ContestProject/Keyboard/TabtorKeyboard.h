//
//  TabtorKeyboard.h
//  Contest Application
//
//  Created by Nikhil Acharya on 2/24/12.
//  Copyright (c) 2015 Prazas, Inc., The. All rights reserved.

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "JSONKit.h"
#import "Keyboard.h"

/* Tabtor Keyboard */
@interface TabtorKeyboard : UIView <UIInputViewAudioFeedback> {
    NSMutableArray *keyboards;
}
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *characterKeys;

@property (strong, nonatomic) IBOutlet UIButton *returnButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet UIButton *dismissButton;

@property (strong) id<UITextInput> textView;

- (IBAction)returnPressed:(id)sender;
- (IBAction)dismissPressed:(id)sender;
- (IBAction)deletePressed:(id)sender;
- (IBAction)characterPressed:(id)sender;

@end
