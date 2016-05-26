//
//  ViewController.h
//  googleMapsProject
//
//  Created by Robert Baghai on 11/17/15.
//  Copyright © 2015 Robert Baghai. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;

@interface ViewController : UIViewController <GMSMapViewDelegate>

@property (strong, nonatomic) NSMutableArray       *arrayOfMarkers;
@property (strong, nonatomic) NSMutableArray       *arrayOfSearchMarkers;
@property (strong, nonatomic) NSDictionary         *dictionaryOfSearchResults;
@property (strong, nonatomic) IBOutlet GMSMapView  *googleMapView;
@property (weak, nonatomic)   IBOutlet UIButton    *clearButton;
@property (weak, nonatomic)   IBOutlet UITextField *searchField;
@property (weak, nonatomic)   IBOutlet UIButton    *button;

- (IBAction)search:(id)sender;
- (IBAction)searchAction:(id)sender;
- (IBAction)clearPins:(id)sender;
- (IBAction)changeMapView:(id)sender;

@end

