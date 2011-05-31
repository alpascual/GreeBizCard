//
//  BlueToothController.h
//  GreenBizCard
//
//  Created by Albert Pascual on 4/6/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

#import "ContactManager.h"
#import "DetailsController.h"


@interface BlueToothController : NSObject < GKPeerPickerControllerDelegate, GKSessionDelegate>{
    
    GKPeerPickerController  *mPeerPicker;
    GKSession               *mSession;
}

@property (nonatomic, retain) GKPeerPickerController    *mPeerPicker;
@property (nonatomic, retain ) GKSession                *mSession;

-(void) nullifySession;
-(void) sendDataAction:(NSString *)myCard;

@end
