//
//  FirstViewController.m
//  GreenBizCard
//
//  Created by Albert Pascual on 3/15/11.
//  Copyright 2011 Al. All rights reserved.
//

#import "FirstViewController.h"


@implementation FirstViewController

@synthesize gpsUtil, lastLatitude, lastLongitude, scanButton, resultTable, listCards, addressBook;
@synthesize navigationController;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.gpsUtil = [[GpsController alloc] init];
    self.gpsUtil.gpsDelegate = self;
    
    [self.gpsUtil start];
    
    self.resultTable.delegate = self;
    
    /*self.navigationController.view.frame = CGRectMake(self.navigationController.view.frame.origin.x, self.navigationController.view.frame.origin.y - 20,
                                self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height);
    [self.view addSubview:self.navigationController.view];
     */
    
    //[self.view.window makeKeyAndVisible];
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

- (IBAction) scanNow
{
    [[SHKActivityIndicator currentIndicator] displayCompleted:@"Searching..."];
    
    // Scan now  
    // set test
	if ( self.listCards == nil )
		self.listCards = [[NSMutableDictionary alloc] init];
	else {
		[self.listCards removeAllObjects];
	}
    
    // ---------------
    // Search Twitter    
    /*NSString *searchUrl = [[NSString alloc] initWithFormat:@"http://search.twitter.com/search.atom?q=from:dakotapascual&result_type=recent&since_id=50405371310915584"];
     
     NSString *searchTwitterReq = [[NSString alloc] initWithFormat:@"%@&geocode=%@,%@,500mi", searchUrl, self.lastLatitude, self.lastLongitude];
     
     NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:searchTwitterReq]];
     NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
     NSString *get = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
     
     NSLog(@"response %@", get);
     
     [searchTwitterReq release];
     
     // parse atom or xml
     NSData *xmlData = [get dataUsingEncoding:NSUTF8StringEncoding];
     NSXMLParser *parser = [[[NSXMLParser alloc] initWithData:xmlData] autorelease];
     [parser setDelegate:self];
     [parser parse];   	*/
    // ---------------
    
    // cheap Tweet
    NSString *searchUrl2 = [[NSString alloc] initWithFormat:@"http://store.alsandbox.us/about.aspx?Search=2&Lat=%@&Lon=%@", self.lastLatitude, self.lastLongitude];
    
    NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:searchUrl2]];
    NSData *response2 = [NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
    NSString *get2 = [[NSString alloc] initWithData:response2 encoding:NSUTF8StringEncoding];
    
    NSLog(@"response %@", get2);
    
    NSRange firstRange = [get2 rangeOfString:@"|"];
    
    if ( firstRange.length > 0 )
    {
        NSArray *chunks = [get2 componentsSeparatedByString: @"|"];
        
        for (NSString *t in chunks) 
        {
            NSRange startRange = [t rangeOfString:@"~"];
            if ( startRange.length > 0 )
            {
                NSArray *fields = [t componentsSeparatedByString: @"~"];        
                [self.listCards setObject:[fields objectAtIndex:1] forKey:[fields objectAtIndex:0]];
            }
        }
    }
    [searchUrl2 release];
    [get2 release];
    
    if ( [self.listCards count] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Cards Found" message:@"The application could not find any Green Business Cards that people sent around here. Or your Internet is down."
                                                       delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        [alert release];
    }
    
    // Load when everything is parsed
    [self.resultTable reloadData]; 
    NSLog(@"Finished loading the table");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    NSLog(@"Started %@", elementName);
    
    if (qualifiedName) elementName = qualifiedName;
	if (elementName) current = [NSString stringWithString:elementName];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
{
	current = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (!current) return;
	if ([current isEqualToString:@"title"]) 
    {
        /*NSRange startRange = [string rangeOfString:@"~"];
         NSLog(@"location of character: %d", startRange.location);
         
         if ( startRange.length > 0 )*/
        //[self.listCards addObject:string];
    }
}


- (void)dealloc
{
    [super dealloc];
    
    [self.listCards release];
}

-(void) gpsFinished:(NSString*)latitude:(NSString*)longitude
{
    self.lastLatitude = latitude;
    self.lastLongitude = longitude;
    
    scanButton.enabled = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"Returning num sections");
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Returning num rows");
    
    if ( self.listCards == nil )
    {
        return 0;
    }
    
    return [self.listCards count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Trying to return cell");
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    NSUInteger row = [indexPath row]; 
    NSArray *keys = [self.listCards allKeys];
    id aKey = [keys objectAtIndex:row];
    NSString *anObject = [self.listCards objectForKey:aKey];
    
    cell.text = anObject;
    
    NSLog(@"Returning cell");
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void) createContact:(NSIndexPath *) indexPath
{
   /* NSUInteger row = [indexPath row];
   	NSArray *keys = [self.listCards allKeys];
    NSString *key = [keys objectAtIndex:row];
    
    // retrive the object by key
    ContactManager *contacts = [[ContactManager alloc] init];
    ABRecordRef newPerson = [contacts GetPerson:key];
        
    
    NSString *retrieveUrl = [[NSString alloc] initWithFormat:@"http://store.alsandbox.us/about.aspx?Retrieve=%@", key];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:retrieveUrl]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *get = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    NSLog(@"response %@", get);
    
    NSArray *chunks = [get componentsSeparatedByString: @"~"];
    
    [retrieveUrl release];
    
    addressBook = ABAddressBookCreate();
    
    ABRecordRef newPerson = ABPersonCreate();
    
    ABRecordSetValue(newPerson, kABPersonFirstNameProperty, [chunks objectAtIndex:1], NULL);
    //ABRecordSetValue(newPerson, kABPersonLastNameProperty, @"Doe", NULL);
    
    ABRecordSetValue(newPerson, kABPersonOrganizationProperty, [chunks objectAtIndex:3], NULL);
    ABRecordSetValue(newPerson, kABPersonJobTitleProperty, [chunks objectAtIndex:2], NULL);
    
    ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiPhone, [chunks objectAtIndex:5], kABPersonPhoneMainLabel, NULL);
    ABMultiValueAddValueAndLabel(multiPhone, [chunks objectAtIndex:4], kABPersonPhoneMobileLabel, NULL);            
    ABMultiValueAddValueAndLabel(multiPhone, [chunks objectAtIndex:6], kABOtherLabel, NULL);        
    ABRecordSetValue(newPerson, kABPersonPhoneProperty, multiPhone,nil);
    CFRelease(multiPhone);
    
    ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiEmail, [chunks objectAtIndex:7], kABWorkLabel, NULL);
    ABRecordSetValue(newPerson, kABPersonEmailProperty, multiEmail, NULL);
    CFRelease(multiEmail);
    
    ABAddressBookAddRecord(addressBook, newPerson, NULL);
    ABAddressBookSave(addressBook, NULL);
	
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Contact Saved" message: @"The contact was saved on your address book" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
    
    [alert show];
    [alert release];*/
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *) indexPath {
    
    //[self createContact:indexPath];
    
    // Show the info and ask action
    [self showContact:indexPath];
    
}


- (void) showContact:(NSIndexPath *) indexPath
{
    NSUInteger row = [indexPath row];
   	NSArray *keys = [self.listCards allKeys];
    NSString *key = [keys objectAtIndex:row];    
    
    ContactManager *contacts = [[ContactManager alloc] init];
    ABRecordRef newPerson = [contacts GetPerson:key];
    NSArray *rawPerson = [contacts GetRawPerson:key];
    
    DetailsController *details = [[DetailsController alloc] initWithNibName:@"DetailsController" bundle:nil person:newPerson raw:rawPerson];
    
    //[self.navigationController pushViewController:details animated:YES];
    [self presentModalViewController:details animated:YES];
    
    [contacts release];
}


- (void)tableView:(UITableView *)tableView  didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showContact:indexPath];
    
    //[self createContact:indexPath];
    
    /*NSString *cellvalue = [NSString stringWithFormat:@"%@", [feature.attributes valueForKey:key]];
     
     if ( [cellvalue hasPrefix:@"http://"] == YES)
     {
     NSLog(@"Has HTTP : %@", cellvalue);
     
     
     
     iPadAboutBox *aboutUsViewController = [[iPadAboutBox alloc] initWithNibName:@"iPadAboutBox" bundle:nil];
     
     aboutUsViewController.navigationBar.topItem.title = @"Details";
     aboutUsViewController.title = @"Details";
     
     aboutUsViewController.urlToOpen = [NSURL URLWithString:cellvalue];
     aboutUsViewController.modalPresentationStyle = UIModalPresentationFormSheet;
     aboutUsViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
     [self presentModalViewController:aboutUsViewController animated:YES];
     [aboutUsViewController.aLoadingIndicator startAnimating];	
     
     [aboutUsViewController release];
     }
     else if ([cellvalue hasPrefix:@"Send Feedback"] == YES)
     {
     FeedbackController *feedback = [[FeedbackController alloc] init];
     
     feedback.body = cellvalue;
     
     [feedback sendEmail];
     
     [feedback release];
     }*/
}


@end
