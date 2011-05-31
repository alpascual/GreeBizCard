//
//  SecondViewController.m
//  GreenBizCard
//
//  Created by Albert Pascual on 3/15/11.
//  Copyright 2011 Al. All rights reserved.
//

#import "SecondViewController.h"


@implementation SecondViewController

@synthesize gpsUtil;
@synthesize lastLatitude, lastLongitude;
@synthesize sendButton;
@synthesize  NameField, TitleField, CompanyField, MobileField, PhoneField, ExtField,
             EmailField, TwitterField, NoteField;
@synthesize blueComm;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sendButton.enabled = NO;
    
    self.gpsUtil = [[GpsController alloc] init];
    self.gpsUtil.gpsDelegate = self;
    
    [self.gpsUtil start];
    
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
    
    self.blueComm = [[BlueToothController alloc] init];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc
{
    [super dealloc];
    
    [self.gpsUtil stop];
    [self.gpsUtil release];
    [self.lastLongitude release];
    [self.lastLatitude release];
    
    [self.blueComm nullifySession];
    [self.blueComm release];
}


- (IBAction) sendCardNow
{
    CardUtils *cardUtil = [[CardUtils alloc] init];
    
    // Send it to the CARD website first with a unique number
    NSString *MyCardNumber = [cardUtil createNewCardNumber];
       
    
    /*NSString *allInfo = [[NSString alloc] initWithFormat:@"http://store.alsandbox.us/default.aspx?Store=%@&Card=%@", 
                         MyCardNumber, [cardUtil getAllCharacterForCard]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:allInfo]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *get = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    NSLog(@"response %@", get);
    [get release];
    [allInfo release];*/
    
    NSError *error;
    
    // Store in the cheap tweet as well
    NSString *allInfo2 = [[NSString alloc] initWithFormat:@"http://store.alsandbox.us/about.aspx?Store=%@&Card=%@&Lat=%@&Lon=%@", MyCardNumber, [cardUtil getAllCharacterForCard], self.lastLatitude, self.lastLongitude]; 
    NSString *escapedUrl = [allInfo2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:escapedUrl]];
    NSData *response2 = [NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:&error];
    NSString *get2 = [[NSString alloc] initWithData:response2 encoding:NSUTF8StringEncoding];
    
    [self.blueComm sendDataAction:[cardUtil getAllCharacterForCard]];
    
    NSLog(@"response tweet%@", get2);
    [get2 release];
    [allInfo2 release];
    [cardUtil release];
    
    [[SHKActivityIndicator currentIndicator] displayCompleted:@"Sent!"];
    
    
    // Do it in a tweet
    /*NSString *textForTweet = [[NSString alloc] initWithFormat:@"%@~%@", MyCardNumber, [cardUtil getName]];
    
    SHKItem *item = [SHKItem text:textForTweet];
    [item setCustomValue:textForTweet forKey:@"status"];
    [item setCustomValue:self.lastLatitude forKey:@"lat"];
    [item setCustomValue:self.lastLongitude forKey:@"long"];
    
    SHKTwitter *twitter = [[SHKTwitter alloc] init];
    twitter.item = item;
    
    twitter.consumer = [[OAConsumer alloc] initWithKey:@"K8MVPMdqJIgkjtx7uDuoQ" 
                                                secret:@"y82OJfcDSoFf6itT7jtgh6oyX6SPdTXzPKST6tU"];
    twitter.accessToken = [[OAToken alloc] initWithKey:@"266977645-PDoRsF0jD7WsLcZHQBfG9BQpW4TrQ8hFTc8ootIu" 
                                                secret:@"s01q0aFiAGfB3YJHSvkZsEzw3CRVqDTJ7TBvZVseIg"];
    
    
    [twitter sendStatus];
     */
    
    
    
    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Sent" message: @"Now any other person close to you can pick up your Green Business Card by scanning" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
    
    [alert show];
    [alert release];*/
    
    
    
}

-(void) gpsFinished:(NSString*)latitude:(NSString*)longitude
{
    self.lastLatitude = latitude;
    self.lastLongitude = longitude;
    
    sendButton.enabled = YES;
}




@end
