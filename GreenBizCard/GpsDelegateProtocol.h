//
//  GpsDelegateProtocol.h
//  GreenBizCard
//
//  Created by Albert Pascual on 3/19/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol GpsDelegateProtocol <NSObject>


-(void) gpsFinished:(NSString*)latitude:(NSString*)longitude;

@end
