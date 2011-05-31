//
//  SecondViewController.h
//  GreenBizCard
//
//  Created by Albert Pascual on 3/15/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "SHK.h"
#import "SHKTwitter.h"
#import "OAToken.h"

#import "GpsDelegateProtocol.h"
#import "GpsController.h"
#import "CardUtils.h"
#import "BlueToothController.h"

@interface SecondViewController : UIViewController <GpsDelegateProtocol> {
    
    GpsController *gpsUtil;
    NSString *lastLatitude;
    NSString *lastLongitude;
    
    UIButton *sendButton;
    
    UILabel *NameField;
    UILabel *TitleField;
    UILabel *CompanyField;
    UILabel *MobileField;
    UILabel *PhoneField;
    UILabel *ExtField;
    UILabel *EmailField;
    UILabel *TwitterField;
    UILabel *NoteField;
    
    BlueToothController *blueComm;
}

@property (nonatomic,retain) GpsController *gpsUtil;
@property (nonatomic,retain) NSString *lastLatitude;
@property (nonatomic,retain) NSString *lastLongitude;
@property (nonatomic,retain) IBOutlet UIButton *sendButton;

@property (nonatomic,retain) IBOutlet UILabel *NameField;
@property (nonatomic,retain) IBOutlet UILabel *TitleField;
@property (nonatomic,retain) IBOutlet UILabel *CompanyField;
@property (nonatomic,retain) IBOutlet UILabel *MobileField;
@property (nonatomic,retain) IBOutlet UILabel *PhoneField;
@property (nonatomic,retain) IBOutlet UILabel *ExtField;
@property (nonatomic,retain) IBOutlet UILabel *EmailField;
@property (nonatomic,retain) IBOutlet UILabel *TwitterField;
@property (nonatomic,retain) IBOutlet UILabel *NoteField;

@property (nonatomic,retain) BlueToothController *blueComm;


- (IBAction) sendCardNow;


@end
