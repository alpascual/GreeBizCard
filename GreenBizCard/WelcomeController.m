//
//  WelcomeController.m
//  GreenBizCard
//
//  Created by Albert Pascual on 3/26/11.
//  Copyright 2011 Al. All rights reserved.
//

#import "WelcomeController.h"


@implementation WelcomeController

@synthesize aWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.aWebView.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
    //NSURL *urlToOpen = [[NSURL alloc] initWithString:@"index.html"];
    NSURL *urlToOpen = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]];
    
    NSURLRequest *aReq = [NSURLRequest requestWithURL:urlToOpen];
    [self.aWebView loadRequest:aReq];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
	//[self.aLoadingIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
	/*[self.aLoadingIndicator stopAnimating];	
	[self.aLoadingIndicator stopAnimating];	
	[self.aLoadingIndicator stopAnimating];		
	*/
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	/*if ([self.aLoadingIndicator isAnimating]) {
		[self.aLoadingIndicator stopAnimating];
		[self.aLoadingIndicator stopAnimating];	
		[self.aLoadingIndicator stopAnimating];
	}*/
}

@end
