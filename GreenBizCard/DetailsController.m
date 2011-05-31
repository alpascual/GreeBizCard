//
//  DetailsController.m
//  GreenBizCard
//
//  Created by Albert Pascual on 3/28/11.
//  Copyright 2011 Al. All rights reserved.
//

#import "DetailsController.h"


@implementation DetailsController

@synthesize listCards, resultTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil person:(ABRecordRef)newPerson raw:(NSArray*)myCard
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        person = newPerson;
        
        NSMutableArray *muArray = [[[NSMutableArray alloc] initWithArray:myCard] autorelease];
        [muArray removeObjectAtIndex: 0];
          
         self.listCards = [NSArray arrayWithArray:muArray];
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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


#pragma mark -
#pragma mark Table view delegate

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
    
    NSUInteger row = [indexPath row]; 
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        
        //cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
        CGRect frame;
        frame.origin.x = 10;
        frame.origin.y = 5;
        frame.size.height = 15;
        frame.size.width = 200;
        
        UILabel *title = [[UILabel alloc] initWithFrame:frame];
        [title setFont:[UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:16]];
        title.textColor = [UIColor grayColor];
        title.tag = 1;
        [cell.contentView addSubview:title];
        [title release];
        
        frame.origin.y += 18;
        
        UILabel *details = [[UILabel alloc] initWithFrame:frame];
        details.tag = 2;
        [cell.contentView addSubview:details];
        [details release];      
        
    }
    
    UILabel * title = (UILabel *) [cell.contentView viewWithTag:1];
    UILabel * details = (UILabel *) [cell.contentView viewWithTag:2];
   
    NSString *anObject = [self.listCards objectAtIndex:row];
    
    title.text = @"title";
    switch (row) {
        case 1:
            title.text = @"Name";
            break;
        case 2:
            title.text = @"Title";
            break;
        case 3:
            title.text = @"Company";
            break;
        case 4:
            title.text = @"Email";
            break;
        case 5:
            title.text = @"Phone";
            break;
        case 6:
            title.text = @"Ext";
            break;
        case 7:
            title.text = @"Mobile";
            break;
        case 8:
            title.text = @"Twitter";
            break;
        case 9:
            title.text = @"Notes";
            break;
        default:
            break;
    }
    details.text = anObject;
    
    NSLog(@"Returning cell");
    return cell;
}


// Actions
- (IBAction) done
{
    [self dismissModalViewControllerAnimated:YES];
}
- (IBAction) createContact
{
    ContactManager *contacts = [[ContactManager alloc] init];
    [contacts AddPersonInContacts:person];
    [contacts release];
    
}
- (IBAction) saveContact
{
    
}

@end
