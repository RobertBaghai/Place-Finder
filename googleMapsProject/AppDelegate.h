//
//  AppDelegate.h
//  googleMapsProject
//
//  Created by Robert Baghai on 11/17/15.
//  Copyright © 2015 Robert Baghai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomInfo.h"
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow               *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) CustomInfo             *viewController;

@end

