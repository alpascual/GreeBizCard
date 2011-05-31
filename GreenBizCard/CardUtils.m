//
//  CardUtils.m
//  GreenBizCard
//
//  Created by Al Pascual on 3/22/11.
//  Copyright 2011 Al. All rights reserved.
//

#import "CardUtils.h"


@implementation CardUtils


- (NSString*) createNewCardNumber {
    CFUUIDRef	uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString	*uuidString = (NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return [uuidString autorelease];
}

- (NSString *) getName
{
    NSUserDefaults *myPrefs = [NSUserDefaults standardUserDefaults];
    if ( [myPrefs stringForKey:@"NameField"] != nil )
    {
        return [myPrefs stringForKey:@"NameField"];
    }
    
    return nil;
}

- (NSString *) getAllCharacterForCard
{
    
    NSUserDefaults *myPrefs = [NSUserDefaults standardUserDefaults];
    if ( [myPrefs stringForKey:@"NameField"] != nil )
    {
        NSString *NameField = [myPrefs stringForKey:@"NameField"];
        NSString *TitleField = [myPrefs stringForKey:@"TitleField"];
        NSString *CompanyField = [myPrefs stringForKey:@"CompanyField"];
        NSString *MobileField = [myPrefs stringForKey:@"MobileField"];
        NSString *PhoneField = [myPrefs stringForKey:@"PhoneField"];
        NSString *ExtField = [myPrefs stringForKey:@"ExtField"];
        NSString *EmailField = [myPrefs stringForKey:@"EmailField"];
        NSString *TwitterField = [myPrefs stringForKey:@"TwitterField"];
        NSString *NoteField = [myPrefs stringForKey:@"NoteField"];
        
        NSString *allStrings = [[NSString alloc] initWithFormat:@"1~%@~%@~%@~%@~%@~%@~%@~%@~%@", NameField,
                                TitleField, CompanyField,
                                MobileField,
                                PhoneField,
                                ExtField,
                                EmailField,
                                TwitterField,
                                NoteField ];
        
        /*if ( [allStrings length] > 140 )
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Card too long" message:@"Please reduce the number of characters in total in the card for now, storage is limited for verrsion 1"
                                                           delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
            [alert show];
            [alert release];
            
        }*/
        
        [NameField release];
        [TitleField  release];
        [CompanyField  release];
        [MobileField release];
        [PhoneField release];
        [ExtField  release];
        [EmailField  release];
        [TwitterField  release];
        [NoteField release];

        return allStrings;
    }
    
    return nil;
}

@end
