//
//  TabtorKeyboard.m
//  Contest Application
//
//  Created by Nikhil Acharya on 2/24/12.
//  Copyright (c) 2015 Prazas, Inc., The. All rights reserved.

#import "TabtorKeyboard.h"

/* Tabtor Keyboard */
@interface TabtorKeyboard ()

@property (nonatomic, assign, getter=isShifted) BOOL shifted;

@end

/* Tabtor Keyboard */
@implementation TabtorKeyboard
@synthesize textView = _textView;

#define kFont [UIFont fontWithName:@"Tahoma" size:28]
#define kChar @[ @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @" "]


/* Initialize Keyboard */
- (id)init {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
	CGRect frame;
    
    // Load Frame
    if(UIDeviceOrientationIsLandscape(orientation)) {
        frame = CGRectMake(0, 0, 1024, 352);
    }
    else {
        frame = CGRectMake(0, 0, 768, 264);
    }
    
    // Load Frame
	self = [super initWithFrame:frame];
	if (self) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TabtorKeyboard" owner:self options:nil];
		[[nib objectAtIndex:0] setFrame:frame];
        self = [nib objectAtIndex:0];
    }
	
    // Load Buttons
	NSMutableArray *buttons = [NSMutableArray arrayWithArray:self.characterKeys];
	[buttons addObject:self.returnButton];
	[buttons addObject:self.dismissButton];
	[buttons addObject:self.deleteButton];

	for (UIButton *b in buttons) {
		[b setBackgroundImage:[TabtorKeyboard imageFromColor:[UIColor colorWithWhite:0.5 alpha:0.5]]
						  forState:UIControlStateHighlighted];
		b.layer.cornerRadius = 7.0;
		b.layer.masksToBounds = YES;
		b.layer.borderWidth = 0;
	}
	
	self.returnButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
	[self loadCharactersWithArray:kChar];
    
    // Keyboard Customization for iOS 7
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        for (UIButton *b in buttons) {
            [b setBackgroundImage:[TabtorKeyboard imageFromColor:[UIColor colorWithWhite:0.7 alpha:0.5]]
                         forState:UIControlStateHighlighted];
            b.layer.cornerRadius = 6.0;
            b.titleLabel.shadowOffset = CGSizeMake(0, 0);
        }
    }
	
	return self;
}

-(void)setTextView:(id<UITextInput>)textView {
	
	if ([textView isKindOfClass:[UITextView class]])
        [(UITextView *)textView setInputView:self];
    else if ([textView isKindOfClass:[UITextField class]])
        [(UITextField *)textView setInputView:self];
    
    _textView = textView;
}

-(id<UITextInput>)textView {
	return _textView;
}

/* Load Initial Keyboard with Array of Characters */
-(void)loadCharactersWithArray:(NSArray *)a {
    
    // Read Json
    [self readKeyboards];
    
	int keyIndex = 0;
	for (UIButton *b in self.characterKeys) {
        NSString *character = [self findCharacterByKey:[NSString stringWithFormat:@"%d",keyIndex]];
		[b setTitle:character forState:UIControlStateNormal];
		[b.titleLabel setFont:kFont];
		keyIndex++;
	}
}

/* Read Key Data  */
-(NSString *)findCharacterByKey:(NSString *)key {
    for(Keyboard *keyobject in keyboards){
        if([keyobject.key isEqualToString:key]){
            return keyobject.character;
        }
    }
    return @"";
}

/* Read Keyboard data  */
-(NSArray *)readKeyboards
{
    keyboards = [[NSMutableArray alloc]init];
    NSString *jsonFilePath=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[@"keyboards" stringByAppendingPathExtension:@"json"]];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonFilePath];
    JSONDecoder* decoder = [[JSONDecoder alloc] initWithParseOptions:JKParseOptionNone];
    NSDictionary *dictionary = [decoder objectWithData:jsonData];
    
    NSArray *keyboardArray = [dictionary objectForKey:@"keyboards"];
    for(int i=0;i<[keyboardArray count];i++){
        NSDictionary *keyboardDictionary = [keyboardArray objectAtIndex:i];
        Keyboard *keyObject = [[Keyboard alloc]init];
        keyObject.key = [keyboardDictionary objectForKey:@"key"];
        keyObject.character = [keyboardDictionary objectForKey:@"character"];
        keyObject.group = [keyboardDictionary objectForKey:@"group"];
        [keyboards addObject:keyObject];
    }
    
    return keyboards;
}


/* IBActions for Keyboard Buttons */
- (IBAction)returnPressed:(id)sender{
    if ([[(UITextField *)self.textView delegate] respondsToSelector:@selector(textFieldShouldReturn:)]) {
        [[(UITextField *)self.textView delegate] textFieldShouldReturn:(UITextField *)self.textView];
    }
}

/* Keyboard is Dismissed */
- (IBAction)dismissPressed:(id)sender {
	if ([self.textView isKindOfClass:[UITextView class]]) 
        [(UITextView *)self.textView resignFirstResponder];
	
    else if ([self.textView isKindOfClass:[UITextField class]])
        [(UITextField *)self.textView resignFirstResponder];
}

/* Delete Key Pressed */
- (IBAction)deletePressed:(id)sender {
	[self.textView deleteBackward];
	[[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification
														object:self.textView];
	if ([self.textView isKindOfClass:[UITextView class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
	else if ([self.textView isKindOfClass:[UITextField class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
}

/* Character Pressed */
- (IBAction)characterPressed:(id)sender {
    [[UIDevice currentDevice] playInputClick];
	UIButton *button = (UIButton *)sender;
	NSString *character = [NSString stringWithString:button.titleLabel.text];
    
    NSLog(@"User entered character %@",character);
	[self.textView insertText:character];

	if ([self.textView isKindOfClass:[UITextView class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self.textView];
	else if ([self.textView isKindOfClass:[UITextField class]])
		[[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:self.textView];
}

/* UI Utilities */
+ (UIImage *) imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
