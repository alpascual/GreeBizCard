//
//  GreenBizCardAppDelegate.h
//  GreenBizCard
//
//  Created by Albert Pascual on 3/15/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GreenBizCardAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
