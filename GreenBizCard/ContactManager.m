//
//  ContactManager.m
//  GreenBizCard
//
//  Created by Albert Pascual on 3/28/11.
//  Copyright 2011 Al. All rights reserved.
//

#import "ContactManager.h"


@implementation ContactManager

@synthesize rawPerson;


- (NSArray*) GetRawPerson:(NSString *)key
{
    if ( self.rawPerson == nil )
        [self GetPerson:key];
    
    return rawPerson;
}

- (ABRecordRef) GetPerson:(NSString *)key
{
    NSString *retrieveUrl = [[NSString alloc] initWithFormat:@"http://store.alsandbox.us/about.aspx?Retrieve=%@", key];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:retrieveUrl]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *get = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    NSLog(@"response %@", get);
    
    NSArray *chunks = [get componentsSeparatedByString: @"~"];
    self.rawPerson = chunks;
    
    [retrieveUrl release];
    
    //addressBook = ABAddressBookCreate();
    
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
    
    [get release];
    
    return newPerson;
}

- (void)AddPersonInContacts:(ABRecordRef)newPerson
{
    addressBook = ABAddressBookCreate();
    
    ABAddressBookAddRecord(addressBook, newPerson, NULL);
    ABAddressBookSave(addressBook, NULL);
}


@end
