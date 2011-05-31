//
//  BlueToothController.m
//  GreenBizCard
//
//  Created by Albert Pascual on 4/6/11.
//  Copyright 2011 Al. All rights reserved.
//

#import "BlueToothController.h"


@implementation BlueToothController

@synthesize mPeerPicker, mSession;

-(void) sendDataAction:(NSString *)myCard{
    if(mSession){
        [self.mSession sendDataToAllPeers:[myCard dataUsingEncoding:NSStringEncodingConversionAllowLossy] withDataMode:GKSendDataReliable error:nil];
    }else{
        self.mPeerPicker = [[[GKPeerPickerController alloc] init] autorelease];
        mPeerPicker.delegate = self;
        mPeerPicker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
        [mPeerPicker show];
    }
}


- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type{  
    self.mSession = [[[GKSession alloc] initWithSessionID:@"GreenBizCard" displayName:nil sessionMode:GKSessionModePeer] autorelease];
    mSession.delegate = self;
    return mSession;
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker{
    [self nullifySession];
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error{
    [self nullifySession];
}

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session{
    [mSession setDataReceiveHandler:self withContext:NULL];
    [mPeerPicker dismiss];
    self.mPeerPicker = nil;
    
    // Connected send the card
    //[cmdButton setTitle:@"Send" forState:UIControlStateNormal];
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context{
    //textArea.text = [NSString stringWithFormat:@"%@\n%@> %@", textArea.text , [mSession displayNameForPeer:peer], [NSString stringWithUTF8String:[data bytes]]];
    
    NSString *temp = [NSString stringWithUTF8String:[data bytes]];
    NSMutableDictionary *listCards = [[NSMutableDictionary alloc] init];
    
    //Received the card
    NSRange firstRange = [temp rangeOfString:@"|"];
    
    if ( firstRange.length > 0 )
    {
        NSArray *chunks = [temp componentsSeparatedByString: @"|"];
        
        for (NSString *t in chunks) 
        {
            NSRange startRange = [t rangeOfString:@"~"];
            if ( startRange.length > 0 )
            {
                NSArray *fields = [t componentsSeparatedByString: @"~"];        
                [listCards setObject:[fields objectAtIndex:1] forKey:[fields objectAtIndex:0]];
            }
        }
    }
    
    NSArray *keys = [listCards allKeys];
    NSString *key = [keys objectAtIndex:0];    
    
    ContactManager *contacts = [[ContactManager alloc] init];
    ABRecordRef newPerson = [contacts GetPerson:key];
    NSArray *rawPerson = [contacts GetRawPerson:key];
    
    DetailsController *details = [[DetailsController alloc] initWithNibName:@"DetailsController" bundle:nil person:newPerson raw:rawPerson];
    
    //donotcompile
    // TODO call a delegate and pass the contact to it 
    //[self.navigationController pushViewController:details animated:YES];
    [self presentModalViewController:details animated:YES];
    
    [contacts release];
    
}

-(void) nullifySession{
    if(mSession) {
        [mSession disconnectFromAllPeers]; 
        [mSession setDataReceiveHandler: nil withContext: NULL]; 
        self.mSession = nil;
    }
    //[cmdButton setTitle:@"Start" forState:UIControlStateNormal];
}


@end
