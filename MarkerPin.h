//
//  Marker.h
//  googleMapsProject
//
//  Created by Robert Baghai on 11/17/15.
//  Copyright © 2015 Robert Baghai. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GoogleMaps;

@interface MarkerPin : GMSMarker 

@property (nonatomic, strong)UIImage  *image;
@property (nonatomic, strong)NSString *url;

@end
