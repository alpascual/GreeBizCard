//
//  DetailsController.h
//  GreenBizCard
//
//  Created by Albert Pascual on 3/28/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

#import "ContactManager.h"

@interface DetailsController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
    ABRecordRef person;
    NSArray *listCards;
    UITableView *resultTable;
}

@property (nonatomic,retain) NSArray *listCards;
@property (nonatomic,retain) IBOutlet UITableView *resultTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil person:(ABRecordRef)newPerson raw:(NSArray*)myCard;

- (IBAction) done;
- (IBAction) createContact;
- (IBAction) saveContact;
@end
