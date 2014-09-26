//
//  DEMOViewController.m
//  UIWebView
//
//  Created by Aditya on 12/11/13.
//  Copyright (c) 2013 Aditya. All rights reserved.
//

#import "DEMOViewController.h"

@interface DEMOViewController ()

@end

@implementation DEMOViewController


-(IBAction)launch:(id)sender
{
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"html"];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlFile]; //this is to find the URL for where the file directory is
    
    //this line reads from the sample.html file and then puts the contents into a NSString
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    //the webpage loads the string! the BaseURl parameters sets the file directory so that the HTML can find other files in its directory
    [webPage loadHTMLString:htmlString baseURL:baseURL];
}

- (IBAction)myButton:(id)sender {
    //Execute javascript method or pure javascript if needed
    [webPage stringByEvaluatingJavaScriptFromString:@"alertHello();"];
}

- (void)viewDidLoad
{
    imview.image=[UIImage imageNamed:@"logo.png"];

    [super viewDidLoad];
    [self launch:self];
    webPage.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
}

// This function is called on all location change :
- (BOOL)webView:(UIWebView *)webView2
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *requestString = [[request URL] absoluteString] ;
    
    // Intercept custom location change, URL begins with "js-call:"
    if ([requestString hasPrefix:@"js-call:"]) {
        
        // Extract the selector name from the URL
        NSArray *components = [requestString componentsSeparatedByString:@":"];
        NSString *function = [components objectAtIndex:1];
        
        // Call the given selector
        [self performSelector:NSSelectorFromString(function)];
        
        // Cancel the location change
        return NO;
    }
    
    // Accept this location change
    return YES;
    
}

- (void)myObjectiveCFunction {
    
    NSLog(@"calling objective C from html button with javascript");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
