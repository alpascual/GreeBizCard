//
//  FirstViewController.h
//  GreenBizCard
//
//  Created by Albert Pascual on 3/15/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

#import "GpsController.h"
#import "DetailsController.h"
#import "ContactManager.h"
#import "SHKActivityIndicator.h"


@interface FirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, GpsDelegateProtocol, NSXMLParserDelegate, UINavigationControllerDelegate> {
    
    UIButton *scanButton;
    
    UITableView *resultTable;
    NSString *lastLatitude;
    NSString *lastLongitude;
    
    GpsController *gpsUtil;
    NSMutableDictionary *listCards;
    
    NSString		*current;
    ABAddressBookRef addressBook;
    
    UINavigationController *navigationController;
    
}

@property (nonatomic,retain) GpsController *gpsUtil;
@property (nonatomic,retain) NSString *lastLatitude;
@property (nonatomic,retain) NSString *lastLongitude;
@property (nonatomic,retain) IBOutlet UIButton *scanButton;
@property (nonatomic,retain) IBOutlet UITableView *resultTable;
@property (nonatomic,retain) NSMutableDictionary *listCards;
@property(nonatomic, readwrite) ABAddressBookRef addressBook;
@property (nonatomic,retain) IBOutlet UINavigationController *navigationController;

- (IBAction) scanNow;
- (void) createContact:(NSIndexPath *) indexPath;
- (void) showContact:(NSIndexPath *) indexPath;

@end
