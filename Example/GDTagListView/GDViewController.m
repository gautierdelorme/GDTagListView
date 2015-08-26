//
//  GDViewController.m
//  GDTagListView
//
//  Created by gautierdelorme on 08/26/2015.
//  Copyright (c) 2015 gautierdelorme. All rights reserved.
//

#import "GDViewController.h"
#import <GDTagListView/GDTagListView.h>

#define kCloudsColor        [UIColor colorWithRed:236.0f/255.0f green:240.0f/255.0f blue:241.0f/255.0f alpha:1.0f]
#define kPeterRiverColor    [UIColor colorWithRed:52.0f/255.0f green:152.0f/255.0f blue:219.0f/255.0f alpha:1.0f]

@interface GDViewController () <UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, strong)   GDTagListView   *tagList;
@property                       NSUInteger      selection;

@end

@implementation GDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kCloudsColor;
    self.title = @"GDTagListView Demo";
    self.navigationController.navigationBar.barTintColor = kPeterRiverColor;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    UITextField *textInput = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, [[UIScreen mainScreen]bounds].size.width-80, 50)];
    textInput.placeholder = @"Add a new tag...";
    textInput.borderStyle = UITextBorderStyleRoundedRect;
    textInput.returnKeyType = UIReturnKeyDone;
    textInput.delegate = self;
    
    UILabel *removeLabel = [[UILabel alloc] initWithFrame:CGRectMake(textInput.frame.origin.x+textInput.frame.size.width+5, textInput.frame.origin.y, 60, 30)];
    removeLabel.text = @"Enabled tags removing";
    removeLabel.textAlignment = NSTextAlignmentCenter;
    removeLabel.numberOfLines = 2;
    removeLabel.font = [UIFont systemFontOfSize:9];
    removeLabel.textColor = [UIColor darkGrayColor];
    
    UISwitch *switchRemove = [[UISwitch alloc] initWithFrame:CGRectMake(textInput.frame.origin.x+textInput.frame.size.width+5, textInput.frame.origin.y+textInput.frame.size.height-25, 0, 0)];
    switchRemove.transform = CGAffineTransformMakeScale(0.75, 0.75);
    [switchRemove addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.tagList = [[GDTagListView alloc] initWithFrame:CGRectMake(textInput.frame.origin.x, textInput.frame.origin.y+textInput.frame.size.height+10, [[UIScreen mainScreen]bounds].size.width-20, [[UIScreen mainScreen]bounds].size.height-(textInput.frame.origin.y+textInput.frame.size.height+20))];
    self.tagList.tagColor = kPeterRiverColor;
    [self.tagList addTags:@[@"github", @"ios", @"apple", @"facebook", @"twitter", @"google", @"linkedin",
                       @"scoopit", @"buffer", @"xcode", @"very long long tag"]];
    
    __weak GDViewController* weakSelf = self;
    [self.tagList setCompletionBlockWithSelected:^(NSInteger index) {
        weakSelf.selection = (NSUInteger)index;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete"
                                                        message:[NSString stringWithFormat:@"Delete %@?", weakSelf.tagList.tags[index]]
                                                       delegate:weakSelf
                                              cancelButtonTitle:@"Nope"
                                              otherButtonTitles:@"Sure!", nil];
        [alert show];
    }];
    
    [self.view addSubview:textInput];
    [self.view addSubview:removeLabel];
    [self.view addSubview:switchRemove];
    [self.view addSubview:self.tagList];
}

- (void)switchChanged:(UISwitch *)switchRemove
{
    self.tagList.canRemove = [switchRemove isOn];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length > 0)
        [self.tagList addTag:textField.text];
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex > 0) {
        [self.tagList removeTagAtIndex:self.selection];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
