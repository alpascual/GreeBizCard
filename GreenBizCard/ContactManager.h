//
//  ContactManager.h
//  GreenBizCard
//
//  Created by Albert Pascual on 3/28/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface ContactManager : NSObject {
    
    ABAddressBookRef addressBook;
    NSArray *rawPerson;
}

@property (nonatomic,retain) NSArray *rawPerson;

- (ABRecordRef) GetPerson:(NSString *)key;
- (void)AddPersonInContacts:(ABRecordRef)newPerson;
- (NSArray*) GetRawPerson:(NSString *)key;

@end
