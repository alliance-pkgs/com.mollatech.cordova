//
//  MobileLocationDetails.h
//  AxiomTrust
//
//  Created by nilesh kamble on 18/11/13.
//  Copyright (c) 2013 Mollatech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface AxiomLocation : NSThread <CLLocationManagerDelegate> {

NSString *_country;
NSString *_state;
NSString *_city;
NSString *_longitude;
NSString *_latitude;
NSString *_ipAddress;
    NSString * _zipcode;
CLLocationManager *locationManager;
}
@property(nonatomic,retain) NSString *country;
@property(nonatomic,retain) NSString *state;

@property(nonatomic,retain) NSString *city;

@property(nonatomic,retain) NSString *longitude;

@property(nonatomic,retain) NSString *latitude;

@property(nonatomic,retain) NSString *ipAddress;
@property(nonatomic,retain) NSString *zipcode;
@property (nonatomic, retain) CLLocationManager *locationManager;
-(void)start;
-(void)stop;


@end
