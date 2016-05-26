//
//  WebViewViewController.m
//  googleMapsProject
//
//  Created by Robert Baghai on 11/17/15.
//  Copyright © 2015 Robert Baghai. All rights reserved.
//

#import "WebViewViewController.h"
#import "CustomInfo.h"
#import "MarkerPin.h"

@interface WebViewViewController ()

@end

@implementation WebViewViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest *req = [NSURLRequest requestWithURL:self.myURL];
    self.wkWeb        = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.wkWeb loadRequest:req];
    self.wkWeb.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y,
                              self.view.frame.size.width, self.view.frame.size.height);
    self.view = self.wkWeb;
}

-(void)setURL:(NSString *)url
{
    self.myURL = [NSURL URLWithString:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
