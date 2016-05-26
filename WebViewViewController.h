//
//  WebViewViewController.h
//  googleMapsProject
//
//  Created by Robert Baghai on 11/17/15.
//  Copyright © 2015 Robert Baghai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebViewViewController : UIViewController

- (void)setURL:(NSString *)url;
@property (strong, nonatomic) NSURL     *myURL;
@property (strong, nonatomic) WKWebView *wkWeb;

@end
