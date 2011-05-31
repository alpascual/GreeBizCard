//
//  WelcomeController.h
//  GreenBizCard
//
//  Created by Albert Pascual on 3/26/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WelcomeController : UIViewController <UIWebViewDelegate> {
    
    UIWebView *aWebView;
}

@property (nonatomic , retain) IBOutlet UIWebView *aWebView;

@end
