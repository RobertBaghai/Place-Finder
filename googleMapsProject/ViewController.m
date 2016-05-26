//
//  ViewController.m
//  googleMapsProject
//
//  Created by Robert Baghai on 11/17/15.
//  Copyright © 2015 Robert Baghai. All rights reserved.
//

#import "ViewController.h"
#import "CustomInfo.h"
#import "MarkerPin.h"
#import "Constants.h"
#import "WebViewViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Google Maps";
    self.view.backgroundColor            = [UIColor blueColor];
    [self createPins];
    self.arrayOfSearchMarkers            = [[NSMutableArray alloc] init];
    self.button.backgroundColor          = [UIColor blackColor];
    self.clearButton.backgroundColor     = [UIColor blackColor];
    self.googleMapView.myLocationEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)createPins {
    GMSCameraPosition *camera   = [GMSCameraPosition cameraWithLatitude:40.7414444 longitude:-73.99007 zoom:15];
    GMSCameraPosition *camera2  = [GMSCameraPosition cameraWithLatitude:40.74087610000001 longitude:-73.98798139999997 zoom:12];
    GMSCameraPosition *camera3  = [GMSCameraPosition cameraWithLatitude:40.74345 longitude:-73.99146100000002 zoom:12];
    GMSCameraPosition *camera4  = [GMSCameraPosition cameraWithLatitude:40.7423606 longitude:-73.99238489999999 zoom:12];
    GMSCameraPosition *camera5  = [GMSCameraPosition cameraWithLatitude:40.7428259 longitude:-73.9886419 zoom:12];
    self.googleMapView.camera   = camera;
    self.googleMapView.delegate = self;
    
    MarkerPin *markerOne = [[MarkerPin alloc] init];
    markerOne.position = camera.target;
    markerOne.title    = @"TurnToTech";
    markerOne.snippet  = @"NYC";
    markerOne.image    = [UIImage imageNamed:@"turntotech.png"];
    markerOne.url      = @"http://www.turntotech.io";
    markerOne.icon     = [GMSMarker markerImageWithColor:[UIColor blueColor]];
    
    MarkerPin *markerTwo = [[MarkerPin alloc] init];
    markerTwo.position   = camera2.target;
    markerTwo.title      = @"Shake Shack";
    markerTwo.snippet    = @"NYC";
    markerTwo.image      = [UIImage imageNamed:@"burger.png"];
    markerTwo.url        = @"https://www.shakeshack.com";
    markerTwo.icon       = [GMSMarker markerImageWithColor:[UIColor greenColor]];
    
    MarkerPin *markerThree = [[MarkerPin alloc] init];
    markerThree.position   = camera3.target;
    markerThree.title      = @"Tappo Thin Crust Pizza";
    markerThree.snippet    = @"NYC";
    markerThree.image      = [UIImage imageNamed:@"pizza.png"];
    markerThree.url        = @"http://www.tappothincrust.com";
    markerThree.icon       = [GMSMarker markerImageWithColor:[UIColor greenColor]];
    
    MarkerPin *markerFour = [[MarkerPin alloc] init];
    markerFour.position   = camera4.target;
    markerFour.title      = @"Outback SteakHouse";
    markerFour.snippet    = @"NYC";
    markerFour.image      = [UIImage imageNamed:@"steak.png"];
    markerFour.url        = @"https://www.outback.com/menu/specials";
    markerFour.icon       = [GMSMarker markerImageWithColor:[UIColor greenColor]];
    
    MarkerPin *markerFive = [[MarkerPin alloc] init];
    markerFive.position   = camera5.target;
    markerFive.title      = @"Square Eats";
    markerFive.snippet    = @"NYC";
    markerFive.image      = [UIImage imageNamed:@"eats.png"];
    markerFive.url        = @"http://urbanspacenyc.com/mad-sq-eats/";
    markerFive.icon       = [GMSMarker markerImageWithColor:[UIColor greenColor]];
    
    self.arrayOfMarkers = [NSMutableArray arrayWithObjects:markerOne, markerTwo, markerThree, markerFour, markerFive, nil];
    for (MarkerPin *pin in self.arrayOfMarkers) {
        pin.map = self.googleMapView;
    }
}

- (UIView*)mapView:(GMSMapView*)mapView markerInfoWindow:(MarkerPin*)marker {
    CustomInfo *infoWindow        = [[[NSBundle mainBundle]loadNibNamed:@"CustomNib" owner:self options:nil]objectAtIndex:0];
    infoWindow.titleLabel.text    = marker.title;
    infoWindow.subTitleLabel.text = marker.snippet;
    infoWindow.leftImage.image    = marker.image;
    return infoWindow;
}

- (void)googleApiSearchRequest {
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *str = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=40.7414444,-73.99007&radius=1000&keyword=%@&key=%@",self.searchField.text, serverKey];
    [[session dataTaskWithURL:[NSURL URLWithString:str]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (error == nil) {
                    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
                        self.dictionaryOfSearchResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                        [self parseAndPin];
                        NSLog(@"%@",self.dictionaryOfSearchResults);
                    });
                }
            }]resume];
}

- (void)parseAndPin {
    NSDictionary *result    = [self.dictionaryOfSearchResults objectForKey:@"results"];
    NSDictionary *tempGeo   = [result valueForKey:@"geometry"];
    NSDictionary *tempLoc   = [tempGeo valueForKey:@"location"];
    NSArray *nameArray      = [result valueForKey:@"name"];
    NSArray *iconArray      = [result valueForKey:@"icon"];
    NSArray *latitudeArray  = [tempLoc valueForKey:@"lat"];
    NSArray *longitudeArray = [tempLoc valueForKey:@"lng"];
    
    for (int i = 0 ; i < latitudeArray.count; i++) {
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[[latitudeArray objectAtIndex:i] doubleValue]
                                                                longitude:[[longitudeArray objectAtIndex:i] doubleValue] zoom:12];
        NSString *string = [NSString stringWithFormat:@"%@",[iconArray objectAtIndex:i]];
        
        MarkerPin *searchMarker = [[MarkerPin alloc] init];
        searchMarker.position   = camera.target;
        searchMarker.title      = [NSString stringWithFormat:@"%@",[nameArray objectAtIndex:i]];
        searchMarker.snippet    = @"NYC";
        searchMarker.image      = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:string]]];
        searchMarker.url        = @"https://www.Google.com";
        searchMarker.icon       = [GMSMarker markerImageWithColor:[UIColor redColor]];
        
        self.arrayOfSearchMarkers = [NSMutableArray arrayWithObject:searchMarker];
        for (MarkerPin *pin in self.arrayOfSearchMarkers) {
            pin.map = _googleMapView;
        }
    }
}

- (IBAction)changeMapView:(id)sender {
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            self.googleMapView.mapType = kGMSTypeNormal;
            break;
        case 1:
            self.googleMapView.mapType = kGMSTypeSatellite;
            break;
        case 2:
            self.googleMapView.mapType = kGMSTypeHybrid;
            break;
        default:
            break;
    }
}

- (void)mapView:(GMSMapView*)mapView didTapInfoWindowOfMarker:(MarkerPin*)marker {
    WebViewViewController *web = [[WebViewViewController alloc] initWithNibName:@"WebViewViewController" bundle:nil];
    [web setURL:[NSString stringWithFormat:@"%@",marker.url]];
    web.title = marker.title;
    [self.navigationController pushViewController:web animated:YES];
}

- (IBAction)search:(id)sender {
    [self.searchField resignFirstResponder];
    [self.arrayOfSearchMarkers removeAllObjects];
    [self.googleMapView clear];
    [self createPins];
    [self googleApiSearchRequest];
}

- (IBAction)searchAction:(id)sender {
    [self.searchField resignFirstResponder];
    [self.arrayOfSearchMarkers removeAllObjects];
    [self.googleMapView clear];
    [self createPins];
    [self googleApiSearchRequest];
}

- (IBAction)clearPins:(id)sender {
    [self.googleMapView clear];
    self.searchField.text = nil;
    [self createPins];
}

@end
