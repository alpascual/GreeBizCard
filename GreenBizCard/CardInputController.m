//
//  CardInputController.m
//  GreenBizCard
//
//  Created by Albert Pascual on 3/19/11.
//  Copyright 2011 Al. All rights reserved.
//

#import "CardInputController.h"
#import "CompressUtil.h"


@implementation CardInputController

@synthesize  NameField, TitleField, CompanyField, MobileField, PhoneField, ExtField,
             EmailField, TwitterField, NoteField, saveButton;
@synthesize scrollView, second, tabBarController;

UIButton *saveButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.scrollView.frame = CGRectMake(0, 0, 320, 460);
    [self.scrollView setContentSize:CGSizeMake(320, 1040)];        
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSUserDefaults *myPrefs = [NSUserDefaults standardUserDefaults];
    if ( [myPrefs stringForKey:@"NameField"] != nil )
    {
        self.NameField.text = [myPrefs stringForKey:@"NameField"];
        self.TitleField.text = [myPrefs stringForKey:@"TitleField"];
        self.CompanyField.text = [myPrefs stringForKey:@"CompanyField"];
        self.MobileField.text = [myPrefs stringForKey:@"MobileField"];
        self.PhoneField.text = [myPrefs stringForKey:@"PhoneField"];
        self.ExtField.text = [myPrefs stringForKey:@"ExtField"];
        self.EmailField.text = [myPrefs stringForKey:@"EmailField"];
        self.TwitterField.text = [myPrefs stringForKey:@"TwitterField"];
        self.NoteField.text = [myPrefs stringForKey:@"NoteField"];        
    }
}

-(void) viewWillAppear:(BOOL)animated {    
    //---registers the notifications for keyboard---
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardDidShow:) 
                                                 name:UIKeyboardDidShowNotification 
                                               object:self.view.window]; 
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

//---when a TextField view begins editing---
-(void) textFieldDidBeginEditing:(UITextField *)textFieldView {  
    currentTextField = textFieldView;
}  

-(BOOL) textFieldShouldReturn:(UITextField *) textFieldView {  
    [textFieldView resignFirstResponder];
    return NO;
}

//---when a TextField view is done editing---
-(void) textFieldDidEndEditing:(UITextField *) textFieldView {  
    currentTextField = nil;
}

//---when the keyboard appears---
-(void) keyboardDidShow:(NSNotification *) notification {
    if (keyboardIsShown) return;
    
    NSDictionary* info = [notification userInfo];
    
    //---obtain the size of the keyboard---
    NSValue *aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    //---resize the scroll view (with keyboard)---
    CGRect viewFrame = [scrollView frame];
    viewFrame.size.height -= keyboardSize.height;
    scrollView.frame = viewFrame;
    
    //---scroll to the current text field---
    CGRect textFieldRect = [currentTextField frame];
    [scrollView scrollRectToVisible:textFieldRect animated:YES];
    
    keyboardIsShown = YES;
}

//---when the keyboard disappears---
-(void) keyboardDidHide:(NSNotification *) notification {
    NSDictionary* info = [notification userInfo];
    
    //---obtain the size of the keyboard---
    NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    //---resize the scroll view back to the original size (without keyboard)---
    CGRect viewFrame = [scrollView frame];
    viewFrame.size.height += keyboardSize.height;
    scrollView.frame = viewFrame;
    
    keyboardIsShown = NO;
}

-(void) viewWillDisappear:(BOOL)animated {
    //---removes the notifications for keyboard---
    [[NSNotificationCenter defaultCenter] 
     removeObserver:self 
     name:UIKeyboardWillShowNotification 
     object:nil];
    [[NSNotificationCenter defaultCenter] 
     removeObserver:self 
     name:UIKeyboardWillHideNotification 
     object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) saveForm
{
    //---removes the notifications for keyboard---
    [[NSNotificationCenter defaultCenter] 
     removeObserver:self 
     name:UIKeyboardWillShowNotification 
     object:nil];
    [[NSNotificationCenter defaultCenter] 
     removeObserver:self 
     name:UIKeyboardWillHideNotification 
     object:nil];
    
    NSUserDefaults *myPrefs = [NSUserDefaults standardUserDefaults];
    [myPrefs setObject:self.NameField.text forKey:@"NameField"];
    [myPrefs setObject:self.TitleField.text forKey:@"TitleField"];
    [myPrefs setObject:self.CompanyField.text forKey:@"CompanyField"];
    [myPrefs setObject:self.MobileField.text forKey:@"MobileField"];
    [myPrefs setObject:self.PhoneField.text forKey:@"PhoneField"];
    [myPrefs setObject:self.ExtField.text forKey:@"ExtField"];
    [myPrefs setObject:self.EmailField.text forKey:@"EmailField"];
    [myPrefs setObject:self.TwitterField.text forKey:@"TwitterField"];
    [myPrefs setObject:self.NoteField.text forKey:@"NoteField"];
    
    [self resignFirstResponder];
    [self.saveButton resignFirstResponder];
    [self.NameField resignFirstResponder];
    [self.TitleField resignFirstResponder];
    [self.CompanyField resignFirstResponder];
    [self.MobileField resignFirstResponder];
    [self.PhoneField resignFirstResponder];
    [self.ExtField resignFirstResponder];
    [self.EmailField resignFirstResponder];
    [self.TwitterField resignFirstResponder];
    [self.NoteField resignFirstResponder];
    
    keyboardIsShown = NO;
    
    [[SHKActivityIndicator currentIndicator] displayCompleted:@"Saved!"];
    
    /*NSString *allStrings = [[NSString alloc] initWithFormat:@"1~%@~%@~%@~%@~%@~%@~%@~%@~%@", self.NameField.text,
                                                            self.TitleField.text, self.CompanyField.text,
                                                            self.MobileField.text,
                                                            self.PhoneField.text,
                                                            self.ExtField.text,
                                                            self.EmailField.text,
                                                            self.TwitterField.text,
                                                            self.NoteField.text ];
    
    self.tabBarController = [[UITabBarController alloc] initWithNibName:@"MainWindow" bundle:nil];
    [self.tabBarController setSelectedIndex:1];
     */
    
    /*self.second = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    [self.navigationController pushViewController:self.second animated:YES];
    self.second.modalPresentationStyle = UIModalPresentationFormSheet;
    self.second.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:self.second animated:YES];
     */
  
    /*if ( [allStrings length] > 140 )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Card too long" message:@"Please reduce the number of characters in total in the card for now, storage is limited for verrsion 1"
                                                       delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [alert show];
        [alert release];
        
    }*/
       
    /*NSData* data=[allStrings dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
 
    // Zip the info
    NSData* compressed = [data gzipDeflate];    
    
    NSString *secondtry = [[NSString alloc] initWithData:compressed encoding:NSUTF8StringEncoding];
    
    //NSString *secondtry = [[NSString alloc]  initWithBytes:[compressed bytes]
      //                                            length:[compressed length] encoding: NSUTF8StringEncoding];
    
    NSLog(@"the compresses string looks like %@", secondtry);
    
    NSData* databack=[secondtry dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSData* originalData = [databack gzipInflate]; 
      
    //NSString *final = [NSString stringWithUTF8String:[originalData bytes]];
    NSString *final = [[NSString alloc]  initWithData:originalData encoding: NSUTF8StringEncoding];
    
    NSLog(@"the uncompresses back string looks like %@", final);
    
    [secondtry release];
     */
        
}



@end
