//
//  CardInputController.h
//  GreenBizCard
//
//  Created by Albert Pascual on 3/19/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"


@interface CardInputController : UIViewController {
    
    UITextField *NameField;
    UITextField *TitleField;
    UITextField *CompanyField;
    UITextField *MobileField;
    UITextField *PhoneField;
    UITextField *ExtField;
    UITextField *EmailField;
    UITextField *TwitterField;
    UITextField *NoteField;
    
    UIButton *saveButton;
    
    UIScrollView *scrollView;
    UITextField *currentTextField;
    BOOL keyboardIsShown;
    
    SecondViewController *second;
    UITabBarController *tabBarController;
}

@property (nonatomic,retain) IBOutlet UITextField *NameField;
@property (nonatomic,retain) IBOutlet UITextField *TitleField;
@property (nonatomic,retain) IBOutlet UITextField *CompanyField;
@property (nonatomic,retain) IBOutlet UITextField *MobileField;
@property (nonatomic,retain) IBOutlet UITextField *PhoneField;
@property (nonatomic,retain) IBOutlet UITextField *ExtField;
@property (nonatomic,retain) IBOutlet UITextField *EmailField;
@property (nonatomic,retain) IBOutlet UITextField *TwitterField;
@property (nonatomic,retain) IBOutlet UITextField *NoteField;

@property (nonatomic,retain) IBOutlet UIButton *saveButton;
@property (nonatomic,retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic,retain) SecondViewController *second;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

- (IBAction) saveForm;

@end
